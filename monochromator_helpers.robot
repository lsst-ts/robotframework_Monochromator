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
    ${valid}    ${data}=    Get Event Wavelength
    Should Be True    ${valid}
    Verify Irrational Value    Wavelength	${data.wavelength}	${wavelengthTol}	${expectedWavelgength}

Verify Grating Value 
    [Arguments]    ${expectedGrating}
    Comment    Every change in grating command triggers a grating Event.
    ${valid}    ${data}=    Get Event Selected Grating
    Should Be True    ${valid}
    Verify Rational Value	Grating	${data.gratingType}	${expectedGrating}

Verify Slit Width Value 
    [Arguments]    ${expectedSlit} ${expectedSlitWidth}
    Comment    Every Slit width command triggers a Slit width  Event.
    ${valid}    ${data}=   Get Event Slit Width
    Should Be True    ${valid}
    Comment Verify if slit is the same as the Slit received, if not, get event again
    Run keyword if	${expectedSlit} == ${data.slit}
    	Verify Irrational Value	SlitWidth	${data.slitPosition}	${slitWidthTol}	${expectedSlitWidth}
    	ELSE
    	${valid}    ${data}=   Get Event Slit Width
    	Should Be True    ${valid}
    	Verify Irrational Value	SlitWidth	${data.slitPosition}	${slitWidthTol}	${expectedSlitWidth}

