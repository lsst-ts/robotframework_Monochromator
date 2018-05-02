*** Settings ***
Documentation    Test invalid atMonochromator State transitions.
Force Tags    
Suite Setup
Library    String
Resource    common.robot
Resource    Global_Vars.robot
Resource    monochromator_helpers.robot
Library    Library/atMonochromator_SAL.py

*** Test Cases ***
From Enable Update Wavelength and verify value
    [Tags]    functional
    Comment    Update Wavelength.
    Issue Change Wavelength Command	${400} 
    Verify Wavelength Value	${500} 



