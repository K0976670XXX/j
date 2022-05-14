*D_latch_3
.model N NMOS (KP=20u VT0=+1V Lambda=0.2)
.model P PMOS (KP=10u VT0=-1V Lambda=0.2)

VDD VDD gnd dc 5V;
Vclk CLK GND pulse (0V 5V 0u 0.1u 0.1u 17u 38u);
VD D GND pulse (0V 5V 0u 0.1u 0.1u 15u 30u);

XD D CLK Q QB VDD GND Dlatch3;

.subckt Dlatch3 D CLK Q QB VDD GND
x1 CLK G1 VDD GND inv;
X2 D G1 P PB VDD GND Dlatch1;
X3 P CLK GND GND Q QB VDD GND Dlatch2;
.ends

.subckt inv in out VDD GND
MP1 out in VDD VDD P L=1u W=4u;
MN1 out in GND GND N L=1u W=2u;
.ends

.subckt nand2 A B out VDD GND
MP1 out A VDD VDD P L=1u W=4u;
MP2 out B VDD VDD P L=1u W=4u;
MN1 out A 1 GND N L=1u W=2u;
MN2 1 B GND GND N L=1u W=2u;
.ends

.subckt nand3 A B C out VDD GND
MP1 out A VDD VDD P L=1u W=6u;
MP2 out B VDD VDD P L=1u W=6u;
MP3 out C VDD VDD P L=1u W=6u;
MN1 out A 1 GND N L=1u W=2u;
MN2 1 B 2 GND N L=1u W=2u;
MN3 2 C GND GND N L=1u W=2u;
.ends

.subckt Dlatch1 D CLK Q QB VDD GND
x1 D CLK SB VDD GND nand2;
x2 D 1 VDD GND inv;
x3 1 CLK RB VDD GND nand2;
x4 SB QB Q VDD GND nand2;
x5 RB Q QB VDD GND nand2;
.ends
.subckt Dlatch2 D CLK clear reset Q QB VDD GND
x1 D CLK SB VDD GND nand2;
x2 D 1 VDD GND inv;
x3 1 CLK RB VDD GND nand2;
x4 reset resetB VDD GND inv;
x5 clear clearB VDD GND inv;
x6 resetB SB QB Q VDD GND nand3;
x7 Q RB clearB QB VDD GND nand3;
.ends
.trans 0.1u 280u
.end
