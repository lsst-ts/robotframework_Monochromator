*** Settings ***
Documentation    This verifies the version of SAL installed on the remote host.
Force Tags    version
Suite Setup    Log Many    ${SALVersion}    ${OpenspliceVersion}    ${OpenspliceDate}
Library    OperatingSystem
Resource    Global_Vars.robot

*** Variables ***
${timeout}    10s

*** Test Cases ***
Verify SAL Version
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Get SAL Version.
    ${version}=    Run    echo $SAL_VERSION
    Should Be Equal    ${version}    ${SALVersion}

Verify OpenSplice Version
    [Documentation]    Verify the OpenSplice version and date.
    [Tags]    smoke
    Comment    Get the Opensplice version
    ${version}=    Run    cat $OSPL_HOME/release.com
    Log    ${version}
    Should Contain    ${version}    Vortex OpenSplice HDE Release 
    Should Contain    ${version}    ${OpenspliceVersion} For x86_64.linux-debug
    Should Contain    ${version}    Date ${OpenspliceDate}

Verify SAL Version file exists
    [Tags]    smoke
    Log    ${SALInstall}/lsstsal/scripts/sal_version.tcl
    File Should Exist    ${SALInstall}/lsstsal/scripts/sal_version.tcl

Verify SAL Version file contents
    [Tags]    smoke
    ${output}=    Run    cat ${SALInstall}/lsstsal/scripts/sal_version.tcl
    Log    ${output}
    Should Contain    ${output}    set SALVERSION ${SALVersion}
