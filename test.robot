*** Settings ***
Documentation    Test Monochromator Parameters update.
Force Tags    
Suite Setup
Library    String
Resource    common.robot
Resource    Global_Vars.robot
Resource    monochromator_helpers.robot
Library    Library/atMonochromator_SAL.py

*** Variables ***
${delay}    0s
${GRdelay}    0s
${DeltaWavelength}    50
${MaxWavelengthGR2}    1200
${MaxWavelengthGR1}    650
${initWavelength}    400
${initSlitWidth}    0
${DeltaSlitWidth}    0.5
${MaxSlitWidth}    8

*** Test Cases ***
From Enable Update Slit FrontEntrance Slit Width and verify value
    [Tags]    functional
    Comment    Update Slit Width and verify value.
    ${slitNumber}=    Convert To Integer    ${FrontEntrance}
    ${slitWidth}=    Convert To Number    ${initSlitWidth}
    ${DSlitWidth}=    Convert To Number    ${DeltaSlitWidth}
    ${MaxSlitWidth}=    Convert To Number    ${MaxSlitWidth}
    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${slitWidth} > ${MaxSlitWidth}
    \    Log    ${slitWidth}
    \    Run Keyword and Continue on Failure    Issue Change Slit Width Command    ${slitNumber}    ${slitWidth}
    \    Run Keyword and Continue on Failure    Verify Slit Width Value	${slitNumber}	${slitWidth}
    \    ${slitWidth}=    Evaluate   ${slitWidth} + ${DSlitWidth}
    \    Sleep    ${delay}

############ BEGIN Slit FrontExit Slit Width Test ############

From Enable Update Slit FrontExit Slit Width and verify value
    [Tags]    functional
    Comment    Update Slit Width and verify value.
    ${slitNumber}=    Convert To Integer    ${FrontExit}
    ${slitWidth}=    Convert To Number    ${initSlitWidth}
    ${DSlitWidth}=    Convert To Number    ${DeltaSlitWidth}
    ${MaxSlitWidth}=    Convert To Number    ${MaxSlitWidth}
    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${slitWidth} > ${MaxSlitWidth}
    \    Log    ${slitWidth}
    \    Run Keyword and Continue on Failure    Issue Change Slit Width Command    ${slitNumber}    ${slitWidth}
    \    Run Keyword and Continue on Failure    Verify Slit Width Value	${slitNumber}	${slitWidth}
    \    ${slitWidth}=    Evaluate   ${slitWidth} + ${DSlitWidth}
    \    Sleep    ${delay}
