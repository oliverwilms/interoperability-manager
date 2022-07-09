Class User.Util
{

ClassMethod CallRESTapi(pIris As %String, pUrl As %String, ByRef pResponseData As %DynamicObject, pType As %String = "GET") As %Status
{
	#define maxRetries 2
	#define timeout 3
	Do ..DebugTEST("Feeder.Util - CallRESTapi")
	Do ..DebugTEST("pIris = "_$Get(pIris))
	Do ..DebugTEST("pUrl = "_$Get(pUrl))
	Set tErrorCount = 0
	Set tParamIRIS = pIris
	If (pIris = 0) Set pIris = "127.0.0.1:52773"
	Set tServer = $Piece(pIris,":",1)
	Set tPort = $Piece(pIris,":",2)
	Do {
		Set tRetryFlag = 0
		Set pResponse = $$$NULLOREF
		Set tRequest = ##class(%Net.HttpRequest).%New()
		If (tPort = 443) {
			Set tRequest.Https = 1
			Set tRequest.SSLConfiguration = "???"
			Do ..DebugTEST("SSLConfiguration = "_tRequest.SSLConfiguration)
		}

		// InitiateAuthentication does not exist in HealthShare versions
		Try {
			//Supported schemes are Negotiate, NTLM and Basic.
			Set tRequest.InitiateAuthentication = "Basic"
			Set tRequest.Username = "_SYSTEM"
			Set tRequest.Password = "SYS"
		} Catch {
		}

		//Set tRequest.Server = ""  // This defaults to 'localhost', i.e. your current machine if not specified.
		Set tRequest.Port = tPort
		If (tServer '= "") Set tRequest.Server = tServer
		Set tRequest.Timeout = $$$timeout
    Set type = $Get(pType)
		Set location = $Get(pUrl)
		Set location = ##class(%CSP.Page).EscapeURL(location)
		Set test = 0
		Set reset = 1
		Set tSC = tRequest.Send(type,location,test,reset)
		If $$$ISERR(tSC) Do ..DebugStatus(tSC)
		If (tPort = 443) {
			Do ..DebugTEST("SSLError = "_tRequest.SSLError)
		}
		Set pResponse = tRequest.HttpResponse
		If $IsObject(pResponse) {
			If (pResponse.StatusCode '= 200) {
				Do ..DebugTEST("StatusCode = "_pResponse.StatusCode)
				Do ..DebugTEST("ReasonPhrase = "_pResponse.ReasonPhrase)
			}
			If (pResponse.StatusCode = 500) {  // Internal Server Error
				If $Increment(tErrorCount) <= $$$maxRetries Set tRetryFlag = 1
			}
		} Else {
			Do ..DebugTEST("HttpResponse = "_pResponse)
		}
	} While tRetryFlag

	If $IsObject(pResponse) {
		#dim tDataStream As %Stream.GlobalBinary
		Set tDataStream = pResponse.Data
		Set tDataString = tDataStream.Read(.len,.sc)
		If $$$ISOK(sc) {
			Do ..DebugTEST("tDataString = "_tDataString)
		} Else {
			Do ..DebugTEST("Data = "_pResponse.Data)
			Do ..DebugTEST("len = "_$Get(len))
			Do ..DebugStatus(sc)
		}
		Try {
			Set pResponseData = ##class(%DynamicObject).%FromJSON(tDataString)
		}
		Catch {
			Set tSC = $$$ERROR($$$GeneralError,"JSON error")
			If (pResponse.StatusCode '= 200) {
				Set tSC = $$$ERROR($$$GeneralError,"Response was "_pResponse.StatusCode_" / "_pResponse.ReasonPhrase)
			}
			Do ..DebugStatus(tSC)
		}
	}
	If $$$ISOK(tSC) {
		Quit tSC
	}
	Set pIris = $Get(tParamIRIS,pIris)
  Set tRESTapiErr = $Get(^myRESTapiErr(pIris),0)
	Set ^myRESTapiErr(pIris) = $Increment(tRESTapiErr)
	Quit tSC
}

}
