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

