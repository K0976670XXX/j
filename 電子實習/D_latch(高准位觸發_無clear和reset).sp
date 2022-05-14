*D_latch_1
.model N NMOS (KP=20u VT0=+1V Lambda=0.2)
.model P PMOS (KP=10u VT0=-1V Lambda=0.2)

VDD VDD gnd dc 5V

VR 	D 	gnd pulse (0V 5V 0u 0.1u 0.1u 90u 180u);
VS 	CLK gnd pulse (0V 5V 0u 0.1u 0.1u 110u 220u);
XD1 D CLK Q QB VDD gnd Dlatch1;

.subckt inv in out VDD gnd
MP1 out in VDD VDD P L=1u W=4u;
MN1 out in GND GND N L=1u W=2u;
.ends

.subckt nand2 A B out VDD gnd
MP1 out A VDD VDD P L=1u W=4u;
MP2 out B VDD VDD P L=1u W=4u;
MN1 out A 1 GND N L=1u W=2u;
MN2 1 B GND GND N L=1u W=2u;
.ends

.subckt Dlatch1 D CLK Q QB VDD gnd
x1 D CLK SB VDD gnd nand2;
x2 D 1 VDD gnd inv;
x3 1 CLK RB VDD gnd nand2;
x4 SB QB Q VDD gnd nand2;
x5 RB Q QB VDD gnd nand2;
.ends

.trans 0.1u 700u
.end

