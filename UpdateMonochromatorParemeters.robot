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
${delay}    4s
${GRdelay}    60s
${DeltaWavelength}    50
${MaxWavelengthGR2}    1200
${MaxWavelengthGR1}    650
${initWavelength}    400
${initSlitWidth}    0
${DeltaSlitWidth}    0.5
${MaxSlitWidth}    5.3

*** Test Cases ***

############ BEGIN Go To Enabled State from StandBy ############

Start Command
    [Tags]    functional
    Comment    Issue Start Command.
    Issue Start Command
    Comment    Verify system enters Disabled State.
    Verify Summary State Event    ${SummaryDisabled}

Enable Command
    [Tags]    functional
    Comment    Issue Enable Command.
    Issue Enable Command
    Comment    Verify system enters Enabled State.
    Verify Summary State Event    ${SummaryEnabled}


############ BEGIN Wavelength Test Grating Blue ############


From Enable Update Grating to set it to Blue and verify value
    [Tags]    functional
    Comment    Update Grating and verify value.
    ${GR}=    Convert To Integer    ${Blue} 
    Issue Select Grating Command	${GR}
    Verify Grating Value	${GR} 
    Sleep    ${GRdelay} 

From Enable Update Wavelength in Blue Grating and verify value
    [Tags]    functional
    Comment    Update Wavelength.
    ${DW}=    Convert To Number    ${DeltaWavelength}
    ${Wavelength}=    Convert To Number    ${initWavelength}
    ${MaxValue}=    Convert To Number    ${MaxWavelengthGR1}
    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${Wavelength} > ${MaxValue}
    \    Log    ${Wavelength}
    \    Run Keyword and Continue on Failure    Issue Change Wavelength Command	${Wavelength}
    \    Run Keyword and Continue on Failure    Verify Wavelength Value	${Wavelength}
    \    ${Wavelength}=    Evaluate   ${Wavelength} + ${DW}
    \    Sleep    ${delay}
    Log    Exited

############ BEGIN Wavelength Test Grating 2 ############

From Enable Update Grating to set it to Red and verify value
    [Tags]    functional
    Comment    Update Grating and verify value.
    ${GR}=    Convert To Integer    ${Red} 
    Issue Select Grating Command	${GR}
    Verify Grating Value	${GR} 
    Sleep    ${delay}

From Enable Update Wavelength in Red Grating and verify value
    [Tags]    functional
    Comment    Update Wavelength.
    ${DW}=    Convert To Number    ${DeltaWavelength}
    ${Wavelength}=    Convert To Number    ${MaxWavelengthGR1}
    ${MaxValue}=    Convert To Number    ${MaxWavelengthGR2}
    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${Wavelength} > ${MaxValue}
    \    Log    ${Wavelength}
    \    Run Keyword and Continue on Failure    Issue Change Wavelength Command	${Wavelength}
    \    Run Keyword and Continue on Failure    Verify Wavelength Value	${Wavelength}
    \    ${Wavelength}=    Evaluate   ${Wavelength} + ${DW}
    \    Sleep    ${delay}
    Log    Exited

############ BEGIN Grating Test ############

From Enable Update Grating to Blue and verify value
    [Tags]    functional
    Comment    Update Grating and verify value.
    ${GR}=    Convert To Integer    ${Blue} 
    Issue Select Grating Command	${GR}
    Verify Grating Value	${GR} 
    Sleep    ${GRdelay}

From Enable Update Grating from Blue to Red and verify value
    [Tags]    functional
    Comment    Update Grating and verify value.
    ${GR}=    Convert To Integer    ${Red}
    Issue Select Grating Command	${GR}
    Verify Grating Value	${GR} 
    Sleep    ${GRdelay}

From Enable Update Grating from Red to Mirror and verify value
    [Tags]    functional
    Comment    Update Grating and verify value.
    ${GR}=    Convert To Integer    ${Mirror}
    Issue Select Grating Command	${GR}
    Verify Grating Value	${GR}
    Sleep    ${GRdelay}

From Enable Update Grating from Mirror to Red and verify value
    [Tags]    functional
    Comment    Update Grating and verify value.
    ${GR}=    Convert To Integer    ${Red}
    Issue Select Grating Command	${GR}
    Verify Grating Value	${GR}
    Sleep    ${GRdelay}

From Enable Update Grating from Red to Blue and verify value
    [Tags]    functional
    Comment    Update Grating and verify value.
    ${GR}=    Convert To Integer    ${Blue}
    Issue Select Grating Command	${GR}
    Verify Grating Value	${GR}
    Sleep    ${GRdelay}

############ BEGIN Slit FrontEntrance Slit Width Test ############

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

############ BEGIN Update All Test Checking All Wavelengths ############

From Enable Setup All Parameters in Blue Grating and verify value
    [Tags]    functional
    Comment    Update All parameters and verify all changed to right value.
    ${FrontExitWidth}=    Convert To Number    ${1.3}
    ${FrontEntranceWidth}=    Convert To Number    ${1.1}
    ${grating}=    Convert To Integer    ${Blue}
    ${DW}=    Convert To Number    ${DeltaWavelength}
    ${Wavelength}=    Convert To Number    ${initWavelength}
    ${MaxValue}=    Convert To Number    ${MaxWavelengthGR1}
    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${Wavelength} > ${MaxValue}
    \    Log Many    Wavelength: ${Wavelength}    grating:${grating}    FrontExitWidth:${FrontExitWidth}    FrontEntranceWidth:${FrontEntranceWidth}
    \    Run Keyword and Continue on Failure    Issue Update Monochromator Setup Command    ${grating}    ${FrontExitWidth}    ${FrontEntranceWidth}    ${Wavelength}
    \    Run Keyword and Continue on Failure    Verify Two Slit Widths Value    ${FrontEntranceWidth}    ${FrontExitWidth}
    \    Run Keyword and Continue on Failure    Verify Grating Value    ${grating}
    \    Run Keyword and Continue on Failure    Verify Wavelength Value    ${Wavelength}
    \    ${Wavelength}=    Evaluate   ${Wavelength} + ${DW}
    Sleep    ${delay}

From Enable Setup All Parameters in Red Grating and verify value
    [Tags]    functional
    Comment    Update All parameters and verify all changed to right value.
    ${FrontExitWidth}=    Convert To Number    ${1.3}
    ${FrontEntranceWidth}=    Convert To Number    ${1.1}
    ${grating}=    Convert To Integer    ${Red}
    ${DW}=    Convert To Number    ${DeltaWavelength}
    ${Wavelength}=    Convert To Number    ${MaxWavelengthGR1}
    ${MaxValue}=    Convert To Number    ${MaxWavelengthGR2}
    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${Wavelength} > ${MaxValue}
    \    Log Many    Wavelength: ${Wavelength}    grating:${grating}    FrontExitWidth:${FrontExitWidth}    FrontEntranceWidth:${FrontEntranceWidth}
    \    Run Keyword and Continue on Failure    Issue Update Monochromator Setup Command    ${grating}    ${FrontExitWidth}    ${FrontEntranceWidth}    ${Wavelength}
    \    Run Keyword and Continue on Failure    Verify Two Slit Widths Value    ${FrontEntranceWidth}    ${FrontExitWidth}
    \    Run Keyword and Continue on Failure    Verify Grating Value    ${grating}
    \    Run Keyword and Continue on Failure    Verify Wavelength Value    ${Wavelength}
    \    ${Wavelength}=    Evaluate   ${Wavelength} + ${DW}
    Sleep    ${delay}

From Enable Setup All Parameters in Red Grating and verify value
    [Tags]    functional
    Comment    Update All parameters and verify all changed to right value.
    ${slitNumber}=    Convert To Integer    ${FrontExit}
    ${slitWidth}=    Convert To Number    ${initSlitWidth}
    ${DSlitWidth}=    Convert To Number    ${DeltaSlitWidth}
    ${MaxSlitWidth}=    Convert To Number    ${MaxSlitWidth}
    ${grating}=    Convert To Integer    ${Red}
    ${DW}=    Convert To Number    ${1}
    ${Wavelength}=    Convert To Number    ${400}
    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${slitWidth} > ${MaxSlitWidth}
    \    Log Many    Wavelength: ${Wavelength}    grating:${grating}    FrontExitWidth:${slitWidth}    FrontEntranceWidth:${slitWidth}
    \    Run Keyword and Continue on Failure    Issue Update Monochromator Setup Command    ${grating}    ${slitWidth}    ${slitWidth}    ${Wavelength}
    \    Run Keyword and Continue on Failure    Verify Two Slit Widths Value    ${slitWidth}    ${slitWidth}
    \    Run Keyword and Continue on Failure    Verify Grating Value    ${grating}
    \    Run Keyword and Continue on Failure    Verify Wavelength Value    ${Wavelength}
    \    ${Wavelength}=    Evaluate   ${Wavelength} + ${DW}
    \    ${slitWidth}=    Evaluate   ${slitWidth} + ${DSlitWidth}
    Sleep    ${delay}

############ Go to StandBy ############

Disable Command - Cleanup
    [Tags]    functional
    Comment    Issue Disable Command.
    Issue Disable Command
    Comment    Verify system enters Disabled State.
    Verify Summary State Event    ${SummaryDisabled}

Standby Command - Cleanup
    [Tags]    functional
    Comment    Issue Standby Command.
    Issue Standby Command
    Comment    Verify system enters Standby State.
    Verify Summary State Event    ${SummaryStandby}
