*** Settings ***
Documentation    Test invalid atMonochromator State transitions.
Force Tags    
Suite Setup
Library    String
Resource    common.robot
Resource    Global_Vars.robot
Library    Library/atMonochromator_SAL.py

*** Test Cases ***
From Standby Issue Enable Command
    [Tags]    functional
    Issue Enable Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandEnable}    ${DetailedStandby}

From Standby Issue GoToStandby Command
    [Tags]    functional
    Issue Standby Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandGoToStandby}    ${DetailedStandby}

From Standby Issue Disable Command
    [Tags]    functional
    Issue Disable Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandDisable}    ${DetailedStandby}

From Standby Issue ChangeWavelength Command
    [Tags]    functional
    Issue Change Wavelength Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandChangeWavelength}    ${DetailedStandby}

From Standby Issue SelectGrating Command
    [Tags]    functional
    Issue Select Grating Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandSelectGrating}    ${DetailedStandby}

From Standby Issue ChangeSlitWidth Command
    [Tags]    functional
    Issue Change Slit Width Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandChangeSlitWidth}    ${DetailedStandby}

From Standby Issue SetupMonochromator Command
    [Tags]    functional
    Issue Update Monochromator Setup Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandSetupMonochromator}    ${DetailedStandby}




From Standby Issue Start Command
    [Tags]    functional
    Issue Start Command
    Comment    Verify system goes to Disable
    Verify Summary State Event    ${SummaryDisabled}

From Disable Issue Start Command
    [Tags]    functional
    Issue Start Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandStart}    ${DetailedDisabled}

From Disable Issue ExitControl Command
    [Tags]    functional
    Issue Exit Control Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandExit}    ${DetailedDisabled}

From Disable Issue Disable Command
    [Tags]    functional
    Issue Disable Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandDisable}    ${DetailedDisabled}

From Disable Issue ChangeWavelength Command
    [Tags]    functional
    Issue Change Wavelength Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandChangeWavelength}    ${DetailedDisabled}

From Disable Issue SelectGrating Command
    [Tags]    functional
    Issue Select Grating Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandSelectGrating}    ${DetailedDisabled}

From Disable Issue ChangeSlitWidth Command
    [Tags]    functional
    Issue Change Slit Width Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandChangeSlitWidth}    ${DetailedDisabled}

From Disable Issue SetupMonochromator Command
    [Tags]    functional
    Issue Update Monochromator Setup Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandSetupMonochromator}    ${DetailedDisabled}

From Disable Issue Enable Command
    [Tags]    functional
    Issue Enable Command
    Comment    Verify system goes to Enable
    Verify Summary State Event    ${DetailedEnabled}

From Enable Issue Start Command
    [Tags]    functional
    Issue Start Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandStart}    ${DetailedStopped}

From Enable Issue ExitControl Command
    [Tags]    functional
    Issue Exit Control Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandExit}    ${DetailedStopped}

From Enable Issue GoToStandby Command
    [Tags]    functional
    Issue Standby Command
    Comment    Verify system rejects the command.
    Verify No Summary State Event
    Verify Command Rejection Warning    ${CommandGoToStandby}    ${DetailedStopped}

From Enable Issue Disable Command
    [Tags]    functional
    Issue Disable Command
    Comment    Verify system goes to Disable
    Verify Summary State Event    ${DetailedDisabled}

From Disable Issue Standby Command
    [Tags]    functional
    Issue Standby Command
    Comment    Verify system goes to Standby
    Verify Summary State Event    ${DetailedStandby}

*** Keywords ***
Verify No Summary State Event
    Comment    Commands are rejected silently, therefore Summary State Event is not published.
    ${valid}    ${data}=    Get Event Summary State
    Log    ${data.summaryState}
    Should Not Be True    ${valid}
