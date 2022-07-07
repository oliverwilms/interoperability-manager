 [![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/iris-fullstack-template)
 [![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Firis-fullstack-template&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Firis-fullstack-template)
 [![Reliability Rating](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Firis-fullstack-template&metric=reliability_rating)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Firis-fullstack-template)
# interoperability-manager created from InterSystems IRIS Full Stack demo and template
This repository contains a sample application which consists of InterSystems IRIS REST API and Frontend Application which demoes a coffee-maker shop. 

It demonstrates the way to communicate with InterSystes IRIS from any frontend application.
It has Unit tests which could be run interactively, or using ZPM, or via Github CI.
It demoes the way to develop using Docker containers.
It demoes how to package the application in ZPM module and how to deploy it using ZPM.
I include a sample Production 
![screenshot](https://github.com/oliverwilms/bilder/blob/main/Capture_Production.PNG)
## Want to delete a Production Item with two clicks?
![screenshot](https://github.com/oliverwilms/bilder/blob/main/ProductionManager.PNG)
First click on any item in the "Remove Item" column ...
![screenshot](https://github.com/oliverwilms/bilder/blob/main/Capture_Prompt_Remove.PNG)
## Installation
### Docker way
Clone the repo, run:
```
docker-compose up -d
```
RUn the application with URL: http://localhost:57700/irisapp/index.html#/
### ZPM way
Open IRIS terminal and run ZPM:
```
USER>zpm
zpm:USER>install "interoperability-manager"
```
Run the appliction in URL: http://yourserver:57700/irisapp/index.html#/

## Development
### Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/), [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.

Open the terminal and run:
```
docker-compose up -d
```

All set. You good to start the development.

## Unit Testing
This repository has [U]nit Tests](https://github.com/intersystems-community/iris-fullstack-template/blob/787acb10efae8847e3084db26c3e4211bd5a753a/tests/UnitTest/Demo/coffeemaker.cls).
THere is a [Github Actions CI workflow](https://github.com/intersystems-community/iris-fullstack-template/blob/787acb10efae8847e3084db26c3e4211bd5a753a/.github/workflows/main.yml) in this repo, which performs unit testing with every push to Github repository and fails if tests fail.

But you also can run the test script locally with:
```
IRISAPP>set ^UnitTestRoot="/irisdev/app/tests"
IRISAPP>do ##class(%UnitTest.Manager).RunTest()
```
Or with ZPM:
```
IRISAPP>zpm
zpm:IRISAPP>load /irisdev/app
zpm:IRISAPP>test demo-coffeemaker
```

## ZPM Package Manager
This module is zpm-packaged, which means that it is described with [module.xml](https://github.com/intersystems-community/iris-fullstack-template/blob/40d39a688df604ef11681c80fc24254a6570fe43/module.xml) and available in public repository and installable with:
zpm "install interoperability-manager"
Feel free to use as an example and change the module.xml to package your own InterSystems IRIS full-stack solution.


## Credits
Demo is built using original [Coffee Maker application](https://github.com/intersystems/FirstLook-REST) by Michael Smart a and it's enhanced version by [Caret Dev](https://github.com/caretdev/CoffeeMaker).
