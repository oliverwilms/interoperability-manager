Class UnitTest.interoperability.manager.test Extends %UnitTest.TestCase
{

ClassMethod Go() As %Status
{
	Set ^UnitTestRoot="/opt/unittests"
	Set tSC = ##class(%UnitTest.Manager).RunTest("interoperability-manager","/loadudl")
	Quit tSC
}

Method TestDemo2()
{
	Set tDir = "/opt/transform/practice"
	Set tFilesDemo2 = "output_DE*"  // filename after BPL
	Set tCountBefore = ##class(dc.iris.util).FilesCount(tDir,tFilesDemo2)
	Do ..LogMessage(tCountBefore_" "_tFilesDemo2_" files before.")
	Set tSC = ##class(dc.iris.facture).TestProductDefined()
	Do $$$AssertEquals(tSC,1, "TestProductDefined")
	Set tMakeFilesQuantity = 2
	Do ..LogMessage("tMakeFilesQuantity = "_tMakeFilesQuantity)
	Set tSC = ##class(dc.iris.facture).Manufacture(2,tMakeFilesQuantity)
	Do $$$AssertEquals(tSC,1, "Manufacture")
	// Allow time to transform file(s)
	Hang 15
	Set tCountAfter = ##class(dc.iris.util).FilesCount(tDir,tFilesDemo2)
	Do ..LogMessage(tCountAfter_" "_tFilesDemo2_" files after 15 seconds.")
	Do $$$AssertEquals(tCountAfter,(tCountBefore+tMakeFilesQuantity),"Files count")
}

}
