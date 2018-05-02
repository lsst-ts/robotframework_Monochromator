*** Settings ***
Documentation    Monochromator State Commands tests.
Force Tags    
Suite Setup    Log Many    host=${Host}    CSC=${subSystem}    timeout=${timeout}	
#...    AND    Create Session    Commander    AND    Create Session    Controller
#Suite Teardown    Close All Connections
#Test Setup	atMonochromator_SAL.flush States
Library    String
Resource    common.robot
Resource    Global_Vars.robot
Library    Library/atMonochromator_SAL.py

*** Variables ***
${subSystem}    atMonochromator
${timeout}    30s

*** Test Cases ***
Start Command
    [Tags]    functional
    Comment    Issue Start Command.
    Issue Start Command
    Comment    Verify system enters Disabled State.
    Verify Summary State Event    ${SummaryDisabled}

Verify Detailed State - Standby
    [Tags]    functional
    Comment    Verify system enters Disabled Detailed State.
    Verify Detailed State Event    ${DetailedDisabled}

Enable Command
    [Tags]    functional
    Comment    Issue Enable Command.
    Issue Enable Command
    Comment    Verify system enters Enabled State.
    Verify Summary State Event    ${SummaryEnabled}

Verify Detailed State - StoppedState
    [Tags]    functional
    Comment    Verify system enters Stopped Detailed State.
    Verify Detailed State Event    ${DetailedStopped}

Update Wavelength Command - ManualSettingUpState
    [Tags]    functional
    Comment    issue Change Wavelength Command.
    Issue Change Wavelength Command
    Comment    Verify system enters Setting Up State.
    Verify Detailed State Event    ${DetailedMonoManualSetup}
    Comment	Wait time to finish setting up.    
    wait Time
    Verify Detailed State Event    ${DetailedStopped}

Disable Command - Cleanup
    [Tags]    functional
    Comment    Issue Disable Command.
    Issue Disable Command
    Comment    Verify system enters Disabled State.
    Verify Summary State Event    ${SummaryDisabled}

Verify System Disabled Detailed State
    [Tags]    functional
    Comment    Verify system enters Disabled Detailed State.
    Verify Detailed State Event    ${DetailedDisabled}

Standby Command - Cleanup
    [Tags]    functional
    Comment    Issue Standby Command.
    Issue Standby Command
    Comment    Verify system enters Standby State.
    Verify Summary State Event    ${SummaryStandby}

Verify System Standby Detailed State
    [Tags]    functional
    Comment    Verify system enters Standby Detailed State.
    Verify Detailed State Event    ${DetailedStandby}
