#!/bin/bash
state=$1
var="$(tr '[:lower:]' '[:upper:]' <<< ${state:0:1})${state:1}"
tolerance=0.001

hpencoder1=$(python -S -c "import random; print random.randrange(-500000,500000)")
hpencoder2=$(python -S -c "import random; print random.randrange(-500000,500000)")
hpencoder3=$(python -S -c "import random; print random.randrange(-500000,500000)")
hpencoder4=$(python -S -c "import random; print random.randrange(-500000,500000)")
hpencoder5=$(python -S -c "import random; print random.randrange(-500000,500000)")
hpencoder6=$(python -S -c "import random; print random.randrange(-500000,500000)")

hpforce1=$(python -S -c "import random; print float(random.randrange(-50000000,50000000))/10000")
hpforce2=$(python -S -c "import random; print float(random.randrange(-50000000,50000000))/10000")
hpforce3=$(python -S -c "import random; print float(random.randrange(-50000000,50000000))/10000")
hpforce4=$(python -S -c "import random; print float(random.randrange(-50000000,50000000))/10000")
hpforce5=$(python -S -c "import random; print float(random.randrange(-50000000,50000000))/10000")
hpforce6=$(python -S -c "import random; print float(random.randrange(-50000000,50000000))/10000")

temp=$(tr '[:upper:]' '[:lower:]' <<< $state)
if [[ "$temp" == "raising" || "$temp" == "lowering" || "$temp" == "raisingengineering" || "$temp" == "loweringengineering" ]]; then
	hpforce1=0
	hpforce2=0
	hpforce3=0
	hpforce4=0
	hpforce5=0
	hpforce6=0
	hpencoder1=0
	hpencoder2=0
	hpencoder3=0
	hpencoder4=0
	hpencoder5=0
	hpencoder6=0
fi

hplvdt11=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")
hplvdt12=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")
hplvdt13=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")
hplvdt14=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")
hplvdt15=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")
hplvdt16=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")

hplvdt21=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")
hplvdt22=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")
hplvdt23=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")
hplvdt24=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")
hplvdt25=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")
hplvdt26=$(python -S -c "import random; print float(random.randrange(-100000,100000))/10000")

hppresssure1AxialPush1=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppresssure1AxialPush2=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppresssure1AxialPush2=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppresssure1AxialPush3=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppresssure1AxialPush4=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppresssure1AxialPush5=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppresssure1AxialPush6=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")

hppressure2AxialPull1=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure2AxialPull2=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure2AxialPull3=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure2AxialPull4=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure2AxialPull5=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure2AxialPull6=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")

hppressure3LateralPull1=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure3LateralPull2=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure3LateralPull3=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure3LateralPull4=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure3LateralPull5=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure3LateralPull6=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")

hppressure4LateralPush1=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure4LateralPush2=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure4LateralPush3=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure4LateralPush4=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure4LateralPush5=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")
hppressure4LateralPush6=$(python -S -c "import random; print float(random.randrange(0,1250000))/10000")

echo "############ BEGIN Verify Hardpoint Data Telemetry - ${state^^} ############"
echo ""
echo "Set Hardpoint Forces And Statuses - $var"
echo "    [Tags]    functional"
echo "    Comment    Set Encoders (third argument) and Forces (fourth argument) to 0 while raising or lowering, or operation will time-out and induce a Fault."
echo "    Set Hardpoint Force And Status    \${1}   \${0}    \${$hpencoder1}    \${$hpforce1}"
echo "    Set Hardpoint Force And Status    \${2}   \${0}    \${$hpencoder2}    \${$hpforce2}"
echo "    Set Hardpoint Force And Status    \${3}   \${0}    \${$hpencoder3}    \${$hpforce3}"
echo "    Set Hardpoint Force And Status    \${4}   \${0}    \${$hpencoder4}    \${$hpforce4}"
echo "    Set Hardpoint Force And Status    \${5}   \${0}    \${$hpencoder5}    \${$hpforce5}"
echo "    Set Hardpoint Force And Status    \${6}   \${0}    \${$hpencoder6}    \${$hpforce6}"
echo ""
echo "Set Hardpoint Displacement LVDTs - $var"
echo "    [Tags]    functional"
echo "    Set Hardpoint Displacement LVDT    \${84}   \${$hplvdt11}    \${$hplvdt21}"
echo "    Set Hardpoint Displacement LVDT    \${85}   \${$hplvdt12}    \${$hplvdt22}"
echo "    Set Hardpoint Displacement LVDT    \${86}   \${$hplvdt13}    \${$hplvdt23}"
echo "    Set Hardpoint Displacement LVDT    \${87}   \${$hplvdt14}    \${$hplvdt24}"
echo "    Set Hardpoint Displacement LVDT    \${88}   \${$hplvdt15}    \${$hplvdt25}"
echo "    Set Hardpoint Displacement LVDT    \${89}   \${$hplvdt16}    \${$hplvdt26}"
echo ""
echo "Set Hardpoint Pressures - $var"
echo "    [Tags]    functional"
echo "    Set Hardpoint DCA Pressure    \${84}    \${$hppresssure1AxialPush1}    \${$hppressure2AxialPull1}    \${$hppressure3LateralPull1}    \${$hppressure4LateralPush1}"
echo "    Set Hardpoint DCA Pressure    \${85}    \${$hppresssure1AxialPush2}    \${$hppressure2AxialPull2}    \${$hppressure3LateralPull2}    \${$hppressure4LateralPush2}"
echo "    Set Hardpoint DCA Pressure    \${86}    \${$hppresssure1AxialPush3}    \${$hppressure2AxialPull3}    \${$hppressure3LateralPull3}    \${$hppressure4LateralPush3}"
echo "    Set Hardpoint DCA Pressure    \${87}    \${$hppresssure1AxialPush4}    \${$hppressure2AxialPull4}    \${$hppressure3LateralPull4}    \${$hppressure4LateralPush4}"
echo "    Set Hardpoint DCA Pressure    \${88}    \${$hppresssure1AxialPush5}    \${$hppressure2AxialPull5}    \${$hppressure3LateralPull5}    \${$hppressure4LateralPush5}"
echo "    Set Hardpoint DCA Pressure    \${89}    \${$hppresssure1AxialPush6}    \${$hppressure2AxialPull6}    \${$hppressure3LateralPull6}    \${$hppressure4LateralPush6}"
echo ""
echo "Get Hardpoint Data Telemetry - $var"
echo "    [Tags]    functional"
echo "    Sleep    300ms    Wait for next outer loop cycle"
echo "    \${valid}    \${hpdata}=    Get Hardpoint Data Telemetry"
echo "    Set Suite Variable    \${hpdata}"
echo "    Should Be True    \${valid}"
echo ""
echo "Verify Hardpoint Data Telemetry - BreakawayLVDT - $var"
echo "    [Tags]    functional"
echo "    Verify Irrational Array    \${hpdata}    BreakawayLVDT    \${$tolerance}    \${$hplvdt11}    \${$hplvdt12}    \${$hplvdt13}    \${$hplvdt14}    \${$hplvdt15}    \${$hplvdt16}"
echo ""
echo "Verify Hardpoint Data Telemetry - BreakawayPressure - $var"
echo "    [Tags]    functional"
echo "    Verify Irrational Array    \${hpdata}    BreakawayPressure    \${$tolerance}    \${$hppresssure1AxialPush1}    \${$hppresssure1AxialPush2}    \${$hppresssure1AxialPush3}    \${$hppresssure1AxialPush4}    \${$hppresssure1AxialPush5}    \${$hppresssure1AxialPush6}"
echo ""
echo "Verify Hardpoint Data Telemetry - DisplacementLVDT - $var"
echo "    [Tags]    functional"
echo "    Verify Irrational Array    \${hpdata}    DisplacementLVDT    \${$tolerance}    \${$hplvdt21}    \${$hplvdt22}    \${$hplvdt23}    \${$hplvdt24}    \${$hplvdt25}    \${$hplvdt26}"
echo ""
echo "Verify Hardpoint Data Telemetry - Encoder - $var"
echo "    [Tags]    functional"
echo "    Verify Rational Array    \${hpdata}    Encoder    \${$hpencoder1}    \${$hpencoder2}    \${$hpencoder3}    \${$hpencoder4}    \${$hpencoder5}    \${$hpencoder6}"
echo ""
echo "Verify Hardpoint Data Telemetry - Force - $var"
echo "    [Tags]    functional"
echo "    Verify Irrational Array    \${hpdata}    Force    \${$tolerance}    \${$hpforce1}    \${$hpforce2}    \${$hpforce3}    \${$hpforce4}    \${$hpforce5}    \${$hpforce6}"
echo ""
echo "############ END Verify Hardpoint Data Telemetry - ${state^^} ############"

