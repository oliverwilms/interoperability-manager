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

Open IRIS terminal:

```
docker-compose exec iris iris session iris
```

The first command needs to be run once
```
Set ^UnitTestRoot="/opt/unittests"
```

This app utilizes a specific directory for UnitTests. The directory name, in this case interoperability-manager, is the name for a suite of tests and is also a child of the directory specified by ^UnitTestRoot. Running %UnitTest.Manager.RunTest(“interoperability-manager”) runs all of the tests stored in the interoperability-manager directory. Since we are using .cls files rather than XML files, we must supply the /loadudl qualifier to RunTest.
```
Do ##class(%UnitTest.Manager).RunTest("interoperability-manager","/loadudl")
```
