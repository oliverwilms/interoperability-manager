Class User.REST Extends %CSP.REST
{

Parameter UseSession As Integer = 1;

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/Production/Item/Remove/:ConfigItemName" Method="POST" Call="PostProdItemRemove" />
</Routes>
}
ClassMethod DebugTEST(strMessage As %String = "") As %Status
{
	Set ^TESTapi($I(^TESTapi)) = $ZDateTime($NOW(),8,1,3)_" : "_$JOB_" : "_strMessage
	Quit $$$OK
}

ClassMethod StatusToText(pStatus As %Status) As %String
{
	Set tReturn = $System.Status.GetOneErrorText(pStatus)
	Quit tReturn
}

ClassMethod DebugStatus(pStatus As %Status) As %Status
{
	Set tStatus = ..StatusToText(pStatus)
	Quit ..DebugTEST(tStatus)
}

ClassMethod PostProdItemRemove(pConfigItemName As %String) As %Status
{
	Do ..DebugTEST("User.REST - PostProdItemRemove - "_pConfigItemName)
	Set pProd = ##class(Ens.Director).GetActiveProductionName()
	Do ..DebugTEST("pProd = "_pProd)
	Set tProduction = ##class(Ens.Config.Production).%OpenId(pProd)
	Set tItem = tProduction.FindItemByConfigName(pConfigItemName,.tSC)
	Do ..DebugStatus(tSC)
	If $$$ISERR(tSC) { Quit tSC }
	Do ..DebugTEST("tItem = "_$Get(tItem))
	Do tProduction.RemoveItem(tItem)
	Set tSC = tProduction.%Save()

	Set status = ..StatusToText(tSC)
	Set data = {}
	Set data.Status = status
	Write data.%ToJSON()
	Quit tSC
}

ClassMethod TEST(FILENAME As %String = "") As %Status
{
	Do ..DebugTEST("User.REST - TEST")
	Quit $$$OK
}

}
