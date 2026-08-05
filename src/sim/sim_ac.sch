v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1680 -1090 1680 -1070 {lab=0}
N 1780 -1190 1780 -1150 {lab=Vnn}
N 1900 -1190 1900 -1150 {lab=Vnp}
N 2000 -1200 2000 -1150 {lab=Vpn}
N 2100 -1200 2100 -1150 {lab=Vpp}
N 1900 -1060 1900 -1030 {lab=0}
N 1680 -1190 1680 -1150 {lab=VDD_3V3}
N 1680 -1070 1680 -1030 {lab=0}
N 1820 -710 1820 -690 {lab=GND}
N 1820 -810 1820 -770 {lab=Von}
N 1980 -710 1980 -690 {lab=GND}
N 1980 -810 1980 -770 {lab=Vop}
N 1180 -1120 1180 -1090 {lab=0}
N 1100 -1170 1140 -1170 {lab=Von}
N 1100 -1130 1140 -1130 {lab=Vop}
N 1180 -1230 1180 -1180 {lab=Vout_diff}
N 1180 -1230 1270 -1230 {lab=Vout_diff}
N 1180 -1090 1260 -1090 {lab=0}
N 1260 -1120 1260 -1090 {lab=0}
N 1260 -1230 1260 -1180 {lab=Vout_diff}
N 1780 -1090 1780 -1060 {lab=0}
N 1780 -1060 1910 -1060 {lab=0}
N 1900 -1090 1900 -1060 {lab=0}
N 1910 -1060 2000 -1060 {lab=0}
N 2000 -1090 2000 -1060 {lab=0}
N 2000 -1060 2100 -1060 {lab=0}
N 2100 -1090 2100 -1060 {lab=0}
C {title-3.sym} 0 0 0 0 {name=F1
title="FDDA with Native MOS CMFB"
author="UFJF On Chip"
rev=1.0
page="1"
pages="1"
lock=true
"
}
C {code_shown.sym} 60 -670 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice cap_mim
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice moscap_typical
.lib $::180MCU_MODELS/sm141064.ngspice mimcap_typical

"
}
C {code_shown.sym} 60 -470 0 0 {name=NGSPICE only_toplevel=true
value="
.param inputValue=1.65
.global VDD_3V3

.control
  save all
  ac dec 1000 1 100Meg  

  let Vop_db = db(Vop)
  let Vop_ph = phase(Vop)*180/pi
  let Von_db = db(Von)
  let Von_ph = phase(Von)*180/pi
  let Vout_diff_db = db(Vout_diff)
  let Vout_diff_ph = phase(Vout_diff)*180/pi
  
  write sim_ac.raw
.endc
"}
C {vsource.sym} 1780 -1120 0 0 {name=V1 value="'inputValue' ac 0.25 0" savecurrent=true}
C {vsource.sym} 1900 -1120 0 0 {name=V2 value="'inputValue' ac 0.25 180" savecurrent=true}
C {vsource.sym} 2000 -1120 0 0 {name=V3 value="'inputValue' ac 0.25 180" savecurrent=true}
C {vsource.sym} 2100 -1120 0 0 {name=V4 value="'inputValue' ac 0.25 0" savecurrent=true}
C {vsource.sym} 1680 -1120 0 0 {name=Vdd value=3.3 savecurrent=true}
C {lab_wire.sym} 1780 -1190 0 1 {name=p10 sig_type=std_logic lab=Vnn}
C {lab_wire.sym} 1900 -1190 0 1 {name=p12 sig_type=std_logic lab=Vnp}
C {lab_wire.sym} 2000 -1200 0 1 {name=p14 sig_type=std_logic lab=Vpn}
C {lab_wire.sym} 2100 -1200 0 1 {name=p20 sig_type=std_logic lab=Vpp}
C {gnd.sym} 1900 -1030 0 0 {name=l5 lab=0}
C {vdd.sym} 1680 -1190 0 0 {name=l10 lab=VDD_3V3}
C {gnd.sym} 1680 -1030 0 0 {name=l13 lab=0}
C {launcher.sym} 130 -770 0 0 {name=h1
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"}
C {capa.sym} 1820 -740 2 0 {name=C1
m=1
value=16p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1820 -690 0 0 {name=l4 lab=GND}
C {lab_wire.sym} 1820 -810 0 1 {name=p21 sig_type=std_logic lab=Von}
C {capa.sym} 1980 -740 2 0 {name=C4
m=1
value=16p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1980 -690 0 0 {name=l14 lab=GND}
C {lab_wire.sym} 1980 -810 0 1 {name=p23 sig_type=std_logic lab=Vop}
C {chipathon-2026-fdda/src/fdda.sym} 1270 -800 0 0 {name=x1}
C {lab_wire.sym} 1310 -770 0 1 {name=p1 sig_type=std_logic lab=Von}
C {lab_wire.sym} 1310 -830 0 1 {name=p2 sig_type=std_logic lab=Vop}
C {lab_wire.sym} 1120 -770 0 0 {name=p3 sig_type=std_logic lab=Vnn}
C {lab_wire.sym} 1120 -750 0 0 {name=p4 sig_type=std_logic lab=Vnp}
C {lab_wire.sym} 1120 -830 0 0 {name=p5 sig_type=std_logic lab=Vpn}
C {lab_wire.sym} 1120 -850 0 0 {name=p6 sig_type=std_logic lab=Vpp}
C {vcvs.sym} 1180 -1150 0 0 {name=E1 value=1.0}
C {gnd.sym} 1180 -1090 0 0 {name=l1 lab=0}
C {lab_wire.sym} 1100 -1130 0 0 {name=p7 sig_type=std_logic lab=Vop}
C {lab_wire.sym} 1100 -1170 0 0 {name=p8 sig_type=std_logic lab=Von}
C {res.sym} 1260 -1150 0 0 {name=R1
value=1Meg
footprint=1206
device=resistor
m=1}
C {lab_wire.sym} 1260 -1230 0 0 {name=p9 sig_type=std_logic lab=Vout_diff}
