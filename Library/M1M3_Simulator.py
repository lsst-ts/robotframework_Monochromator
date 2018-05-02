import time
import sys
import numpy
import ILCSimulator
import InclinometerSimulator
import DisplaceSimulator
import AccelSimulator
import UDP
from   M1M3_ReferenceData import *

class M1M3_Simulator:
	ROBOT_LIBRARY_SCOPE = 'GLOBAL'

	def __init__(self):

		self._ilcSim = ILCSimulator.ILCSimulator()
		self._inclinSim = InclinometerSimulator.InclinometerSimulator()
		self._displaceSim = DisplaceSimulator.DisplacementSimulator()
		self._accelSim = AccelSimulator.AccelSimulator()
		ipAddress = '140.252.32.153'
		self._udpClientSubnetA = UDP.UDP(ipAddress, 5006)
		self._udpClientSubnetB = UDP.UDP(ipAddress, 5007)
		self._udpClientSubnetC = UDP.UDP(ipAddress, 5008)
		self._udpClientSubnetD = UDP.UDP(ipAddress, 5009)
		self._udpClientSubnetE = UDP.UDP(ipAddress, 5005)
		self._udpClientInclin = UDP.UDP(ipAddress, 5010)
		self._udpClientDisplace = UDP.UDP(ipAddress, 5011)
		self._udpClientAccel = UDP.UDP(ipAddress, 5012)

		self._hardpointSubnet = 5
		self._hardpointMonitorSubnet = 5
		# Configure Simulator to known state
		self.setToDefaults()

	# Common use functions
	def _afterCommand(self):
		time.sleep(1)

	def _subnetToUDPClient(self, subnet):
		if subnet == 1:
			return self._udpClientSubnetA
		elif subnet == 2:
			return self._udpClientSubnetB
		elif subnet == 3:
			return self._udpClientSubnetC
		elif subnet == 4:
			return self._udpClientSubnetD
		elif subnet == 5:
			return self._udpClientSubnetE
		raise ValueError()

	# BEGIN M1M3 Simulator Configuration commands

	# Inclinometer and Displacement configuration commands
	def setInclinometer(self, value=0.0):
		self._udpClientInclin.send(self._inclinSim.inclinometerResponse(degreesMeasured = value))
		print('Set the Inclinometer to degreesMeasured: %s' % (value))
		self._afterCommand()

	def setDisplacement(self, dispA=1.0, dispB=2.0, dispC=3.0, dispD=4.0, dispE=5.0, dispF=6.0, dispG=7.0, dispH=8.0):
		self._udpClientDisplace.send(self._displaceSim.displacementResponse(displace1 = dispA, 
											displace2 = dispB, 
											displace3 = dispC, 
											displace4 = dispD, 
											displace5 = dispE, 
											displace6 = dispF, 
											displace7 = dispG, 
											displace8 = dispH))
		print('Set the Displacements to displace1: %s, displace2: %s, displace3: %s, displace4: %s, displace5: %s, displace6: %s, displace7: %s, displace8: %s' 
			% (dispA, dispB, dispC, dispD, dispE, dispF, dispG, dispH))
		self._afterCommand()

	# Hardpoint Actuator configuration commands
	def setHardpointForceAndStatus(self, serverAddr, statusByte, ssiEncoderValue, loadCellForce):
		self._subnetToUDPClient(self._hardpointSubnet).send(self._ilcSim.forceAndStatusRequest(int(serverAddr), int(statusByte), int(ssiEncoderValue), float(loadCellForce)))

	def setHardpointDisplacementLVDT(self, serverAddr, lvdt1, lvdt2):
		self._subnetToUDPClient(self._hardpointMonitorSubnet).send(self._ilcSim.readLVDT(int(serverAddr), float(lvdt1), float(lvdt2)))

	def setHardpointDCAPressure(self, serverAddr, pressure1AxialPush, pressure2AxialPull, pressure3LateralPull, pressure4LateralPush):
		self._subnetToUDPClient(self._hardpointMonitorSubnet).send(self._ilcSim.readDcaPressureValues(int(serverAddr), float(pressure1AxialPush), float(pressure2AxialPull),
                            							float(pressure3LateralPull), float(pressure4LateralPush)))

	def setHardpointServerID(self, serverAddr, uniqueId, ilcAppType, networkNodeType, ilcSelectedOptions, networkNodeOptions, majorRev, minorRev, firmwareName):
		self._subnetToUDPClient(self._hardpointSubnet).send(self._ilcSim.reportServerId(int(serverAddr), int(uniqueId), int(ilcAppType), int(networkNodeType),
												int(ilcSelectedOptions), int(networkNodeOptions), int(majorRev), 
												int(minorRev), str(firmwareName)))

	def setHardpointMonitorMezzanineID(self, serverAddr, dcaUniqueId, firmwareType, firmwareVersion):
		self._subnetToUDPClient(self._hardpointSubnet).send(self._ilcSim.reportDcaId(int(serverAddr), int(dcaUniqueId), int(firmwareType), int(firmwareVersion)))

	def setHardpointServerStatus(self, serverAddr, mode, status, faults):
		self._subnetToUDPClient(self._hardpointSubnet).send(self._ilcSim.reportServerStatus(int(serverAddr), int(mode), int(status), int(faults)))

	# Force Actuator configuration commands
	def setSinglePneumaticAxisForce(self, subnet, serverAddr, statusByte, loadCellForce):
		self._subnetToUDPClient(int(subnet)).send(self._ilcSim.singlePneumaticAxisForce(int(serverAddr), int(statusByte), float(loadCellForce)))

	def setSinglePneumaticForceAndStatus(self, subnet, serverAddr, statusByte, loadCellForce):
		self._subnetToUDPClient(int(subnet)).send(self._ilcSim.singlePneumaticForceAndStatus(int(serverAddr), int(statusByte), float(loadCellForce)))
		print('Subnet: %s, serverAddr: %s, statusByte: %s, loadCellForce: %s' % (subnet, serverAddr, statusByte, loadCellForce))

	def setDualPneumaticAxisForce(self, subnet, serverAddr, statusByte, axialLoadCellForce, lateralLoadCellForce):
		self._subnetToUDPClient(int(subnet)).send(self._ilcSim.dualPneumaticAxisForce(int(serverAddr), int(statusByte), float(axialLoadCellForce), float(lateralLoadCellForce)))

	def setDualPneumaticForceAndStatus(self, subnet, serverAddr, statusByte, axialLoadCellForce, lateralLoadCellForce):
		self._subnetToUDPClient(int(subnet)).send(self._ilcSim.dualPneumaticForceAndStatus(int(serverAddr), int(statusByte), float(axialLoadCellForce), float(lateralLoadCellForce)))
		print('Subnet: %s, serverAddr: %s, statusByte: %s, axialLoadCellForce: %s, lateralLoadCellForce: %s' % (subnet, serverAddr, statusByte, axialLoadCellForce, lateralLoadCellForce))

	def setBoostValueDcaGains(self, subnet, serverAddr, axialBoostValveGain, lateralBoostValveGain):
		self._subnetToUDPClient(int(subnet)).send(self._ilcSim.readBoostValueDcaGains(int(serverAddr), float(axialBoostValveGain), float(lateralBoostValveGain)))

	# ILC configuration commands
	def setServerID(self, subnet, serverAddr, uniqueId, ilcAppType, networkNodeType, ilcSelectedOptions, networkNodeOptions, majorRev, minorRev, firmwareName):
		self._subnetToUDPClient(subnet).send(self._ilcSim.reportServerId(int(serverAddr), int(uniqueId), int(ilcAppType), int(networkNodeType),
												int(ilcSelectedOptions), int(networkNodeOptions), int(majorRev), 
												int(minorRev), str(firmwareName)))

	def setServerStatus(self, subnet, serverAddr, mode, status, faults):
		self._subnetToUDPClient(subnet).send(self._ilcSim.reportServerStatus(int(serverAddr), int(mode), int(status), int(faults)))

	def setMezzanineID(self, subnet, serverAddr, dcaUniqueId, firmwareType, firmwareVersion):
                self._subnetToUDPClient(subnet).send(self._ilcSim.reportDcaId(int(serverAddr), int(dcaUniqueId), int(firmwareType), int(firmwareVersion)))

	def setCalibrationData(self, subnet, serverAddr, 
				mainAdcCalibration1, mainAdcCalibration2, mainAdcCalibration3, mainAdcCalibration4,
				mainSensorOffset1, mainSensorOffset2, mainSensorOffset3, mainSensorOffset4,
				mainSensorSensitivity1, mainSensorSensitivity2, mainSensorSensitivity3, mainSensorSensitivity4,
				backupAdcCalibration1, backupAdcCalibration2, backupAdcCalibration3, backupAdcCalibration4,
				backupSensorOffset1, backupSensorOffset2, backupSensorOffset3, backupSensorOffset4,
				backupSensorSensitivity1, backupSensorSensitivity2, backupSensorSensitivity3, backupSensorSensitivity4):
		self._subnetToUDPClient(subnet).send(self._ilcSim.readCalibrationData(int(serverAddr), 
							float(mainAdcCalibration1), float(mainAdcCalibration2), float(mainAdcCalibration3), float(mainAdcCalibration4), 
							float(mainSensorOffset1), float(mainSensorOffset2), float(mainSensorOffset3), float(mainSensorOffset4),
							float(mainSensorSensitivity1), float(mainSensorSensitivity2), float(mainSensorSensitivity3), float(mainSensorSensitivity4), 
							float(backupAdcCalibration1), float(backupAdcCalibration2), float(backupAdcCalibration3), float(backupAdcCalibration4),
							float(backupSensorOffset1), float(backupSensorOffset2), float(backupSensorOffset3), float(backupSensorOffset4),
							float(backupSensorSensitivity1), float(backupSensorSensitivity2), float(backupSensorSensitivity3), float(backupSensorSensitivity4)))

	def setAdcSampleRate(self, subnet, serverAddr, scanRateCode):
		self._subnetToUDPClient(subnet).send(self._ilcSim.setAdcSampleRate(int(serverAddr), int(scanRateCode)))

	# Set Simulator to default values
	def setToDefaults(self):
		self._udpClientInclin.send(self._inclinSim.inclinometerResponse(degreesMeasured = 0.0))
		self._udpClientDisplace.send(self._displaceSim.displacementResponse(displace1 = 1.0,
											displace2 = 2.0,
											displace3 = 3.0,
											displace4 = 4.0,
											displace5 = 5.0,
											displace6 = 6.0,
											displace7 = 7.0,
											displace8 = 8.0))
		self.setHardpointServerStatus(serverAddr = 84, mode = 50, status = 0, faults = 0)
		self.setHardpointServerStatus(serverAddr = 85, mode = 50, status = 0, faults = 0)
		self.setHardpointServerStatus(serverAddr = 86, mode = 50, status = 0, faults = 0)
		self.setHardpointServerStatus(serverAddr = 87, mode = 50, status = 0, faults = 0)
		self.setHardpointServerStatus(serverAddr = 88, mode = 50, status = 0, faults = 0)
		self.setHardpointServerStatus(serverAddr = 89, mode = 50, status = 0, faults = 0)
		self.setHardpointServerID(serverAddr = 1, uniqueId = 1, ilcAppType = 2, networkNodeType = 2, ilcSelectedOptions = 0, 
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HP")
		self.setHardpointServerID(serverAddr = 2, uniqueId = 2, ilcAppType = 2, networkNodeType = 2, ilcSelectedOptions = 0, 
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HP")
		self.setHardpointServerID(serverAddr = 3, uniqueId = 3, ilcAppType = 2, networkNodeType = 2, ilcSelectedOptions = 0, 
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HP")
		self.setHardpointServerID(serverAddr = 4, uniqueId = 4, ilcAppType = 2, networkNodeType = 2, ilcSelectedOptions = 0, 
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HP")
		self.setHardpointServerID(serverAddr = 5, uniqueId = 5, ilcAppType = 2, networkNodeType = 2, ilcSelectedOptions = 0, 
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HP")
		self.setHardpointServerID(serverAddr = 6, uniqueId = 6, ilcAppType = 2, networkNodeType = 2, ilcSelectedOptions = 0, 
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HP")
		self.setHardpointServerID(serverAddr = 84, uniqueId = 11, ilcAppType = 7, networkNodeType = 7, ilcSelectedOptions = 0,
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HM")
		self.setHardpointServerID(serverAddr = 85, uniqueId = 12, ilcAppType = 7, networkNodeType = 7, ilcSelectedOptions = 0,
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HM")
		self.setHardpointServerID(serverAddr = 86, uniqueId = 13, ilcAppType = 7, networkNodeType = 7, ilcSelectedOptions = 0,
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HM")
		self.setHardpointServerID(serverAddr = 87, uniqueId = 14, ilcAppType = 7, networkNodeType = 7, ilcSelectedOptions = 0,
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HM")
		self.setHardpointServerID(serverAddr = 88, uniqueId = 15, ilcAppType = 7, networkNodeType = 7, ilcSelectedOptions = 0,
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HM")
		self.setHardpointServerID(serverAddr = 89, uniqueId = 16, ilcAppType = 7, networkNodeType = 7, ilcSelectedOptions = 0,
					networkNodeOptions = 0, majorRev = 8, minorRev = 0, firmwareName = "Mock-HM")
		self.setHardpointForceAndStatus(serverAddr = 1, statusByte = 0, ssiEncoderValue = 1001, loadCellForce = 1.5)
		self.setHardpointForceAndStatus(serverAddr = 2, statusByte = 0, ssiEncoderValue = 1002, loadCellForce = 2.5)
		self.setHardpointForceAndStatus(serverAddr = 3, statusByte = 0, ssiEncoderValue = 1003, loadCellForce = 3.5)
		self.setHardpointForceAndStatus(serverAddr = 4, statusByte = 0, ssiEncoderValue = 1004, loadCellForce = 4.5)
		self.setHardpointForceAndStatus(serverAddr = 5, statusByte = 0, ssiEncoderValue = 1005, loadCellForce = 5.5)
		self.setHardpointForceAndStatus(serverAddr = 6, statusByte = 0, ssiEncoderValue = 1006, loadCellForce = 6.5)
		self.setHardpointDisplacementLVDT(serverAddr = 84, lvdt1 = -0.1, lvdt2 = 0.2)
		self.setHardpointDisplacementLVDT(serverAddr = 85, lvdt1 = -1.1, lvdt2 = 1.2)
		self.setHardpointDisplacementLVDT(serverAddr = 86, lvdt1 = -2.1, lvdt2 = 2.2)
		self.setHardpointDisplacementLVDT(serverAddr = 87, lvdt1 = -3.1, lvdt2 = 3.2)
		self.setHardpointDisplacementLVDT(serverAddr = 88, lvdt1 = -4.1, lvdt2 = 4.2)
		self.setHardpointDisplacementLVDT(serverAddr = 89, lvdt1 = -5.1, lvdt2 = 5.2)
		self.setHardpointDCAPressure(serverAddr = 84, pressure1AxialPush = 0.1, pressure2AxialPull = 0.0, pressure3LateralPull = 0.0, pressure4LateralPush = 0.0)
		self.setHardpointDCAPressure(serverAddr = 85, pressure1AxialPush = 1.1, pressure2AxialPull = 0.0, pressure3LateralPull = 0.0, pressure4LateralPush = 0.0)
		self.setHardpointDCAPressure(serverAddr = 86, pressure1AxialPush = 2.1, pressure2AxialPull = 0.0, pressure3LateralPull = 0.0, pressure4LateralPush = 0.0)
		self.setHardpointDCAPressure(serverAddr = 87, pressure1AxialPush = 3.1, pressure2AxialPull = 0.0, pressure3LateralPull = 0.0, pressure4LateralPush = 0.0)
		self.setHardpointDCAPressure(serverAddr = 88, pressure1AxialPush = 4.1, pressure2AxialPull = 0.0, pressure3LateralPull = 0.0, pressure4LateralPush = 0.0)
		self.setHardpointDCAPressure(serverAddr = 89, pressure1AxialPush = 5.1, pressure2AxialPull = 0.0, pressure3LateralPull = 0.0, pressure4LateralPush = 0.0)	
		self.setHardpointMonitorMezzanineID(serverAddr=84, dcaUniqueId=1007, firmwareType=54, firmwareVersion=0x0802)
		self.setHardpointMonitorMezzanineID(serverAddr=85, dcaUniqueId=1008, firmwareType=54, firmwareVersion=0x0802)
		self.setHardpointMonitorMezzanineID(serverAddr=86, dcaUniqueId=1009, firmwareType=54, firmwareVersion=0x0802)
		self.setHardpointMonitorMezzanineID(serverAddr=87, dcaUniqueId=1010, firmwareType=54, firmwareVersion=0x0802)
		self.setHardpointMonitorMezzanineID(serverAddr=88, dcaUniqueId=1011, firmwareType=54, firmwareVersion=0x0802)
		self.setHardpointMonitorMezzanineID(serverAddr=89, dcaUniqueId=1012, firmwareType=54, firmwareVersion=0x0802)

		# Force Actuator Default settings
		for row in forceActuatorTable:
			# Each row in forceActuatorTable is itself an array.
			index = row[forceActuatorTableIndexIndex]
			subnet = row[forceActuatorTableSubnetIndex]
			address = row[forceActuatorTableAddressIndex]
			actuatorID = row[forceActuatorTableIDIndex]
			if address <= 16:
				self.setSinglePneumaticAxisForce(subnet = subnet, serverAddr = address, statusByte = 0, loadCellForce = actuatorID)
				self.setSinglePneumaticForceAndStatus(subnet = subnet, serverAddr = address, statusByte = 0, loadCellForce = actuatorID)
				self.setServerID(subnet = subnet, serverAddr = address, uniqueId = actuatorID, ilcAppType = 2, networkNodeType = 2, ilcSelectedOptions = 0,
						networkNodeOptions = 0, majorRev = 8, minorRev = 2, firmwareName = "Mock-FA")
			else:
				self.setDualPneumaticAxisForce(subnet = subnet, serverAddr = address, statusByte = 0, 
									axialLoadCellForce = actuatorID, lateralLoadCellForce = actuatorID)
				self.setDualPneumaticForceAndStatus(subnet = subnet, serverAddr = address, statusByte = 0,
									axialLoadCellForce = actuatorID, lateralLoadCellForce = actuatorID - 1)
				self.setServerID(subnet = subnet, serverAddr = address, uniqueId = actuatorID, ilcAppType = 2, networkNodeType = 2, ilcSelectedOptions = 2,
						networkNodeOptions = 2, majorRev = 8, minorRev = 2, firmwareName = "Mock-FA")

			self.setServerStatus(subnet = subnet, serverAddr = address, mode = 0, status = 0, faults = 0)
			self.setMezzanineID(subnet = subnet, serverAddr = address, dcaUniqueId = actuatorID + 1000, firmwareType=52, firmwareVersion=0x0802)
			# Set ILC default calibration values
			self.setCalibrationData(subnet = subnet, serverAddr = address, 
						mainAdcCalibration1 = index, mainAdcCalibration2 = index + 1, mainAdcCalibration3 = index + 2, mainAdcCalibration4 = index + 3,
						mainSensorOffset1 = index + 100, mainSensorOffset2 = index + 101, mainSensorOffset3 = index + 102, mainSensorOffset4 = index + 103,
						mainSensorSensitivity1 = index + 1000, mainSensorSensitivity2 = index + 1001, mainSensorSensitivity3 = index + 1002, mainSensorSensitivity4 = index + 1003,
						backupAdcCalibration1 = actuatorID + 1, backupAdcCalibration2 = actuatorID + 2, backupAdcCalibration3 = actuatorID + 3, backupAdcCalibration4 = actuatorID + 4,
						backupSensorOffset1 = actuatorID + 100, backupSensorOffset2 = actuatorID + 101, backupSensorOffset3 = actuatorID + 102, backupSensorOffset4 = actuatorID + 103,
						backupSensorSensitivity1 = actuatorID + 1000, backupSensorSensitivity2 = actuatorID + 1001, backupSensorSensitivity3 = actuatorID + 1002, 
						backupSensorSensitivity4 = actuatorID + 1003)
			self.setAdcSampleRate(subnet = subnet, serverAddr = address, scanRateCode = 8)
			self.setBoostValueDcaGains(subnet = subnet, serverAddr = address, axialBoostValveGain = 1.0, lateralBoostValveGain = 1.0)
