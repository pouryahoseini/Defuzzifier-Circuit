Defuzzifier circuit

* Sources
.global	vdd

vdd	vdd	0	3.3
iq	vdd	b1	12u
vb	vb	0	0.55

*cload	out	0	100f		******No CLoad

* Initial condition
.ic v(out)=1

* Input signals
vcon1	vcon1	vcn1	pulse(1.2	1.2	0.1u	10n	10n	90n	200n)
vcon2	vcon2	vcn2	pulse(1.2	1.1	0.1u	10n	10n	90n	200n)		****range between: 0 v to 1.2 v
vcon3	vcon3	vcn3	pulse(1.2	0.9	0.1u	10n	10n	90n	200n)		****frequncy: 5 MHz
vcon4	vcon4	vcn4	pulse(1.2	0.6	0.1u	10n	10n	90n	200n)
vcon5	vcon5	vcn5	pulse(1.2	0.4	0.1u	10n	10n	90n	200n)
vcon6	vcon6	vcn6	pulse(1.2	0.1	0.1u	10n	10n	90n	200n)
vcon7	vcon7	vcn7	pulse(1.2	0.2	0.1u	10n	10n	90n	200n)

*vcon1	vcon1	vcn1	1.2
*vcon2	vcon2	vcn2	1.2
*vcon3	vcon3	vcn3	1.2
*vcon4	vcon4	vcn4	1.2
*vcon5	vcon5	vcn5	1.2
*vcon6	vcon6	vcn6	1.2
*vcon7	vcon7	vcn7	1.2

r1	vcon1	vb	100
r2	vcon2	vb	100
r3	vcon3	vb	100
r4	vcon4	vb	100
r5	vcon5	vb	100
r6	vcon6	vb	100
r7	vcon7	vb	100

r8	vcn1	vb	100
r9	vcn2	vb	100
r10	vcn3	vb	100
r11	vcn4	vb	100
r12	vcn5	vb	100
r13	vcn6	vb	100
r14	vcn7	vb	100

vinf1	vinf1	0	1.0		****upper range:1.9 v
vinf2	vinf2	0	1.15		****lower range:1.0 v
vinf3	vinf3	0	1.3
vinf4	vinf4	0	1.45
vinf5	vinf5	0	1.6
vinf6	vinf6	0	1.75
vinf7	vinf7	0	1.9

* Circuit shared among all transconductance amplifiers
m19	b1	b1	0	0	nch	l=0.4u	w=0.8u
m20	b2	b1	0	0	nch	l=0.4u	w=0.8u
m21	b2	b2	vdd	vdd	pch	l=0.4u	w=2.4u
***
m22	halfout	b2	vdd	vdd	pch	l=0.4u	w=2.4u
m23	halfout	halfout	vhalf	0	nch	l=1u	w=0.4u
m24	vhalf	b1	0	0	nch	l=0.4u	w=0.8u
***
m25	vdd	out	vhalf	0	nch	l=0.4u	w=4u
m26	vhalf	out	0	0	nch	l=0.4u	w=0.4u
****

* Instances of transconductance amplifier
x1	vinf1	halfout	vcon1	vcn1	out	b1	b2	ota
x2	vinf2	halfout	vcon2	vcn2	out	b1	b2	ota
x3	vinf3	halfout	vcon3	vcn3	out	b1	b2	ota
x4	vinf4	halfout	vcon4	vcn4	out	b1	b2	ota
x5	vinf5	halfout	vcon5	vcn5	out	b1	b2	ota
x6	vinf6	halfout	vcon6	vcn6	out	b1	b2	ota
x7	vinf7	halfout	vcon7	vcn7	out	b1	b2	ota

* Transconductance amplifier
.subckt	ota	vinf	halfout	vcon	vcn	out	b1	b2
m1	1	halfout	3	0	nch	l=0.4u	w=1u
m2	2	atvinf	3	0	nch	l=0.4u	w=1u
m3	1	atvinf	4	0	nch	l=0.4u	w=1u
m4	2	halfout	4	0	nch	l=0.4u	w=1u

m5	1	1	vdd	vdd	pch	l=0.4u	w=3u	
m6	2	2	vdd	vdd	pch	l=0.4u	w=3u

m7	3	vcon	0	0	nch	l=0.4u	w=2u
m8	4	vcn	0	0	nch	l=0.4u	w=2u

m9	7	1	vdd	vdd	pch	l=0.4u	w=3u
m10	out	2	vdd	vdd	pch	l=0.4u	w=6u
m11	7	7	0	0	nch	l=0.4u	w=1u
m12	out	7	0	0	nch	l=0.4u	w=2u

***
m13	vdd	vinf	bcm	0	nch	l=0.4u	w=4u
m14	bcm	vinf	0	0	nch	l=0.4u	w=0.4u
***

m15	atvinf	b2	vdd	vdd	pch	l=0.4u	w=2.4u
m16	atvinf	atvinf	bcm	0	nch	l=1u	w=0.4u
m17	bcm	b1	0	0	nch	l=0.4u	w=0.8u
.ends

*** Test settings
* Operating point
.op
.option	post

* Transient
.tran	10p	1u

* DC sweep
.dc	vcon1	0	1.2	0.05
.dc	vcon2	0	1.2	0.05
.dc	vcon3	0	1.2	0.05
.dc	vcon4	0	1.2	0.05
.dc	vcon5	0	1.2	0.05
.dc	vcon6	0	1.2	0.05
.dc	vcon7	0	1.2	0.05

* Define technology file
.lib	'mm0355v.l'	tt

* Corners
.alter
.temp=0
.alter
.temp=125
.alter
.lib	'mm0355v.l'	ff
.alter
.lib	'mm0355v.l'	fs
.alter
.lib	'mm0355v.l'	sf
.alter
.lib	'mm0355v.l'	ss

.end