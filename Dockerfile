ARG IMAGE=store/intersystems/iris-community:2020.1.0.199.0
ARG IMAGE=intersystemsdc/iris-community:2019.4.0.383.0-zpm
ARG IMAGE=intersystemsdc/iris-community:2020.1.0.209.0-zpm
ARG IMAGE=intersystemsdc/iris-community:2020.2.0.196.0-zpm
ARG IMAGE=intersystemsdc/iris-community:2020.3.0.200.0-zpm
ARG IMAGE=intersystemsdc/iris-community
ARG IMAGE=quay.vapo.va.gov/scm/irishealth/irishealth:2021.2.0.651.0
FROM $IMAGE


USER root

WORKDIR /opt/feeder

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} .

COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} irissession.sh /
RUN chmod +x /irissession.sh 

USER ${ISC_PACKAGE_MGRUSER}

COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} Installer.cls .

COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} src src
COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} tests tests
COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} web csp

SHELL ["/irissession.sh"]

RUN \
  do $SYSTEM.OBJ.Load("Installer.cls", "ck") \
  set sc = ##class(App.Installer).setup() \
  set ^|"FEEDER"|UnitTestRoot = "/opt/irisapp/tests"

SHELL ["/bin/sh", "-c"]
