Class Feeder.FeederProduction Extends Ens.Production Depends On Ens.Production
{

/*
For new namespaces, InterSystems recommends that you specify different databases for routines and globals.

// https://docs.intersystems.com/irisforhealth20201/csp/docbook/Doc.View.cls?KEY=EGMG_storage
In most cases, productions are defined and run in the same namespace, but you can use InterSystems IRIS package mapping 
	to make a production class visible in a namespace other than the one it is defined in. 
	If you use package mapping and a production is visible in more than one namespace, 
	you should designate only one of these namespaces to compile and run the production, 
	You should not compile, modify, or run the production in any other namespace. 
	If you run or modify the same production in more than one namespace it can cause failures that are hard to diagnose. 
	Under no circumstances should you do this. 
	If you do not use package mapping to map a database to a namespace you do not need to be concerned about this issue.

// https://docs.intersystems.com/irisforhealth20201/csp/docbook/DocBook.UI.Page.cls?KEY=EGMG_C175393
You should always compile the production on the system that it is running. 
	Although you can compile InterSystems IRIS code on one system and copy the database “pre-compiled” to another system, 
	you should not attempt this with interoperability-enabled namespaces.
*/
XData ProductionDefinition
{
<Production Name="Feeder.FeederProduction" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="File Passthrough Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/tmp/</Setting>
    <Setting Target="Adapter" Name="FileSpec">IVA*</Setting>
    <Setting Target="Adapter" Name="ConfirmComplete">0</Setting>
    <Setting Target="Host" Name="TargetConfigNames">DLA Operation</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
  </Item>
  <Item Name="FTP Operation" Category="" ClassName="EnsLib.FTP.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FTPPort">2022</Setting>
    <Setting Target="Adapter" Name="Credentials">CCS</Setting>
    <Setting Target="Adapter" Name="SFTPAuthenticationMethods">p</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath"></Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">ugo+rw</Setting>
  </Item>
  <Item Name="CCS Feeder Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/tmp/</Setting>
    <Setting Target="Adapter" Name="FileSpec">CCS*</Setting>
    <Setting Target="Adapter" Name="ConfirmComplete">0</Setting>
    <Setting Target="Host" Name="TargetConfigNames">FTP Operation</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
    <Setting Target="Adapter" Name="WorkPath"></Setting>
  </Item>
  <Item Name="PEX Operation" Category="" ClassName="Feeder.MIMEOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="Port">9980</Setting>
    <Setting Target="Host" Name="URL"></Setting>
  </Item>
  <Item Name="POC Operation" Category="" ClassName="Feeder.POCOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Host" Name="FailureTimeout">600</Setting>
    <Setting Target="Host" Name="RetryInterval">300</Setting>
    <Setting Target="Adapter" Name="Credentials">POC</Setting>
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="URL">/csp/healthshare/poc/IncomingPOC/GetInternalCustomerCatalog?SiteID=668</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Adapter" Name="SSLConfig">DMLSS_CLIENT</Setting>
  </Item>
  <Item Name="POC Feeder Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">POC Operation</Setting>
    <Setting Target="Adapter" Name="FilePath">/tmp/</Setting>
    <Setting Target="Adapter" Name="FileSpec">poc*</Setting>
  </Item>
  <Item Name="POU Feeder Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/tmp/</Setting>
    <Setting Target="Adapter" Name="FileSpec">pou*</Setting>
    <Setting Target="Host" Name="TargetConfigNames">POU Operation</Setting>
  </Item>
  <Item Name="POU Operation" Category="" ClassName="Feeder.POUOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="URL">/csp/healthshare/pou/IncomingPOU668/Upload</Setting>
    <Setting Target="Adapter" Name="Credentials">POU</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="SSLConfig">DMLSS_CLIENT</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
  </Item>
  <Item Name="FSC Operation" Category="" ClassName="Feeder.FSCOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="SSLConfig">DMLSS_CLIENT</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="URL"><![CDATA[/csp/healthshare/restpassthrough/IncomingFSC/oblh?SITEID=668&tnum=636T82481&lnum=002]]></Setting>
  </Item>
  <Item Name="FSC Feeder Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">FSC Operation</Setting>
    <Setting Target="Adapter" Name="FilePath">/tmp/</Setting>
    <Setting Target="Adapter" Name="FileSpec">fsc*</Setting>
  </Item>
  <Item Name="CAPuser Operation" Category="" ClassName="EnsLib.FTP.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FTPPort">2022</Setting>
    <Setting Target="Adapter" Name="Credentials">CAP</Setting>
    <Setting Target="Adapter" Name="SFTPAuthenticationMethods">k</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath"></Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">ugo+rw</Setting>
    <Setting Target="Adapter" Name="SFTPPrivateKeyFile">/ICS/home/CAPuser/.ssh/id_rsa</Setting>
    <Setting Target="Adapter" Name="SFTPPublicKeyFile">/ICS/home/CAPuser/.ssh/id_rsa.pub</Setting>
    <Setting Target="Adapter" Name="SSLConfig"></Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
  </Item>
  <Item Name="FMS Feeder Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/tmp/dct/</Setting>
    <Setting Target="Adapter" Name="FileSpec">IVAFMS-DCT*</Setting>
    <Setting Target="Adapter" Name="ConfirmComplete">0</Setting>
    <Setting Target="Host" Name="TargetConfigNames">CAPuser Operation</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="DLA Operation" Category="" ClassName="Feeder.DLAOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="URL">/csp/healthshare/dlain/IncomingDLAIN/</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Adapter" Name="SSLConfig">DMLSS_CLIENT</Setting>
    <Setting Target="Adapter" Name="Credentials"></Setting>
  </Item>
  <Item Name="certsubmit" Category="" ClassName="Feeder.certsubmit" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="URL">/msg_data/certsubmit?channel=DMLSS-TE1VR-O-RCOM</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Adapter" Name="SSLConfig">DMLSS_CLIENT</Setting>
    <Setting Target="Adapter" Name="Credentials"></Setting>
    <Setting Target="Adapter" Name="HTTPServer">scm-iris-tls-webgateway.apps.vapo-aws-dsoi-dev.va.gov</Setting>
  </Item>
  <Item Name="Upload" Category="" ClassName="Feeder.Upload" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials"></Setting>
    <Setting Target="Adapter" Name="SSLConfig">DMLSS_CLIENT</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="HTTPServer">dmlss-iris-dev-nlb-3b3cc3b1c3786beb.elb.us-gov-west-1.amazonaws.com</Setting>
    <Setting Target="Adapter" Name="URL">/dmlss/edidaasc/Upload?SITEID=668</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
  </Item>
  <Item Name="Upload Feeder Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/tmp/upload</Setting>
    <Setting Target="Adapter" Name="FileSpec">*</Setting>
    <Setting Target="Adapter" Name="ConfirmComplete">0</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Upload</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="certsubmit-nlb" Category="" ClassName="Feeder.certsubmit" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="URL">/msg_data/certsubmit?channel=DMLSS-TE1VR-O-RCOM</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Adapter" Name="SSLConfig">DMLSS_CLIENT</Setting>
    <Setting Target="Adapter" Name="Credentials"></Setting>
    <Setting Target="Adapter" Name="HTTPServer">dmlss-iris-dev-nlb-3b3cc3b1c3786beb.elb.us-gov-west-1.amazonaws.com</Setting>
  </Item>
  <Item Name="DCT Operation" Category="" ClassName="EnsLib.FTP.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FTPPort">2022</Setting>
    <Setting Target="Adapter" Name="Credentials">CAP</Setting>
    <Setting Target="Adapter" Name="SFTPAuthenticationMethods">p</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath"></Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">ugo+rw</Setting>
    <Setting Target="Adapter" Name="FTPServer">dmlss-iris-dev-nlb-3b3cc3b1c3786beb.elb.us-gov-west-1.amazonaws.com</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="FSC deletedVendors Operation" Category="" ClassName="Feeder.FSCOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="SSLConfig">DMLSS_CLIENT</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="FSC deletedVendors Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">FSC deletedVendors Operation</Setting>
    <Setting Target="Adapter" Name="FilePath">/tmp/</Setting>
    <Setting Target="Adapter" Name="FileSpec">dvfsc*</Setting>
  </Item>
  <Item Name="PYXIS Feeder Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/tmp/</Setting>
    <Setting Target="Adapter" Name="FileSpec">py*</Setting>
    <Setting Target="Host" Name="TargetConfigNames">PYXIS Operation</Setting>
  </Item>
  <Item Name="PYXIS Operation" Category="" ClassName="EnsLib.FTP.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FTPPort">2022</Setting>
    <Setting Target="Adapter" Name="Credentials">PYXIS</Setting>
    <Setting Target="Adapter" Name="SFTPAuthenticationMethods">p</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath"></Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">u+rw,g+r</Setting>
    <Setting Target="Adapter" Name="FTPServer">dmlss-iris-dev-nlb-3b3cc3b1c3786beb.elb.us-gov-west-1.amazonaws.com</Setting>
    <Setting Target="Host" Name="FailureTimeout">5</Setting>
  </Item>
  <Item Name="Wavemark Operation" Category="" ClassName="EnsLib.FTP.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FTPPort">2022</Setting>
    <Setting Target="Adapter" Name="Credentials">Wavemark</Setting>
    <Setting Target="Adapter" Name="SFTPAuthenticationMethods">p</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath"></Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">u+rw,g+r</Setting>
    <Setting Target="Adapter" Name="FTPServer">dmlss-iris-dev-nlb-3b3cc3b1c3786beb.elb.us-gov-west-1.amazonaws.com</Setting>
    <Setting Target="Host" Name="FailureTimeout">5</Setting>
  </Item>
  <Item Name="Wavemark Feeder Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/tmp/</Setting>
    <Setting Target="Adapter" Name="FileSpec">w*</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Wavemark Operation</Setting>
  </Item>
  <Item Name="UploadFiles" Category="" ClassName="Feeder.certsubmit" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials"></Setting>
    <Setting Target="Adapter" Name="SSLConfig">DMLSS_CLIENT</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="HTTPServer">dmlss-iris-dev-nlb-3b3cc3b1c3786beb.elb.us-gov-west-1.amazonaws.com</Setting>
    <Setting Target="Adapter" Name="URL">/dmlss/edidaasc/Upload?TargetOp=POCResponseFile663</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
  </Item>
  <Item Name="UploadFiles Feeder Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/tmp/upload</Setting>
    <Setting Target="Adapter" Name="FileSpec">Response_663*</Setting>
    <Setting Target="Adapter" Name="ConfirmComplete">0</Setting>
    <Setting Target="Host" Name="TargetConfigNames">UploadFiles</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="CDW Operation" Category="" ClassName="Feeder.UploadFiles" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials"></Setting>
    <Setting Target="Adapter" Name="SSLConfig">DMLSS_CLIENT</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="URL">/csp/healthshare/restpassthrough/IncomingCDW?SITEID=556</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
  </Item>
  <Item Name="CDW Feeder Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/tmp/cdw</Setting>
    <Setting Target="Adapter" Name="FileSpec">*tgz</Setting>
    <Setting Target="Adapter" Name="ConfirmComplete">1</Setting>
    <Setting Target="Host" Name="TargetConfigNames">CDW Operation</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
</Production>
}

}
