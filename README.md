 [![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/interoperability-manager)
 [![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Finteroperability-manager&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Finteroperability-manager)
 [![Reliability Rating](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Finteroperability-manager&metric=reliability_rating)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Finteroperability-manager)
# interoperability-manager created from InterSystems IRIS Full Stack demo and template
I was inspired to create this app when I read a post on Developer Community.

I include a sample Production 

![screenshot](https://github.com/oliverwilms/bilder/blob/main/Capture_Production.PNG)
## Do you want to delete a Production Item with two clicks?
Direct your browser to URL: http://localhost:57700/irisapp/ProductionManager.csp
### First click on any item in the "Remove Item" column ...![screenshot](https://github.com/oliverwilms/bilder/blob/main/ProductionManager.PNG)
### Second click OK button, if you are sure.![screenshot](https://github.com/oliverwilms/bilder/blob/main/Capture_Prompt_Remove.PNG)
## ZPM Package Manager
This module is zpm-packaged, which means that it is described with [module.xml](https://github.com/oliverwilms/interoperability-manager/blob/master/module.xml) and available in public repository and installable with:
zpm "install interoperability-manager"
## Installation
### Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.
### Docker way
Clone the repo, run:
```
docker-compose up -d
```

### ZPM way
Open IRIS terminal and run ZPM:
```
USER>zpm
zpm:USER>install "interoperability-manager"
```
After ZPM installation, access the application at URL: http://yourserver:yourport/csp/irisapp/index.html#/

or go directly to Production Manager at URL: http://yourserver:yourport/csp/irisapp/ProductionManager.csp

## interoperability-manager Unit Test

Open IRIS terminal using IRISAPP namespace:

```
docker-compose exec iris iris session iris -U IRISAPP
```

The first command needs to be run once
```
Set ^UnitTestRoot="/opt/unittests"
```

This app utilizes a specific directory for UnitTests. The directory name, in this case interoperability-manager, is the name for a suite of tests and is also a child of the directory specified by ^UnitTestRoot. Running %UnitTest.Manager.RunTest(“interoperability-manager”) runs all of the tests stored in the interoperability-manager directory. Since we are using .cls files rather than XML files, we must supply the /loadudl qualifier to RunTest.
```
Do ##class(%UnitTest.Manager).RunTest("interoperability-manager","/loadudl")
```

```
IRISAPP>Do ##class(%UnitTest.Manager).RunTest("interoperability-manager","/loadudl")

===============================================================================
Directory: /opt/unittests/interoperability-manager/
===============================================================================
  interoperability-manager begins ...
Load of directory started on 07/09/2022 15:23:18 '*.xml;*.XML;*.cls;*.mac;*.int;*.inc;*.CLS;*.MAC;*.INT;*.INC'

Loading file /opt/unittests/interoperability-manager/test.cls as udl

Compilation started on 07/09/2022 15:23:18 with qualifiers '/loadudl'
Compiling class UnitTest.interoperability.manager.test
Compiling routine UnitTest.interoperability.manager.test.1
Compilation finished successfully in 0.042s.

Load finished successfully.

    UnitTest.interoperability.manager.test begins ...
      TestRESTapi() begins ...
1  CCS Feeder Service 1
2  CDW Feeder Service 1
3  FMS Feeder Service 1
4  FSC Feeder Service 1
5  FSC deletedVendors Service 1
6  File Passthrough Service 1
7  POC Feeder Service 1
8  POU Feeder Service 1
9  PYXIS Feeder Service 1
10  Upload Feeder Service 0
11  UploadFiles Feeder Service 1
12  Wavemark Feeder Service 1
13  CAPuser Operation 1
14  DCT Operation 1
15  FTP Operation 1
16  PYXIS Operation 1
17  Wavemark Operation 1
        LogMessage:17 ConfigItems before.
        AssertEquals:CallRESTapi (passed)
1  CCS Feeder Service 1
2  CDW Feeder Service 1
3  FMS Feeder Service 1
4  FSC Feeder Service 1
5  File Passthrough Service 1
6  POC Feeder Service 1
7  POU Feeder Service 1
8  PYXIS Feeder Service 1
9  Upload Feeder Service 0
10  UploadFiles Feeder Service 1
11  Wavemark Feeder Service 1
12  CAPuser Operation 1
13  DCT Operation 1
14  FTP Operation 1
15  PYXIS Operation 1
16  Wavemark Operation 1
        LogMessage:16 ConfigItems after.
        AssertEquals:TestRESTapi (passed)
        LogMessage:Duration of execution: 1.16711 sec.
      TestRESTapi passed
    UnitTest.interoperability.manager.test passed
  interoperability-manager passed

Use the following URL to view the result:
http://172.18.0.2:52773/csp/sys/%25UnitTest.Portal.Indices.cls?Index=2&$NAMESPACE=IRISAPP
All PASSED
```
