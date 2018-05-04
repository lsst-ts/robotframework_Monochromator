*** Settings ***
Documentation    This resource file defines common keywords used by all the SAL test suites.
Library    Library/atMonochromator_SAL.py
Resource    common.robot

*** Variables ***
${wavelengthTol}    ${1}
${slitWidthTol}    ${0.01}

*** Keywords ***
Verify Wavelength Value 
    [Arguments]    ${expectedWavelgength}
    Comment    Every change wavelength command triggers a wavelength Event.
    ${valid}    ${data}=    Wait For Next Wavelength
    Should Be True    ${valid}
    Verify Irrational Value    Wavelength	${data.wavelength}	${wavelengthTol}	${expectedWavelgength}

Verify Grating Value 
    [Arguments]    ${expectedGrating}
    Comment    Every change in grating command triggers a grating Event.
    ${valid}    ${data}=    Wait For Next Selected Grating
    Should Be True    ${valid}
    Verify Rational Value	Grating	${data.gratingType}	${expectedGrating}

Verify Slit Width Value 
    [Arguments]    ${expectedSlit}    ${expectedSlitWidth}
    Comment    Every Slit width command triggers a Slit width  Event.
    ${valid1}    ${data1}=   Wait For Next Slit Width
    ${valid2}    ${data2}=   Wait For Next Slit Width
    Should Be True    ${valid1}
    Should Be True    ${valid2}
    Comment	Verify if slit is the same as the Slit received, if not, get event again
    Run keyword if	${expectedSlit} == ${data1.slit}
    ...        Verify Irrational Value	SlitWidth	${data1.slitPosition}	${slitWidthTol}	${expectedSlitWidth}
    ...    ELSE
    ...        Verify Irrational Value	SlitWidth	${data2.slitPosition}	${slitWidthTol}	${expectedSlitWidth}

Verify Two Slit Widths Value 
    [Arguments]    ${expectedEntranceSlitWidth}    ${expectedExitSlitWidth}
    Comment    Every Slit width command triggers a Slit width  Event.
    ${valid1}    ${data1}=   Wait For Next Slit Width
    ${valid2}    ${data2}=   Wait For Next Slit Width
    Should Be True    ${valid1}
    Should Be True    ${valid2}
    Comment	Verify if slit is the same as the Slit received, if not, get event again
    Run keyword if	${FrontExit} == ${data1.slit}
    ...        Verify Irrational Value	SlitWidth	${data1.slitPosition}	${slitWidthTol}	${expectedExitSlitWidth}
    ...    ELSE
    ...        Verify Irrational Value	SlitWidth	${data1.slitPosition}	${slitWidthTol}	${expectedEntranceSlitWidth}
    Run keyword if	${FrontExit} == ${data2.slit}
    ...        Verify Irrational Value	SlitWidth	${data2.slitPosition}	${slitWidthTol}	${expectedExitSlitWidth}
    ...    ELSE
    ...        Verify Irrational Value	SlitWidth	${data2.slitPosition}	${slitWidthTol}	${expectedEntranceSlitWidth}
