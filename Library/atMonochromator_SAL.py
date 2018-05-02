import sys
import time
from SALPY_atMonochromator import *

class atMonochromator_SAL:
	ROBOT_LIBRARY_SCOPE = 'GLOBAL'

	def __init__(self):
		self._SALatMonochromator = SAL_atMonochromator()
		self._SALatMonochromator.setDebugLevel(0)

		## SAL Events
		self._SALatMonochromator.salEvent("atMonochromator_logevent_AppliedSettingsMatchStart")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_CoolingMonitoring")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_DetailedState")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_ErrorCode")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_Heartbeat")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_inPosition")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_InternalCommand")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_LightIntensity")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_LightStatus")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_AppliedSettingsMatchStart")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_CoolingMonitoring")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_DetailedState")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_ErrorCode")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_Heartbeat")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_inPosition")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_InternalCommand")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_LightIntensity")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_LightStatus")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_LoopTimeOutOfRange")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_MonochromatorConnected")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_RejectedCommand")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SelectedGrating")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SettingsAppliedLoop")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SettingsAppliedMonochromatorRanges")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SettingsAppliedMonoCommunication")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SettingsAppliedMonoHeartbeat")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SettingVersions")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SlitWidth")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SummaryState")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_Wavelength")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_LoopTimeOutOfRange")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_MonochromatorConnected")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_RejectedCommand")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SelectedGrating")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SettingsAppliedLoop")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SettingsAppliedMonochromatorRanges")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SettingsAppliedMonoCommunication")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SettingsAppliedMonoHeartbeat")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SettingVersions")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SlitWidth")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_SummaryState")
		self._SALatMonochromator.salEvent("atMonochromator_logevent_Wavelength")

		## SAL Commands
		self._SALatMonochromator.salCommand("atMonochromator_command_CalibrateWavelength")
		self._SALatMonochromator.salCommand("atMonochromator_command_ChangeLightIntensity")
		self._SALatMonochromator.salCommand("atMonochromator_command_ChangeSlitWidth")
		self._SALatMonochromator.salCommand("atMonochromator_command_ChangeWavelength")
		self._SALatMonochromator.salCommand("atMonochromator_command_disable")
		self._SALatMonochromator.salCommand("atMonochromator_command_enable")
		self._SALatMonochromator.salCommand("atMonochromator_command_enterControl")
		self._SALatMonochromator.salCommand("atMonochromator_command_exitControl")
		self._SALatMonochromator.salCommand("atMonochromator_command_Power")
		self._SALatMonochromator.salCommand("atMonochromator_command_PowerWhiteLight")
		self._SALatMonochromator.salCommand("atMonochromator_command_SelectGrating")
		self._SALatMonochromator.salCommand("atMonochromator_command_SetCoolingTemperature")
		self._SALatMonochromator.salCommand("atMonochromator_command_standby")
		self._SALatMonochromator.salCommand("atMonochromator_command_start")
		self._SALatMonochromator.salCommand("atMonochromator_command_updateMonochromatorSetup")

		## SAL Telemetry
		#self._SALatMonochromator.salTelemetrySub("atMonochromator_InclinometerData")

	def _afterCommand(self):
		time.sleep(1)

	def _beforeCommand(self):
		self.flushStates()
		self.flushAllEvents()

	def getCurrentTime(self):
		data = self._SALatMonochromator.getCurrentTime()
		return data
	
	def waitTime(self, delay=10):
		time.sleep(delay)

	######## atMonochromator Telemetry ########

	######## atMonochromator Commands ########

	def issueStartCommand(self):
		self._beforeCommand()
		data = atMonochromator_command_startC()
		data.settingsToApply = "Default"
		cmdId = self._SALatMonochromator.issueCommand_start(data)
		self._SALatMonochromator.waitForCompletion_start(cmdId, 10)
		self._afterCommand()

	def issueEnableCommand(self):
		self._beforeCommand()
		data = atMonochromator_command_enableC()
		data.enable = True
		cmdId = self._SALatMonochromator.issueCommand_enable(data)
		self._SALatMonochromator.waitForCompletion_enable(cmdId, 10)
		self._afterCommand()

	def issueDisableCommand(self):
		self._beforeCommand()
		data = atMonochromator_command_disableC()
		data.disable = True
		cmdId = self._SALatMonochromator.issueCommand_disable(data)
		self._SALatMonochromator.waitForCompletion_disable(cmdId, 10)
		self._afterCommand()
    
	def issueStandbyCommand(self):
		self._beforeCommand()
		data = atMonochromator_command_standbyC()
		data.standBy = True
		cmdId = self._SALatMonochromator.issueCommand_standby(data)
		self._SALatMonochromator.waitForCompletion_standby(cmdId, 10)
		self._afterCommand()

	def issueExitControlCommand(self):
		self._beforeCommand()
		data = atMonochromator_command_exitControlC()
		data.exitControl = True
		cmdId = self._SALatMonochromator.issueCommand_exitControl(data)
		self._SALatMonochromator.waitForCompletion_exitControl(cmdId, 10)
		self._afterCommand()

	def issueEnterControlCommand(self):
		self._beforeCommand()
		data = atMonochromator_command_enterControlC()
		data.enterControl = True
		cmdId = self._SALatMonochromator.atMonochromator_command_enterControlC(data)
		self._SALatMonochromator.waitForCompletion_enterControl(cmdId, 10)
		self._afterCommand()

	def issueSelectGratingCommand(self, Grating=1):
		self._beforeCommand()
		data = atMonochromator_command_SelectGratingC()
		data.gratingType = Grating
		cmdId = self._SALatMonochromator.issueCommand_SelectGrating(data)
		self._SALatMonochromator.waitForCompletion_SelectGrating(cmdId, 10)
		self._afterCommand()

	def issueUpdateMonochromatorSetupCommand(self, Grating=1, exitSlitWidth=2.0, entranceSlitWidth=2.0, wavelength=400.0):
		self._beforeCommand()
		data = atMonochromator_command_updateMonochromatorSetupC()
		data.gratingType=Grating
		data.fontExitSlitWidth=exitSlitWidth
		data.fontEntranceSlitWidth=entranceSlitWidth
		data.wavelength=wavelength
		cmdId = self._SALatMonochromator.issueCommand_updateMonochromatorSetup(data)
		self._SALatMonochromator.waitForCompletion_updateMonochromatorSetup(cmdId, 10)
		self._afterCommand()

	def issueChangeSlitWidthCommand(self, slit=2, slitWidth=2.0):
		self._beforeCommand()
		data = atMonochromator_command_ChangeSlitWidthC()
		data.slit=slit
		data.slitWidth=slitWidth
		cmdId = self._SALatMonochromator.issueCommand_ChangeSlitWidth(data)
		self._SALatMonochromator.waitForCompletion_ChangeSlitWidth(cmdId, 10)
		self._afterCommand()

	def issueChangeWavelengthCommand(self, wavelength=400.0):
		self._beforeCommand()
		data = atMonochromator_command_ChangeWavelengthC()
		data.wavelength=wavelength
		cmdId = self._SALatMonochromator.issueCommand_ChangeWavelength(data)
		self._SALatMonochromator.waitForCompletion_ChangeWavelength(cmdId, 10)
		self._afterCommand()

	######## atMonochromator Events ########

	def getEventSummaryState(self):
		data = atMonochromator_logevent_SummaryStateC()
		retVal = self._SALatMonochromator.getEvent_SummaryState(data)
		return retVal==0, data

	def getEventDetailedState(self):
		data = atMonochromator_logevent_DetailedStateC()	
		retVal = self._SALatMonochromator.getEvent_DetailedState(data)
		return retVal==0, data

	def getEventSettingsAppliedLoop(self):
		data = atMonochromator_logevent_SettingsAppliedLoopC()
		retVal = self._SALatMonochromator.getEvent_SettingsAppliedLoop(data)
		return retVal==0, data

	def getEventSettingsAppliedMonoHeartbeat(self):
		data = atMonochromator_logevent_SettingsAppliedMonoHeartbeatC()
		retVal = self._SALatMonochromator.getEvent_SettingsAppliedMonoHeartbeat(data)
		return retVal==0, data

	def getEventSettingsAppliedMonoCommunication(self):
		data = atMonochromator_logevent_SettingsAppliedMonoCommunicationC()
		retVal = self._SALatMonochromator.getEvent_SettingsAppliedMonoCommunication(data)
		return retVal==0, data

	def getEventSettingsAppliedMonochromatorRanges(self):
		data = atMonochromator_logevent_SettingsAppliedMonochromatorRangesC()
		retVal = self._SALatMonochromator.getEvent_SettingsAppliedMonochromatorRanges(data)
		return retVal==0, data

	def getEventRejectedCommand(self):
		data = atMonochromator_logevent_RejectedCommandC()
		retVal = self._SALatMonochromator.getEvent_RejectedCommand(data)
		return retVal==0, data

	def getEventSelectedGrating(self):
		data = atMonochromator_logevent_SelectedGratingC()
		retVal = self._SALatMonochromator.getEvent_SelectedGrating(data)
		return retVal==0, data

	def getEventSlitWidth(self):
		data = atMonochromator_logevent_SlitWidthC()
		retVal = self._SALatMonochromator.getEvent_SlitWidth(data)
		return retVal==0, data

	def getEventWavelength(self):
		data = atMonochromator_logevent_WavelengthC()
		retVal = self._SALatMonochromator.getEvent_Wavelength(data)
		return retVal==0, data

	def getEventinPosition(self):
		data = atMonochromator_logevent_inPositionC()
		retVal = self._SALatMonochromator.getEvent_inPosition(data)
		return retVal==0, data

	def getEventErrorCode(self):
		data = atMonochromator_logevent_ErrorCodeC()
		retVal = self._SALatMonochromator.getEvent_ErrorCode(data)
		return retVal==0, data

	def getEventAppliedSettingsMatchStart(self):
		data = atMonochromator_logevent_AppliedSettingsMatchStartC()
		retVal = self._SALatMonochromator.getEvent_AppliedSettingsMatchStart(data)
		return retVal==0, data

	######## Flush Topics ########
	
	#def flushHardpointMonitorInfo(self):
	#	data = atMonochromator_logevent_HardpointMonitorInfoC()
	#	retVal = self._SALatMonochromator.flushSamples_logevent_HardpointMonitorInfo(data)
	#	return retVal==0

	def flushSummaryState(self):
		data = atMonochromator_logevent_SummaryStateC()
		retVal = self._SALatMonochromator.flushSamples_logevent_SummaryState(data)
		return retVal==0

	def flushDetailedState(self):
		data = atMonochromator_logevent_DetailedStateC()
		retVal = self._SALatMonochromator.flushSamples_logevent_DetailedState(data)
		return retVal==0

	def flushStates(self):
		self.flushDetailedState()
		self.flushSummaryState()
		
	def flushWavenelgnth(self):
		data = atMonochromator_logevent_WavelengthC()
		retVal = self._SALatMonochromator.flushSamples_logevent_Wavelength(data)
		return retVal==0		

	def flushSlitWidth(self):
		data = atMonochromator_logevent_SlitWidthC()
		retVal = self._SALatMonochromator.flushSamples_logevent_SlitWidth(data)
		return retVal==0

	def flushSelectedGrating(self):
		data = atMonochromator_logevent_SelectedGratingC()
		retVal = self._SALatMonochromator.flushSamples_logevent_SelectedGrating(data)
		return retVal==0

	def flushRejectedCommand(self):
		data = atMonochromator_logevent_RejectedCommandC()
		retVal = self._SALatMonochromator.flushSamples_logevent_RejectedCommand(data)
		return retVal==0

	def flushAllEvents(self):
		retVal1 = self.flushSelectedGrating()
		retVal2 = self.flushWavenelgnth()
		retVal3 = self.flushSlitWidth()
		retVal4 = self.flushRejectedCommand()
		return (retVal1 or retVal1 or retVal3 or retVal4)

	######## Utility Functions ########

	def waitForNextSummaryState(self, wait=300):
		timeout = time.time() + float(wait)
		data = atMonochromator_logevent_SummaryStateC()
		retVal = self._SALatMonochromator.getEvent_SummaryState(data)
		while retVal != 0 and timeout > time.time():
			time.sleep(1)
			retVal = self._SALatMonochromator.getEvent_SummaryState(data)
		return retVal==0, data

	def waitForNextDetailedState(self, wait=300):
		timeout = time.time() + float(wait)
		data = atMonochromator_logevent_DetailedStateC()
		retVal = self._SALatMonochromator.getEvent_DetailedState(data)
		while retVal != 0 and timeout > time.time():
			time.sleep(1)
			retVal = self._SALatMonochromator.getEvent_DetailedState(data)
		return retVal==0, data

	def waitForNextSelectedGrating(self, wait=300):
		timeout = time.time() + float(wait)
		data = atMonochromator_logevent_SelectedGratingC()
		retVal = self._SALatMonochromator.getEvent_SelectedGrating(data)
		while retVal != 0 and timeout > time.time():
			time.sleep(1)
			retVal = self._SALatMonochromator.getEvent_SelectedGrating(data)
		return retVal==0, data.gratingType

	def waitForNextSlitWidth(self, wait=300):
		timeout = time.time() + float(wait)
		data = atMonochromator_logevent_SlitWidthC()
		retVal = self._SALatMonochromator.getEvent_SlitWidth(data)
		while retVal != 0 and timeout > time.time():
			time.sleep(1)
			retVal = self._SALatMonochromator.getEvent_SlitWidth(data)
		return retVal==0, data.slit, data.slitWidth

	def waitForNextWavelength(self, wait=300):
		timeout = time.time() + float(wait)
		data = atMonochromator_logevent_WavelengthC()
		retVal = self._SALatMonochromator.getEvent_Wavelength(data)
		while retVal != 0 and timeout > time.time():
			time.sleep(1)
			retVal = self._SALatMonochromator.getEvent_Wavelength(data)
		return retVal==0, data.wavelength, data.timestamp

	def __del__(self):
		self._SALatMonochromator.salShutdown()
