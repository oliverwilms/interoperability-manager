Class App.Installer
{

XData setup
{
<Manifest>
  <Default Name="APPDIR" Dir="#{$system.Process.CurrentDirectory()}" />
  <Default Name="SourceDir" Dir="${APPDIR}/src" />
  <Default Name="NAMESPACE" Value="FEEDER" />
  <Default Name="APPURL" Value="/csp/feeder" />
  <Default Name="RESTURL" Value="/rest/feeder" />
  <Default Name="CSPPATH" Dir="/opt/irisapp/csp" />
  <Default Name="DBRESOURCE" Value="%DB_${NAMESPACE}" />

  <Resource Name="${DBRESOURCE}" Description="" Permission="RW"/>

  <Namespace Name="${NAMESPACE}" Code="${NAMESPACE}" Data="${NAMESPACE}" Create="yes" Ensemble="1">
    <Configuration>
      <Database Name="${NAMESPACE}" Dir="${APPDIR}/db/${NAMESPACE}" Resource="${DBRESOURCE}" Create="yes" />
    </Configuration>
    <Import File="${SourceDir}" Flags="ck" Recurse="1"/>
    <CSPApplication 
      Url="${APPURL}"
      Description=""
      Directory="${CSPPATH}"
      Resource=""
      Grant="${DBRESOURCE}"
      Recurse="1"
      LoginClass=""
      CookiePath="${APPURL}"
      AuthenticationMethods="32" />
  </Namespace>
  <If Condition='(##class(Security.Applications).Exists("/feederapp")=0)'>
    <Log Text="Creating web application /feederapp" Level="0"/>
    <RunInstall Class="App.Installer" Method="CreateWebAppFeederapp"/>
  </If>
  <Invoke Class="App.Installer" Method="SetupREST" CheckStatus="1">
    <Arg Value="${NAMESPACE}"/>
    <Arg Value="${RESTURL}"/>
    <Arg Value="${DBRESOURCE}"/>
    <Arg Value="Demo.CoffeeMakerRESTServer"/>
  </Invoke>

</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  #; Let XGL document generate code for this method. 
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

ClassMethod CreateWebAppFeederapp(pVars, pLogLevel, tInstaller) As %Status
{
  New $Namespace
  Set $Namespace = "%SYS"
  Set cspName = "/feederapp"
  Set cspProperties("NameSpace") = $Get(Namespace,"FEEDER")
  Set cspProperties("Enabled") = 1
  Set cspProperties("AutheEnabled") = $$$AutheUnauthenticated + $$$AutheCache
  Set cspProperties("DeepSeeEnabled") = 1
  Set cspProperties("iKnowEnabled") = 0
  Set cspProperties("Path") = "/opt/irisapp/csp/"
  Set cspProperties("Resource") = ""
  Set cspProperties("ServeFiles") = 1
  Set tSC = ##class(Security.Applications).Create(cspName,.cspProperties)
  Do tInstaller.PopNS()
  If $$$ISERR(tSC) Throw ##class(%Installer.Exception).CreateFromStatus(tSC)
  Quit $$$OK
}

ClassMethod SetupREST(pNameSpace As %String, pUrl As %String, pResource As %String, pClass As %String) As %Status
{
  New $Namespace
  Set $Namespace = "%SYS"
  Set p("NameSpace") = pNameSpace
  Set p("MatchRoles") = ":"_pResource
  Set p("DispatchClass") = pClass
  Quit ##class(Security.Applications).Create(pUrl, .p)
}

}
