*** Settings ***

*** Variables ***
${ContInt}       		false
${UserName}      		tsswtest
${PassWord}      		${EMPTY}
${KeyFile}       		${EMPTY}
${SALInstall}    		/home/andres/ts_sal
${SALHome}       		${SalInstall}/lsstsal
${SALWorkDir}    		${SalInstall}/test
${SALVersion}    		3.7
${OpenspliceVersion}		6.4.1
${OpenspliceDate}		2017-06-21
${Prompt}        		]$
${Host}          		0.0.0.0

##### State Enumerations #####
${SummaryDisabled}		1
${SummaryEnabled}		2
${SummaryFault}			3
${SummaryOffline}		4
${SummaryStandby}		5

${DetailedDisabled}		1
${DetailedEnabled}		2
${DetailedFault}		3
${DetailedOffline}		4
${DetailedStandby}		5
${DetailedMonoSettingUp}	6
${DetailedStopped}		7
${DetailedStoppedCoolerOff}	8
${DetailedStoppedLightOff}	9
${DetailedStoppedLightOn}	10
${DetailedMonoManualSetup}	11
${DetailedMonoAutomaticSetup}	12

##### Gretings Enumerations #####
${NA}		0
${Blue}		1
${Red}		2
${Mirror}	3

##### Slits Enumerations #####
${NA}			0
${FrontEntrance}	1
${FrontExit}		2

##### Command Values #####
${CommandDisable}			0
${CommandEnable}			1
${CommandExit}				2
${CommandGoToStandby}			3
${CommandOnHeartbeat}			4
${CommandOnIncomingMessagingError}	5
${CommandOnInterrupt}			6
${CommandStart}				7
${CommandCalibrateWavelength}		8
${CommandChangeWavelength}		9
${CommandSelectGrating}			10
${CommandChangeSlitWidth}		11
${CommandSetupMonochromator}		12
