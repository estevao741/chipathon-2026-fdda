v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1100 -1290 1100 -1270 {lab=0}
N 1100 -1370 1100 -1350 {lab=VDD_3V3}
N 1100 -1270 1100 -1260 {lab=0}
N 1340 -990 1400 -990 {lab=Vout_neg}
N 1400 -990 1400 -910 {lab=Vout_neg}
N 1120 -900 1400 -900 {lab=Vout_neg}
N 1120 -970 1120 -910 {lab=Vout_neg}
N 1120 -970 1150 -970 {lab=Vout_neg}
N 1340 -1050 1400 -1050 {lab=Vout_pos}
N 1400 -1140 1400 -1050 {lab=Vout_pos}
N 1120 -1140 1400 -1140 {lab=Vout_pos}
N 1120 -1140 1120 -1070 {lab=Vout_pos}
N 1120 -1070 1150 -1070 {lab=Vout_pos}
N 1060 -1050 1150 -1050 {lab=Vin_pos}
N 1060 -990 1150 -990 {lab=Vin_neg}
N 1400 -1050 1440 -1050 {lab=Vout_pos}
N 1400 -990 1440 -990 {lab=Vout_neg}
N 1400 -910 1400 -900 {lab=Vout_neg}
N 1120 -910 1120 -900 {lab=Vout_neg}
N 1400 -1240 1400 -1220 {lab=Vin_neg}
N 1400 -1420 1400 -1400 {lab=Vin_pos}
N 1400 -1320 1400 -1300 {lab=#net1}
N 1400 -1340 1400 -1320 {lab=#net1}
N 1360 -1320 1400 -1320 {lab=#net1}
N 1260 -1320 1300 -1320 {lab=0}
N 1260 -1320 1260 -1300 {lab=0}
N 1180 -700 1180 -680 {lab=0}
N 1180 -700 1260 -700 {lab=0}
N 1260 -720 1260 -700 {lab=0}
N 1260 -700 1260 -680 {lab=0}
N 1260 -820 1260 -780 {lab=Vout_pos}
N 1260 -620 1260 -580 {lab=Vout_neg}
C {title-3.sym} 0 0 0 0 {name=F1
title="FDDA with Native MOS CMFB"
author="UFJF On Chip"
rev=1.0
page="1"
pages="1"
lock=true
"
}
C {vsource.sym} 1100 -1320 0 0 {name=Vdd value=3.3 savecurrent=true}
C {vdd.sym} 1100 -1370 0 0 {name=l10 lab=VDD_3V3}
C {gnd.sym} 1100 -1260 0 0 {name=l13 lab=0}
C {capa.sym} 1260 -750 0 0 {name=C1
m=1
value=16p
footprint=1206
device="ceramic capacitor"
}
C {capa.sym} 1260 -650 2 0 {name=C4
m=1
value=16p
footprint=1206
device="ceramic capacitor"
}
C {gnd.sym} 1180 -680 0 0 {name=l14 lab=0}
C {lab_wire.sym} 1400 -1220 2 1 {name=p21 sig_type=std_logic lab=Vin_neg}
C {lab_wire.sym} 1400 -1420 0 1 {name=p23 sig_type=std_logic lab=Vin_pos}
C {lab_wire.sym} 1440 -990 0 1 {name=p1 sig_type=std_logic lab=Vout_neg}
C {lab_wire.sym} 1440 -1050 0 1 {name=p2 sig_type=std_logic lab=Vout_pos}
C {lab_wire.sym} 1060 -1050 0 0 {name=p3 sig_type=std_logic lab=Vin_pos}
C {lab_wire.sym} 1060 -990 0 0 {name=p4 sig_type=std_logic lab=Vin_neg}
C {lab_wire.sym} 1260 -820 0 1 {name=p7 sig_type=std_logic lab=Vout_pos}
C {lab_wire.sym} 1260 -580 2 0 {name=p8 sig_type=std_logic lab=Vout_neg}
C {chipathon-2026-fdda/src/fdda.sym} 1300 -1020 0 0 {name=x1}
C {code_shown.sym} 60 -1010 0 0 {name=MODELS1 only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice cap_mim
.lib $::180MCU_MODELS/sm141064.ngspice moscap_typical
.lib $::180MCU_MODELS/sm141064.ngspice mimcap_typical

"
}
C {launcher.sym} 120 -1090 0 0 {name=h2
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"}
C {code_shown.sym} 60 -790 0 0 {name=NGSPICE1 only_toplevel=true
value="
.options savecurrents
.global VDD_3V3
.param inputPeak=.9
.param inputOffset=1.65

.control
  save all
  tran 1n 10u
  
  * Find required data values
  meas tran von_max max v(vout_pos)
  let von_swing = von_max - 1.65
  let V1 = 1.65 + (0.1 * von_swing)
  let V2 = 1.65 + (0.9 * von_swing)

  * Calculate Slew Rate
  meas tran t1 when v(vout_pos)=V1 rise=1
  meas tran t2 when v(vout_pos)=V2 rise=1
  let slew_rate = ((V2 - V1) / (t2 - t1)) / 1e6

  write sim_tran_square.raw
  echo 'Slew Rate = $&slew_rate [V/us]'
  echo 'Simulation data:' > /foss/designs/simulation_log.txt
  echo 'Slew Rate = $&slew_rate [V/us]' >> /foss/designs/simulation_log.txt
  echo '' >> /foss/designs/simulation_log.txt
  echo 'Circuit data:' >> /foss/designs/simulation_log.txt
  show all >> /foss/designs/simulation_log.txt
.endc
"}
C {gnd.sym} 1260 -1300 0 0 {name=l4 lab=0}
C {vsource.sym} 1400 -1370 0 0 {name=V3 value="pulse(0 \{inputPeak\} 2u .1n .1n 5u 100u)" savecurrent=true}
C {vsource.sym} 1400 -1270 0 0 {name=V2 value="pulse(0 \{inputPeak\} 2u .1n .1n 5u 100u)" savecurrent=true}
C {vsource.sym} 1330 -1320 1 0 {name=V4 value=\{inputOffset\} savecurrent=true}
