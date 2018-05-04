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
From Enable Update SlitWidth and verify value
    [Tags]    functional
    Comment    Update Grating and verify value.
    Issue Change Slit Width Command	2    3

