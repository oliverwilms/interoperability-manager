Class App.Installer
{

XData setup
{
<Manifest>
  <Default Name="APPDIR" Dir="#{$system.Process.CurrentDirectory()}" />
  <Default Name="SourceDir" Dir="${APPDIR}/src" />
  <Default Name="NAMESPACE" Value="IRISAPP" />
  <Default Name="APPURL" Value="/csp/irisapp" />
  <Default Name="RESTURL" Value="/rest/irisapp" />
  <Default Name="CSPPATH" Dir="/opt/irisapp/csp" />
  <Default Name="DBRESOURCE" Value="%DB_${NAMESPACE}" />

  <Resource Name="${DBRESOURCE}" Description="" Permission="RW"/>

  <Namespace Name="${NAMESPACE}" Code="${NAMESPACE}" Data="${NAMESPACE}" Create="yes" Ensemble="1">
    <Configuration>
      <Database Name="${NAMESPACE}" Dir="${APPDIR}/db/irisapp" Resource="${DBRESOURCE}" Create="yes" />
      <Import File="${SourceDir}" Flags="ck" Recurse="1"/>
    </Configuration>
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
