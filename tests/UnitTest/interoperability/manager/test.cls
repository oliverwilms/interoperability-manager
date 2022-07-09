Class UnitTest.interoperability.manager.test Extends %UnitTest.TestCase
{

ClassMethod Go() As %Status
{
	Set ^UnitTestRoot="/opt/unittests"
	Set tSC = ##class(%UnitTest.Manager).RunTest("interoperability-manager","/loadudl")
	Quit tSC
}

Method TestRESTapi()
{
	Set tCountBefore = ##class(User.ProductionMonitor).GetConfigItems()
	Do ..LogMessage(tCountBefore_" ConfigItems before.")
	Set tConfigItem = "FSC deletedVendors Service"
	Set tType = "POST"
	Set tURL = "/rest/irisapp/Production/Item/Remove/"_tConfigItem
	//Set tURL = ##class(%CSP.Page).EscapeURL(tURL)
	Set tSC = ##class(User.Util).CallRESTapi(0,tURL,.tResponseData,tType)
	Do $$$AssertEquals(tSC,1, "CallRESTapi")
	// Allow time to save Production
	Hang 1
	Set tCountAfter = ##class(User.ProductionMonitor).GetConfigItems()
	Do ..LogMessage(tCountAfter_" ConfigItems after.")
	Do $$$AssertEquals(tCountAfter,(tCountBefore-1),"TestRESTapi")
}

}
