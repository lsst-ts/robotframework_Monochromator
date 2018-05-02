*** Settings ***
Documentation    This resource file defines common keywords used by all the SAL test suites.
Library    Library/atMonochromator_SAL.py

*** Keywords ***
Verify Summary State Event
    [Arguments]    ${expectedState}
    Comment    Every sub-State transition triggers a Summary State Event.
    ${valid}    ${data}=    Get Event Summary State
    Log    ${data.summaryState}
    Should Be True    ${valid}
    Should Be Equal As Integers    ${data.summaryState}    ${expectedState}

Verify Detailed State Event 
    [Arguments]    ${expectedState}
    Comment    Every State transition triggers a Detailed State Event.
    ${valid}    ${data}=    Get Event Detailed State
    Log    ${data.detailedState}
    Should Be True    ${valid}
    Should Be Equal As Integers    ${data.detailedState}    ${expectedState}

Verify Command Rejection Warning
    [Arguments]    ${command}    ${reason}
    Comment    Verify the command was rejected.
    ${valid}    ${data}=    Get Event Command Rejection Warning
    Log    ${data.Timestamp}
    Log    ${data.Command}
    Log    ${data.Reason}
    Should Be True    ${valid}
    Should Be Equal As Strings    "${data.Reason}"    ${reason}

Get Event
    [Arguments]    ${EventTopic}
    Comment    Events are queued until read. Query the topic until the most recent event is returned.
    : FOR    ${INDEX}    IN RANGE    1    1000
    \    ${valid}    ${data}=    Run Keyword    Get Event ${EventTopic}
    \    Run Keyword If    ${valid}    Exit For Loop
    \    Sleep    10ms
    [Return]    ${valid}    ${data}

Verify Timestamp 
    [Arguments]    ${timestamp}=${0}
    Comment    Get current time in epoch.
    ${epoch}=    Get Current Date    result_format=epoch
    Comment    Verify timestamp.
    Should Be True    ${timestamp} > ${epoch}

Verify Rational Value
    [Documentation]    This keyword requires the name of the attribute, its value, and then the expected value, in that order.
    [Arguments]    ${attribute}    ${value}    ${ExpectedValue}
    ${value}=    Convert To Number    ${value}
    ${ExpectedValue}=    Convert To Number    ${ExpectedValue}
    Log Many    Attribute: ${attribute}    Value: ${value}    Expected Value: ${ExpectedValue}
    Should Be Equal    ${value}    ${ExpectedValue}

Verify Rational Array
    [Documentation]    This keyword requires the data object, the name of the attribute and then each expected value, in order, as arguments.
    [Arguments]    ${data}    ${attribute}    @{ExpectedValues}
    Log Many    Attribute: ${attribute}    Expected Values: @{ExpectedValues}
    ${index}=    Set Variable    ${0}
    : FOR    ${ExpectedValue}    IN     @{ExpectedValues}
    \    Log    ${attribute}[${index}] Actual Value = ${data.${attribute}[${index}]}
    \    Run Keyword And Continue On Failure     Verify Rational Value   ${attribute}    ${data.${attribute}[${index}]}    ${ExpectedValue}
    \    ${index}=    Evaluate    ${index} + ${1}

Verify Irrational Value
    [Documentation]    This keyword requires the name of the attribute, its value, the tolerance and then the expected value, in that order.
    [Arguments]    ${attribute}    ${value}    ${tolerance}    ${ExpectedValue}
    ${value}=    Convert To Number    ${value}    ${4}
    ${ExpectedValue}=    Convert To Number    ${ExpectedValue}    ${4}
    Log Many    Attribute: ${attribute}    Value: ${value}    Tolerance: ${tolerance}    Expected Value: ${ExpectedValue}
    ${high}=    Evaluate    ${ExpectedValue} + ${tolerance}
    ${low}=    Evaluate    ${ExpectedValue} - ${tolerance}
    Should Be True    ${value} <= ${high}
    Should Be True    ${value} >= ${low}

Verify Irrational Array
    [Documentation]    This keyword requires the data object, the name of the attribute, the tolerance and then each expected value, in order, as arguments.
    [Arguments]    ${data}    ${attribute}    ${tolerance}    @{ExpectedValues}
    Log Many    Attribute: ${attribute}    Tolerance: ${tolerance}    Expected Values: @{ExpectedValues}
    ${index}=    Set Variable    ${0}
    : FOR    ${ExpectedValue}    IN     @{ExpectedValues}
    \    Log    ${attribute}[${index}] Actual Value = ${data.${attribute}[${index}]}
    \    Run Keyword And Continue On Failure    Verify Irrational Value    ${attribute}    ${data.${attribute}[${index}]}    ${tolerance}    ${ExpectedValue}
    \    ${index}=    Evaluate    ${index} + ${1}
