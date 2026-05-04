
;R.A.M.B.O.-First Blood Part II
;
;This.is.only the Loading Music!!
;
;Composed, Arranged & Programmed
;by.Martin Galway,12th November
;
;(C).Ocean Software 1985
;
;================================
;CAREFUL- LIMITED  SSI VERSION!!!
;================================
;
endS                EQU .
MOBJlengt           EQU DE-MUS
endO                EQU DE
;
Ret                 EQU $C0
Volume              EQU $C2
WrDat               EQU $C4
Freq                EQU $C6
Pulse               EQU $C8
Call                EQU $CA
Transp              EQU $CC
CT                  EQU $CE
;
DPoke               EQU $D0
JT                  EQU $D2
Code                EQU $D4
SPoke               EQU $D6
Chord               EQU $D8
loop                EQU $DA
Next                EQU $DC
Rest                EQU 95
Sil                 EQU 94
;
Z0                  EQU $10;ZERO-PAGE
Z1                  EQU Z0+1;WORKSPACE
Z2                  EQU Z0+2;STARTS AT $10
Z3                  EQU Z0+3;(FOR 16 BYTES)
Z4                  EQU Z0+4
Z5                  EQU Z0+5
Z6                  EQU Z0+6
Z7                  EQU Z0+7
Z8                  EQU Z0+8
Z9                  EQU Z0+9
ZA                  EQU Z0+10
ZB                  EQU Z0+11
ZC                  EQU Z0+12
ZD                  EQU Z0+13
ZE                  EQU Z0+14
ZF                  EQU Z0+15
;
;=========Driver Code...=========
;

                    ORG $1000

START               ENT
                    SEI
                    LDX #15:STX $D418;*
;
;this.delay simulates BILLOADER
;loading.in the music program
;
                    LDY #0
d                   DEX:BNE d
d2                  DEX:BNE d2
                    DEY:BNE d
;
;main.loop
;
                    JSR MUS+3;*
L                   LDA $D012:CMP #99:BNE L
                    INC $D020
                    JSR MUS+0;*
                    LDA #0:STA $D020
                    JSR MUS+6;*
                    BNE L
;
;finished
;
                    INC $D020:JMP .-3
;
;================================
;=========Actual Code...=========
;
MUS                 JMP REFRESH
                    JMP STOPSTART
                    JMP MUSICTEST
;
trnsfrpl0           LDX SB0+22:LDY SB0+23
                    STX SB0+35:STY SB0+36
                    LDA SB0+14:STA SB0+37
                    LDA SB0+15:STA SB0+38
                    RTS
;
trnsfrpl1           LDX SB1+22:LDY SB1+23
                    STX SB1+35:STY SB1+36
                    LDA SB1+14:STA SB1+37
                    LDA SB1+15:STA SB1+38
                    RTS
;
trnsfrpl2           LDX SB2+22:LDY SB2+23
                    STX SB2+35:STY SB2+36
                    LDA SB2+14:STA SB2+37
                    LDA SB2+15:STA SB2+38
                    RTS
;
trnsferf0           LDA SB0+11:STA SB0+34
                    LDA SB0+10:STA SB0+33
                    LDA SB0+9:STA SB0+32
                    LDA SB0+8:STA SB0+31
                    RTS
;
trnsferf1           LDA SB1+11:STA SB1+34
                    LDA SB1+10:STA SB1+33
                    LDA SB1+9:STA SB1+32
                    LDA SB1+8:STA SB1+31
                    RTS
;
trnsferf2           LDA SB2+11:STA SB2+34
                    LDA SB2+10:STA SB2+33
                    LDA SB2+9:STA SB2+32
                    LDA SB2+8:STA SB2+31
                    RTS
;
MUSIC0              LDA Z9:LSR
                    BCC jsound0
                    DEC ZA:BEQ read0
jsound0             JMP SOUND0
ad3c0               LDA #3
adc0                CLC:ADC Z0:STA Z0
                    BCC read0:INC Z1
read0               LDY #0:LDA (Z0),Y
                    CMP #192:BCC notctrl0
                    AND #63:TAX
                    LDA vt0,X:STA v0+1
                    LDA vt0+1,X:STA v0+2
                    INY:LDA (Z0),Y
                    TAX:STA Z6
                    INY:LDA (Z0),Y:STA Z7
v0                  JMP $FFFF
js0                 JMP st0
notctrl0            STA Z8:CMP #96
                    BCC idr0:SBC #96
idr0                CMP #Rest:BEQ js0
                    ADC DB0+73
gotnote0            TAX
NOTE0               LDY #4
n0sl2               LDA #0:STA $D402,Y
                    LDA DB0+22,Y
                    STA $D402,Y
                    DEY:BPL n0sl2
                    LDA DB0+24:STA SB0+26
dln0                LDY HIFRQ,X:LDA LOFRQ,X
                    STA SB0+29:STY SB0+30
                    STA $D400:STY $D401
dlp0                LDA DB0+17:STA SB0+17
                    BEQ dlf0:LDY #9
dlpl0               LDA DB0+14,Y
                    STA SB0+14,Y
                    DEY:BPL dlpl0
                    JSR trnsfrpl0
dlf0                LDX DB0+13:STX SB0+13
                    BEQ dld0:LDY #13
dlfl0               LDA DB0,Y:STA SB0,Y
                    DEY:BPL dlfl0
                    TXA:AND #8:BEQ nolm0
                    LDA Z8:CLC
                    ADC DB0+73:STA SB0+10
                    STY SB0+12
nolm0               JSR trnsferf0
dld0                LDX DB0+27:LDY DB0+28
                    STX SB0+27:STY SB0+28
st0                 LDY #1:LDA (Z0),Y
                    LDX Z8:CPX #96
                    BCS ddr0
                    TAX:LDA DB0+32,X
ddr0                STA ZA:LDA #2
adn0                CLC:ADC Z0:STA Z0
                    BCC dia0:INC Z1
dia0                JMP SOUND0
;
MC0                 EQU .
retrut0             INC ZD:LDY ZD
                    CPY #8:BEQ rc0
r0a                 LDX DB0+49,Y
                    LDA DB0+57,Y
                    JMP goto0
rc0                 LDA Z9:AND #%11111110
                    STA Z9:RTS
;
for0                LDX ZD:CLC
                    TYA:ADC Z0
                    STA DB0+49,X
                    LDA #0:ADC Z1
                    STA DB0+57,X
                    LDA Z6:STA DB0+65,X
                    DEC ZD:TYA:JMP adc0
;
next0               LDX ZD
                    DEC DB0+66,X:BEQ n0a
                    INX:TXA:TAY:BPL r0a
n0a                 INC ZD:LDA #1:JMP adc0
;
wrvol0              LDY #4:LDX #28
tr0                 LDA (Z6),Y:STA DB0,X
                    DEX:DEY:BPL tr0
                    JMP ad3c0
freq0               LDY #13:LDX #13:BNE tr0
pulse0              LDY #09:LDX #23:BNE tr0
wrall0              LDY #48:LDX #48:BNE tr0
chord0              LDY #09:LDX #09:BNE tr0
;
goto0l              LDA Z7
goto0               STX Z0:STA Z1
                    JMP read0
;
code0               LDA ^ad3c0-1:PHA
                    LDA #ad3c0-1:PHA
                    JMP (Z6)
;
call0               LDA #3
c0a                 LDY ZD
                    CLC:ADC Z0
                    STA DB0+49,Y
                    LDA #0:ADC Z1
                    STA DB0+57,Y
                    DEC ZD:JMP goto0l
;
callt0              INY:LDA (Z0),Y
                    STA DB0+73
                    LDA #4:BNE c0a
;
transp0             STX DB0+73
                    TYA:JMP adc0
;
pokedb0             STA DB0,X:JMP ad3c0
;
pokesb0             STA SB0,X:JMP ad3c0
;
nosound0            RTS
SOUND0              LDX SB0+28:BEQ nosound0
;
VC0                 LDA SB0+26:AND #8
                    BEQ adsr0
                    LDA ZA:CMP SB0+27
                    BCS PL0
                    LDA #00:STA SB0+27
                    LDA SB0+26:AND #246
                    STA SB0+26:BNE trigrel0
adsr0               LDA SB0+27:BNE ad0
                    DEC SB0+28:BNE PL0
                    LDX #6
cc0                 STA $D400,X:DEX:BPL cc0
                    RTS
ad0                 DEC SB0+27:BNE PL0
                    LDA SB0+26:AND #246
trigrel0            STA $D404
;
PL0                 LDA SB0+17:BEQ FC0
                    LDA SB0+16:BEQ plcdel0
                    DEC SB0+16:JMP FC0
plcdel0             CLC
                    LDX SB0+35:LDY SB0+36
plcs00              LDA SB0+37:BEQ plcs10
                    TXA:ADC SB0+18:TAX
                    TYA:ADC SB0+19:TAY
                    DEC SB0+37:JMP stpl0
plcs10              LDA SB0+38:BEQ plcrep0
                    TXA:ADC SB0+20:TAX
                    TYA:ADC SB0+21:TAY
                    DEC SB0+38:JMP stpl0
plcrep0             LDA SB0+17:AND #$81
                    BEQ stpl0:BPL nplcopy0
                    JSR trnsfrpl0
                    JMP plcdel0
nplcopy0            JSR trnsfrpl0+12
                    JMP plcdel0
stpl0               STX SB0+35:STY SB0+36
                    STX $D402:STY $D403
;
FC0                 LDA SB0+13:BEQ exit0
                    AND #8:BNE olm0
                    LDX SB0+29:LDY SB0+30
                    CLC
                    LDA SB0+12:BEQ fcs10+1
                    DEC SB0+12
                    LDA SB0+13:AND #2
                    BNE fcs40l1
exit0               RTS
olm0                LDX SB0+12:BPL no0
                    LDX SB0+11
no0                 LDA SB0+10:CLC
                    ADC SB0,X
                    DEX:STX SB0+12:TAY
                    LDX LOFRQ,Y:LDA HIFRQ,Y
                    JMP stf0TAY
fcs10               CLC
                    LDA SB0+31:BEQ fcs20
                    DEC SB0+31
                    TXA:ADC SB0+0:TAX
                    TYA:ADC SB0+1
                    JMP stf0TAY
fcs20               LDA SB0+32:BEQ fcs30
                    DEC SB0+32
                    TXA:ADC SB0+2:TAX
                    TYA:ADC SB0+3
                    JMP stf0TAY
fcs30               LDA SB0+33:BEQ fcs40
                    DEC SB0+33
                    TXA:ADC SB0+4:TAX
                    TYA:ADC SB0+5
                    JMP stf0TAY
fcs40               LDA SB0+34:BEQ fcrep0
                    DEC SB0+34
fcs40l1             TXA:ADC SB0+6:TAX
                    TYA:ADC SB0+7
stf0TAY             TAY
stf0                STX $D400:STY $D401
                    STX SB0+29:STY SB0+30
                    RTS
fcrep0              JSR trnsferf0
                    JMP fcs10
;
;
MUSIC1              LDA Z9:AND #2
                    BEQ jsound1
                    DEC ZB:BEQ read1
jsound1             JMP SOUND1
ad3c1               LDA #3
adc1                CLC:ADC Z2:STA Z2
                    BCC read1:INC Z3
read1               LDY #0:LDA (Z2),Y
                    CMP #192:BCC notctrl1
                    AND #63:TAX
                    LDA vt1,X:STA v1+1
                    LDA vt1+1,X:STA v1+2
                    INY:LDA (Z2),Y
                    TAX:STA Z6
                    INY:LDA (Z2),Y:STA Z7
v1                  JMP $FFFF
js1                 JMP st1
notctrl1            STA Z8:CMP #96
                    BCC idr1:SBC #96
idr1                CMP #Rest:BEQ js1
                    ADC DB1+73
gotnote1            TAX
NOTE1               LDY #4
n1sl2               LDA #0:STA $D409,Y
                    LDA DB1+22,Y
                    STA $D409,Y
                    DEY:BPL n1sl2
                    LDA DB1+24:STA SB1+26
dln1                LDY HIFRQ,X:LDA LOFRQ,X
                    STA SB1+29:STY SB1+30
                    STA $D407:STY $D408
dlp1                LDA DB1+17:STA SB1+17
                    BEQ dlf1:LDY #9
dlpl1               LDA DB1+14,Y
                    STA SB1+14,Y
                    DEY:BPL dlpl1
                    JSR trnsfrpl1
dlf1                LDX DB1+13:STX SB1+13
                    BEQ dld1:LDY #13
dlfl1               LDA DB1,Y:STA SB1,Y
                    DEY:BPL dlfl1
                    JSR trnsferf1
dld1                LDX DB1+27:LDY DB1+28
                    STX SB1+27:STY SB1+28
st1                 LDY #1:LDA (Z2),Y
                    LDX Z8:CPX #96
                    BCS ddr1
                    TAX:LDA DB1+32,X
ddr1                STA ZB:LDA #2
adn1                CLC:ADC Z2:STA Z2
                    BCC dia1:INC Z3
dia1                JMP SOUND1
;
MC1                 EQU .
retrut1             INC ZE:LDY ZE
                    CPY #8:BEQ rc1
r1a                 LDX DB1+49,Y
                    LDA DB1+57,Y
                    JMP goto1
rc1                 LDA Z9:AND #%11111101
                    STA Z9:RTS
;
for1                LDX ZE:CLC
                    TYA:ADC Z2
                    STA DB1+49,X
                    LDA Z3:ADC #0
                    STA DB1+57,X
                    LDA Z6:STA DB1+65,X
                    DEC ZE:TYA:JMP adc1
;
next1               LDX ZE
                    DEC DB1+66,X:BEQ n1a
                    INX:TXA:TAY:BPL r1a
n1a                 INC ZE:LDA #1:JMP adc1
;
wrvol1              LDY #4:LDX #28
tr1                 LDA (Z6),Y:STA DB1,X
                    DEX:DEY:BPL tr1
                    JMP ad3c1
freq1               LDY #13:LDX #13:BNE tr1
pulse1              LDY #09:LDX #23:BNE tr1
wrdat1              LDY #28:LDX #28:BNE tr1
;
goto1l              LDA Z7
goto1               STX Z2:STA Z3
                    JMP read1
;
call1               LDA #3
c1a                 LDY ZE:CLC:ADC Z2
                    STA DB1+49,Y
                    LDA Z3:ADC #0
                    STA DB1+57,Y
                    DEC ZE:JMP goto1l
;
callt1              INY:LDA (Z2),Y
                    STA DB1+73
                    LDA #4:BNE c1a
;
pokedb1             STA DB1,X:JMP ad3c1
;
pokesb1             STA SB1,X:JMP ad3c1
;
nosound1            RTS
SOUND1              LDX SB1+28:BEQ nosound1
;
VC1                 LDA SB1+26:AND #8
                    BEQ adsr1
                    LDA ZB:CMP SB1+27
                    BCS PL1
                    LDA #00:STA SB1+27
                    LDA SB1+26:AND #246
                    STA SB1+26:BNE trigrel1
adsr1               LDA SB1+27:BNE ad1
                    DEC SB1+28:BNE PL1
                    LDX #6
cc1                 STA $D407,X:DEX:BPL cc1
                    RTS
ad1                 DEC SB1+27:BNE PL1
                    LDA SB1+26:AND #246
trigrel1            STA $D40B
;
PL1                 LDA SB1+17:BEQ FC1
                    LDA SB1+16:BEQ plcdel1
                    DEC SB1+16:JMP FC1
plcdel1             CLC
                    LDX SB1+35:LDY SB1+36
plcs01              LDA SB1+37:BEQ plcs11
                    TXA:ADC SB1+18:TAX
                    TYA:ADC SB1+19:TAY
                    DEC SB1+37:JMP stpl1
plcs11              LDA SB1+38:BEQ plcrep1
                    TXA:ADC SB1+20:TAX
                    TYA:ADC SB1+21:TAY
                    DEC SB1+38:JMP stpl1
plcrep1             LDA SB1+17:AND #$81
                    BEQ stpl1:BPL nplcopy1
                    JSR trnsfrpl1
                    JMP plcdel1
nplcopy1            JSR trnsfrpl1+12
                    JMP plcdel1
stpl1               STX SB1+35:STY SB1+36
                    STX $D409:STY $D40A
;
FC1                 LDA SB1+13:BEQ exit1
                    LDX SB1+29:LDY SB1+30
                    CLC
                    LDA SB1+12:BEQ fcs11+1
                    DEC SB1+12
                    LDA SB1+13:AND #2
                    BNE fcs41l1
exit1               RTS
fcs11               CLC
                    LDA SB1+31:BEQ fcs21
                    DEC SB1+31
                    TXA:ADC SB1+0:TAX
                    TYA:ADC SB1+1
                    JMP stf1TAY
fcs21               LDA SB1+32:BEQ fcs31
                    DEC SB1+32
                    TXA:ADC SB1+2:TAX
                    TYA:ADC SB1+3
                    JMP stf1TAY
fcs31               LDA SB1+33:BEQ fcrep1
                    DEC SB1+33
                    TXA:ADC SB1+4:TAX
                    TYA:ADC SB1+5
                    JMP stf1TAY
fcs41l1             TXA:ADC SB1+6:TAX
                    TYA:ADC SB1+7
stf1TAY             TAY
stf1                STX $D407:STY $D408
                    STX SB1+29:STY SB1+30
rx                  RTS
fcrep1              JSR trnsferf1
                    JMP fcs11
;
MUSICTEST           LDA Z9
                    ORA SB0+28
                    ORA SB1+28
                    ORA SB2+28
                    RTS
;
REFRESH             JSR MUSIC0
                    JSR MUSIC1
                    JMP MUSIC2
;
MUSIC2              LDA Z9:AND #4
                    BEQ jsound2
                    DEC ZC:BEQ read2
jsound2             JMP SOUND2
ad3c2               LDA #3
adc2                CLC:ADC Z4:STA Z4
                    BCC read2:INC Z5
read2               LDY #0:LDA (Z4),Y
                    CMP #192:BCC notctrl2
                    AND #63:TAX
                    LDA vt2,X:STA v2+1
                    LDA vt2+1,X:STA v2+2
                    INY:LDA (Z4),Y
                    TAX:STA Z6
                    INY:LDA (Z4),Y:STA Z7
v2                  JMP $FFFF
js2                 JMP st2
notctrl2            STA Z8:CMP #96
                    BCC idr2:SBC #96
idr2                CMP #Rest:BEQ js2
                    ADC DB2+73
gotnote2            TAX
NOTE2               LDY #4
n2sl2               LDA #0:STA $D410,Y
                    LDA DB2+22,Y
                    STA $D410,Y
                    DEY:BPL n2sl2
                    LDA DB2+24:STA SB2+26
dln2                LDY HIFRQ,X:LDA LOFRQ,X
                    STA SB2+29:STY SB2+30
                    STA $D40E:STY $D40F
dlp2                LDA DB2+17:STA SB2+17
                    BEQ dlf2:LDY #9
dlpl2               LDA DB2+14,Y
                    STA SB2+14,Y
                    DEY:BPL dlpl2
                    JSR trnsfrpl2
dlf2                LDX DB2+13:STX SB2+13
                    BEQ dld2:LDY #13
dlfl2               LDA DB2,Y:STA SB2,Y
                    DEY:BPL dlfl2
                    TXA:AND #8:BEQ nolm2
                    LDA Z8:CLC
                    ADC DB2+73:STA SB2+10
                    STY SB2+12
nolm2               JSR trnsferf2
dld2                LDX DB2+27:LDY DB2+28
                    STX SB2+27:STY SB2+28
st2                 LDY #1:LDA (Z4),Y
                    LDX Z8:CPX #96
                    BCS ddr2
                    TAX:LDA DB2+32,X
ddr2                STA ZC:LDA #2
adn2                CLC:ADC Z4:STA Z4
                    BCC dia2:INC Z5
dia2                JMP SOUND2
;
MC2                 EQU .
retrut2             INC ZF:LDY ZF
                    CPY #8:BEQ rc2
r2a                 LDX DB2+49,Y
                    LDA DB2+57,Y
                    JMP goto2
rc2                 LDA Z9:AND #%11111011
                    STA Z9:RTS
;
for2                LDX ZF:CLC
                    TYA:ADC Z4
                    STA DB2+49,X
                    LDA #0:ADC Z5
                    STA DB2+57,X
                    LDA Z6:STA DB2+65,X
                    DEC ZF:TYA:JMP adc2
;
next2               LDX ZF
                    DEC DB2+66,X:BEQ n2a
                    INX:TXA:TAY:BPL r2a
n2a                 INC ZF:LDA #1:JMP adc2
;
wrvol2              LDY #4:LDX #28
tr2                 LDA (Z6),Y:STA DB2,X
                    DEX:DEY:BPL tr2
                    JMP ad3c2
wrdat2              LDY #28:LDX #28:BNE tr2
freq2               LDY #13:LDX #13:BNE tr2
chord2              LDY #09:LDX #09:BNE tr2
;
gotot2              INY:LDA (Z4),Y
                    STA DB2+73
;
goto2l              LDA Z7
goto2               STX Z4:STA Z5
                    JMP read2
;
call2               LDA #3
c2a                 LDY ZF:CLC:ADC Z4
                    STA DB2+49,Y
                    LDA Z5:ADC #0
                    STA DB2+57,Y
                    DEC ZF:JMP goto2l
;
callt2              INY:LDA (Z4),Y
                    STA DB2+73
                    LDA #4:BNE c2a
;
transp2             STX DB2+73
                    TYA:JMP adc2
;
pokedb2             STA DB2,X:JMP ad3c2
;
pokesb2             STA SB2,X:JMP ad3c2
;
nosound2            RTS
SOUND2              LDX SB2+28:BEQ nosound2
;
VC2                 LDA SB2+26:AND #8
                    BEQ adsr2
                    LDA ZC:CMP SB2+27
                    BCS PL2
                    LDA #00:STA SB2+27
                    LDA SB2+26:AND #246
                    STA SB2+26:BNE trigrel2
adsr2               LDA SB2+27:BNE ad2
                    DEC SB2+28:BNE PL2
                    LDX #6
cc2                 STA $D40E,X:DEX:BPL cc2
                    RTS
ad2                 DEC SB2+27:BNE PL2
                    LDA SB2+26:AND #246
trigrel2            STA $D412
;
PL2                 LDA SB2+17:BEQ FC2
                    LDA SB2+16:BEQ plcdel2
                    DEC SB2+16:JMP FC2
plcdel2             CLC
                    LDX SB2+35:LDY SB2+36
plcs02              LDA SB2+37:BEQ plcs12
                    TXA:ADC SB2+18:TAX
                    TYA:ADC SB2+19:TAY
                    DEC SB2+37:JMP stpl2
plcs12              LDA SB2+38:BEQ plcrep2
                    TXA:ADC SB2+20:TAX
                    TYA:ADC SB2+21:TAY
                    DEC SB2+38:JMP stpl2
plcrep2             LDA SB2+17:AND #$81
                    BEQ stpl2:BPL nplcopy2
                    JSR trnsfrpl2
                    JMP plcdel2
nplcopy2            JSR trnsfrpl2+12
                    JMP plcdel2
stpl2               STX SB2+35:STY SB2+36
                    STX $D410:STY $D411
;
FC2                 LDA SB2+13:BEQ exit2
                    AND #8:BNE olm2
                    LDX SB2+29:LDY SB2+30
                    CLC
                    LDA SB2+12:BEQ fcs12+1
                    DEC SB2+12
                    LDA SB2+13:AND #2
                    BNE fcs42l1
exit2               RTS
olm2                LDX SB2+12:BPL no2
                    LDX SB2+11
no2                 LDA SB2+10:CLC
                    ADC SB2,X
                    DEX:STX SB2+12:TAY
                    LDX LOFRQ,Y:LDA HIFRQ,Y
                    JMP stf2TAY
fcs12               CLC
                    LDA SB2+31:BEQ fcs22
                    DEC SB2+31
                    TXA:ADC SB2+0:TAX
                    TYA:ADC SB2+1
                    JMP stf2TAY
fcs22               LDA SB2+32:BEQ fcs32
                    DEC SB2+32
                    TXA:ADC SB2+2:TAX
                    TYA:ADC SB2+3
                    JMP stf2TAY
fcs32               LDA SB2+33:BEQ fcrep2
                    DEC SB2+33
                    TXA:ADC SB2+4:TAX
                    TYA:ADC SB2+5
                    JMP stf2TAY
fcs42l1             TXA:ADC SB2+6:TAX
                    TYA:ADC SB2+7
stf2TAY             TAY
stf2                STX $D40E:STY $D40F
                    STX SB2+29:STY SB2+30
                    RTS
fcrep2              JSR trnsferf2
                    JMP fcs12
;
;
CE                  EQU .
TS                  EQU .
;
DB0                 DFW -8,+8,-8,-72
                    DFB 3,6,3,0,30,5
                    DFB 20,20,0,5
                    DFW +20,-20,$800
                    DFB 65,$DD,$CC,130,255
                    DFW 0,0
                    DFB 4,8,12,16,20,24,28
                    DFB 32,36,40,44,48,52
                    DFB 56,60,64
                    DFS 25,0
DB1                 DFW +30,-30,+30,+151
                    DFB 3,6,3,0,50,7
                    DFB 30,30,0,5
                    DFW -30,+30,$B84
                    DFB 65,$88,$CC,150,200
                    DFW 0,0
                    DFB 4,8,12,16,20,24,28
                    DFB 32,36,40,44,48,52
                    DFB 56,60,64
                    DFS 25,0
DB2                 DFW +30,-30,+30,+99
                    DFB 3,6,3,0,50,7
                    DFB 30,30,0,5
                    DFW -30,+30,$B84
                    DFB 65,$88,$CC,150,200
                    DFW 0,0
                    DFB 4,8,12,16,20,24,28
                    DFB 32,36,40,44,48,52
                    DFB 56,60,64
                    DFS 25,0
SB0                 DFS 39,0
SB1                 DFS 39,0
SB2                 DFS 39,0
TDL                 DFW CH0D0,CH2D0,CH1D0
                    DFB 0,0,0,7,1,1,1,7,7,7
HIFRQ               DFB 1,1,1,1,1,1,1,1,1,1,1,2
                    DFB 2,2,2,2,2,2,3,3,3,3,3,4
                    DFB 4,4,4,5,5,5,6,6,6,7,7,8
                    DFB 8,9,9,10,10,11,12,12,13,14,15,16
                    DFB 17,18,19,20,21,22,24,25,27,28,30,32
                    DFB 34,36,38,40,43,45,48,51,54,57,61,64
                    DFB 68,72,76,81,86,91,96,102,108,115,122,129
                    DFB 137,145,153,163,172
LOFRQ               DFB 18,35,52,70,90,110,132,155,179,205,233,6
                    DFB 37,69,104,140,179,220,8,54,103,155,210,12
                    DFB 73,139,208,25,103,185,16,108,206,53,163,23
                    DFB 147,21,159,60,205,114,32,216,156,107,70,47
                    DFB 37,42,63,100,154,227,63,177,56,214,141,94
                    DFB 75,85,126,200,52,198,127,97,111,172,126,188
                    DFB 149,169,252,161,105,140,254,194,223,88,52,120
                    DFB 43,83,247,31,210
vt0                 DFW retrut0
                    DFW wrvol0
                    DFW 0,freq0
                    DFW pulse0
                    DFW call0
                    DFW transp0
                    DFW callt0,pokedb0
                    DFW 0,code0
                    DFW pokesb0,chord0
                    DFW for0,next0
vt2                 DFW retrut2
                    DFW wrvol2
                    DFW wrdat2,freq2
                    DFW 2
                    DFW call2
                    DFW transp2
                    DFW callt2,pokedb2
                    DFW gotot2,2
                    DFW pokesb2,chord2
                    DFW for2,next2
vt1                 DFW retrut1
                    DFW wrvol1
                    DFW wrdat1,freq1
                    DFW pulse1
                    DFW call1
                    DFW 1
                    DFW callt1,pokedb1
                    DFW 1,1
                    DFW pokesb1,1
                    DFW for1,next1
TE                  EQU .
DS                  EQU .
;
BLOCK2              DFW -8,0,0,0
                    DFB 255,0,0,0,10,5
                    DFS 8,0:DFW $800
                    DFB 33,0,$99,5,40
;
PULSE21             DFB 10,255,0,5
                    DFW +200,-20,$400
;
VOL21               DFB 33,0,$C9,5,50
VOL22               DFB 33,$33,$CB,5,150
VOL23               DFB 33,$BE,$CD,200,255
;
BLOCK0              DFW -8,+8,-8,-72
                    DFB 3,6,3,0,30,5
BLOCK0Va            DFB 65,1,$E7,4,12
;
VOL01               DFB 67,$EE,$0F,5,50
;
GUIT                DFW +30,-30,+30,0
                    DFB 3,6,3,0,22,5
GUITP               DFB 20,100,3,5
                    DFW +70,+25,100
GUITV               DFB 65,$83,$CB,90,100
;
UP00                DFW +30,-30,+30,+140
                    DFB 3,6,3,0,10,7
UP01                DFW +30,-30,+30,+16
                    DFB 3,6,3,0,20,7
BEND00              DFW 0,+109,0,-109
                    DFB 3,3,2,3,0,5
BEND01              DFW +30,-30,+30,-308
                    DFB 3,6,3,0,32,7
UPFULL              DFW 196,0,0,0
                    DFB 255,0,0,0,0,4
DOWN0               DFW -27,-1,-4,-3
                    DFB 100,150,100,255
                    DFB 25,5
DOWN1               DFW 0,-3,-3,-22
                    DFB 50,255,255,0,125,5
;
FREQ01              DFW +85,0,-85,0
                    DFB 10,28,10,0,0,5
FREQ2               DFW +8,-8,+8,0
                    DFB 3,6,3,0,10,5
;
PAUL                DFW +20,-20,+20,0
                    DFB 3,6,3,0,15,5
                    DFB 25,25,30,5
PAULP               DFW +10,-10,$800
PAULV               DFB 65,$CC,$9D,150,200
;
TRIP11              DFB 0,4,7,12,0,4,7,12
                    DFB 0,0;RMajor
TRIP13              DFB 0,3,8,12,0,3,8,12
                    DFB 0,0;1Major
TRIP10a             DFB 0,5,9,12,0,5,9,12
                    DFB 0,0,0,8,0,13;2Major
TRIP12              DFB 0,2,7,12,0,2,7,12
                    DFB 0,0;1Susp4
TRIP14              DFB 0,3,7,12,0,3,7,12
                    DFB 0,0;RMinor
TRIP19              DFB 0,5,8,12,0,5,8,12
                    DFB 0,0;2Minor
TRIP17              DFB 0,3,6,8,0,3,6,8,0,0
; 1Seventh
TRIP18              DFB 0,4,8,12,0,4,8,12
                    DFB 0,0;1Maj+
;
S01a                DFB loop,8,0,1,Next
                    DFB loop,4,0,2,Next,Ret
S01z                DFB CT:DFW S01:DFB 55
                    DFB Call:DFW S01
                    DFB Transp,53
S01                 DFB Call:DFW S01a
S01b                DFB 0,3,0,3,0,2,0,2,0,2
                    DFB 0,4,Ret
;
S02                 DFB Chord:DFW TRIP10a
                    DFB CT:DFW S13:DFB 41
                    DFB Chord:DFW TRIP11
                    DFB 0,16,Rest,16
                    DFB Chord:DFW TRIP12
                    DFB CT:DFW S13:DFB 41
                    DFB Chord:DFW TRIP13
                    DFW Transp
                    DFB 40,16,Rest,16,Ret
;
CH0D0               DFB Rest+96,50
                    DFB Code:DFW STARTMC
                    DFB loop,3,Rest+96,0
                    DFB Next
                    DFB Code:DFW MCFC1
                    DFB Rest+96,0
                    DFB Rest+96,0
                    DFB Code:DFW MCFC2
                    DFB Rest+96,0
                    DFB 55+96,168
                    DFB DPoke,25,$38
                    DFB SPoke,29,$B1
                    DFB SPoke,30,$19
                    DFB SPoke,12,10
                    DFB SPoke,13,7
                    DFB Rest,2,53,4
                    DFB Freq:DFW FREQ01
                    DFB 56,12
                    DFB Freq:DFW BLOCK0
                    DFB 56,4,55,12,51,4
                    DFB 48+96,152
                    DFB loop,2,43,2,46,2
                    DFB Next,43,2
                    DFB DPoke,27,50
                    DFB 48+96,128
                    DFB DPoke,0,256-80
                    DFB DPoke,8,255
                    DFB DPoke,12,0
                    DFB DPoke,26,$A9
                    DFB DPoke,27,10
                    DFB 50,1,50,1,50,1,50,1
                    DFB 50,2,44,2,42,2
                    DFB 44,4,44,2,44,2
                    DFB 42,4
                    DFB Freq:DFW UPFULL
                    DFB Pulse:DFW GUITP
                    DFB Volume:DFW GUITV
                    DFB 0,10
                    DFB Freq:DFW GUIT
                    DFB 58+96,128,57+96,128
                    DFB 55+96,192,55,8,57,8
                    DFB 58+96,128,57+96,80
                    DFB Freq:DFW UP00
                    DFB 57,10
                    DFB Freq:DFW GUIT
                    DFB 58,1,57,1,55+96,96
                    DFB Freq:DFW UP01
                    DFB 52,8
                    DFB Freq:DFW BEND00
                    DFB 52+96,80
                    DFB Freq:DFW GUIT
                    DFB 55,6,57,6,58+96,128
                    DFB 60+96,80,62,4,64,4
                    DFB 65,4,64+96,80,65,4
                    DFB 64,2,65,1,64,1,62,4
                    DFB 60+96,96,55,4,57,4
                    DFB 58+96,128,65+96,128
                    DFB DPoke,27,200
                    DFB 67+96,224
                    DFB Freq:DFW BEND01
                    DFB 67,8
                    DFB DPoke,13,0
                    DFB Rest+96,0
                    DFB Rest+96,0
                    DFB Volume:DFW VOL01
                    DFB DPoke,17,0
                    DFB DPoke,23,8
                    DFB Transp,24
                    DFB loop,64
                    DFB Code:DFW YNCREMENT
                    DFB 0,2,Next
                    DFB Volume:DFW BLOCK0Va
                    DFB Call:DFW S01z
                    DFB CT:DFW S01:DFB 54
                    DFB Call:DFW S01z
                    DFB CT:DFW S01a:DFB 55
                    DFB CT:DFW S01b:DFB 54
                    DFB DPoke,24,65
                    DFB Freq:DFW TRIP10a
                    DFB Call:DFW S02
                    DFB Call:DFW S02
                    DFB Volume:DFW BLOCK0Va
                    DFB DPoke,13,0,loop,4
                    DFB loop,3
                    DFB CT:DFW S01:DFB 41
                    DFB Next
                    DFB CT:DFW S01:DFB 40
                    DFB Next
                    DFB Volume:DFW PAULV
                    DFB DPoke,24,21
                    DFB Pulse:DFW PAULP
                    DFB Freq:DFW DOWN0
                    DFB Rest+96,0
                    DFW Transp
                    DFB Rest+96,0
                    DFB 50+96,125
                    DFB SPoke,29,$B3
                    DFB SPoke,30,$08
                    DFB Rest+96,200
                    DFB SPoke,28,255
                    DFB Rest+96,200
                    DFB SPoke,28,100
                    DFB Ret
;
YNCREMENT           INC DB0+73:RTS
MCFC1               LDX #$38:LDY #$1B
                    BNE MCFCa
MCFC2               LDX #$B1:LDY #$19
MCFCa               STX $D400:STY $D401
                    RTS
;
S11z                DFB Call:DFW S11
S11                 DFB 0,6,0,4,0,4,0,6
                    DFB 0,4,12,2,0,2,12,2
                    DFB 12,2,Ret
;
S13                 DFB Call:DFW S13a
                    DFB 0,2,0,4,0,2,0,2,0,2
                    DFB 0,1,0,1,0,1,0,1
                    DFB Ret
S13a                DFB 0,2,0,2,0,2,0,1,0,1
                    DFB 0,2,0,2,0,1,0,1,0,2
                    DFB Ret
;
S14                 DFB Freq:DFW TRIP10a
                    DFB loop,4
                    DFB Call:DFW S14a
                    DFB Next,Ret
S14z                DFB Call:DFW S14a
S14a                DFB Chord:DFW TRIP10a
                    DFB CT:DFW S13:DFB 41
                    DFB Chord:DFW TRIP11
                    DFB Call:DFW S13
                    DFB Chord:DFW TRIP12
                    DFB Call:DFW S13
                    DFB Chord:DFW TRIP13
                    DFB JT:DFW S13:DFB 40
;
S17a                DFB 0,1,0,1,0,4,0,4,0,4
                    DFB 0,1,0,1,Ret
S17z                DFB Call:DFW S17
S17                 DFB Call:DFW S17a
S17b                DFB 0,2,0,2
                    DFB 0,2,0,2,0,4,0,1,0,1
                    DFB 0,1,0,1,Ret
;
CH1D0               DFB 0+96,50
                    DFB Rest+96,0
                    DFB WrDat:DFW BLOCK2
                    DFB Rest+96,0
                    DFB loop,2
                    DFB CT:DFW S11z:DFB 36
                    DFB CT:DFW S11z:DFB 32
                    DFB CT:DFW S11z:DFB 29
                    DFB Next
                    DFB CT:DFW S11z:DFB 36
                    DFB Call:DFW S14
                    DFB Chord:DFW TRIP14
                    DFB CT:DFW S17:DFB 55
                    DFB Chord:DFW TRIP13
                    DFB Call:DFW S17
                    DFB Chord:DFW TRIP10a
                    DFB CT:DFW S17:DFB 53
                    DFB Chord:DFW TRIP13
                    DFB CT:DFW S17:DFB 54
                    DFB Chord:DFW TRIP14
                    DFB CT:DFW S17:DFB 55
                    DFB Chord:DFW TRIP13
                    DFB Call:DFW S17
                    DFB Chord:DFW TRIP10a
                    DFB CT:DFW S17:DFB 53
                    DFB Chord:DFW TRIP17
                    DFB CT:DFW S17:DFB 54
                    DFB Chord:DFW TRIP14
                    DFB CT:DFW S17:DFB 55
                    DFB Chord:DFW TRIP13
                    DFB Call:DFW S17
                    DFB Chord:DFW TRIP10a
                    DFB CT:DFW S17:DFB 53
                    DFB Chord:DFW TRIP18
                    DFB CT:DFW S17a:DFB 54
                    DFB Chord:DFW TRIP17
                    DFB Call:DFW S17b
                    DFB Chord:DFW TRIP14
                    DFB CT:DFW S17:DFB 55
                    DFB Chord:DFW TRIP13
                    DFB Call:DFW S17
                    DFB Chord:DFW TRIP10a
                    DFB CT:DFW S17:DFB 53
                    DFB Chord:DFW TRIP19
                    DFB CT:DFW S17a:DFB 55
                    DFB Chord:DFW TRIP13
                    DFB CT:DFW S17b:DFB 54
                    DFB Call:DFW S14z
                    DFB WrDat:DFW PAUL
                    DFB Rest+96,0
                    DFB Rest+96,0
                    DFW Transp
                    DFB 50+96,128
                    DFB 48+96,128
                    DFB 48+96,0
                    DFB 50+96,128
                    DFB 48+96,80
                    DFB DPoke,16,0
                    DFB 46,4,45,4,46,4
                    DFB 48+96,80
                    DFB 43,4,48,4,50,4
                    DFB 52,12,53,4
                    DFB 55,4,57,4,58,4,60,4
                    DFB 58+96,128
                    DFB 57+96,128
                    DFB 55+96,0
                    DFB 50+96,128
                    DFB 48+96,128
                    DFB 48+96,128
                    DFB 50+96,128
                    DFB Freq:DFW DOWN1
                    DFB 48+96,25
                    DFB SPoke,13,7
                    DFB Rest+96,100
                    DFB SPoke,29,$93
                    DFB SPoke,30,8
                    DFB Rest+96,200
                    DFB SPoke,28,255
                    DFB Rest+96,200
                    DFB SPoke,28,255
                    DFB Ret
;
S21                 DFB 5,4,5,2,5,2
                    DFB 5,2,5,4,5,4
                    DFB 0,2,3,2,5,2,8,2,7,2
                    DFB 5,2,3,2
                    DFB Ret
;
S22z                DFB Call:DFW S22
S22                 DFB Call:DFW S22a
S22b                DFB 0,4,0,1,0,1,0,2,0,2
                    DFB 12,2,0,2,0,2,0,2
                    DFB Ret
S22a                DFB 0,1,0,1,0,2,0,2
                    DFB 0,2,12,2,0,4
                    DFB Ret
;
S23z                DFB Call:DFW S23
S23                 DFB CT:DFW S22:DFB 34
                    DFB CT:DFW S22:DFB 29
                    DFB CT:DFW S22z:DFB 36
                    DFB Ret
;
S24                 DFB loop,4,5,4,0,4
                    DFB Next,Ret
S25                 DFB loop,4,0,8,Next,Ret
;
S26                 DFB CT:DFW S22:DFB 31
                    DFB CT:DFW S22:DFB 39
                    DFB CT:DFW S22:DFB 34
                    DFB Ret
;
CH2D0               DFB 0+96,50
                    DFB WrDat:DFW BLOCK2
                    DFB Rest+96,0
                    DFB loop,14
                    DFB CT:DFW S21:DFB 31
                    DFB Next
                    DFB Volume:DFW VOL21
                    DFB Call:DFW S21
                    DFB Pulse:DFW PULSE21
                    DFB DPoke,24,65
                    DFB 05,2,17,1,17,1,17,2
                    DFB 17,2,17,2,05,6,17,4
                    DFB 05,4,17,2,05,2,04,4
                    DFB DPoke,13,0
                    DFB Call:DFW S23z
                    DFB Call:DFW S23z
                    DFB CT:DFW S22z:DFB 31
                    DFB CT:DFW S22:DFB 29
                    DFB CT:DFW S22:DFB 30
                    DFB CT:DFW S22z:DFB 31
                    DFB CT:DFW S22:DFB 34
                    DFB CT:DFW S22:DFB 38
                    DFB Call:DFW S26
                    DFB CT:DFW S22a:DFB 38
                    DFB CT:DFW S22b:DFB 30
                    DFB Call:DFW S26
                    DFB CT:DFW S22a:DFB 36
                    DFB CT:DFW S22b:DFB 38
                    DFB Call:DFW S23z
                    DFB loop,3
                    DFB CT:DFW S24:DFB 34-5
                    DFB CT:DFW S24:DFB 29-5
                    DFB CT:DFW S24:DFB 36-5
                    DFB Call:DFW S24
                    DFB Next
                    DFB Volume:DFW VOL22
                    DFB Freq:DFW FREQ2
                    DFB DPoke,17,0
                    DFB CT:DFW S25:DFB 34
                    DFB CT:DFW S25:DFB 29
                    DFB CT:DFW S25:DFB 36
                    DFB CT:DFW S25:DFB 24
                    DFB CT:DFW S25:DFB 34
                    DFB CT:DFW S25:DFB 29
                    DFB CT:DFW S25:DFB 32
                    DFB CT:DFW S25:DFB 34
                    DFB Volume:DFW VOL23
                    DFB 2+96,0,SPoke,28,255
                    DFB Rest+96,254
                    DFB SPoke,28,255,Ret
;
MWK                 EQU DB0+65
STOPSTART           LDA #0
                    STA SB0+28:STA SB1+28
                    STA SB2+28:LDX #$17
resl                STA $D400,X
                    DEX:BPL resl
                    LDX #15
gttd                LDA TDL,X:STA Z0,X
                    DEX:BPL gttd
x5                  LDX #REFRESH
                    LDY ^REFRESH
                    STX MUS+1
                    STY MUS+2
                    RTS
MCREFR              LDA #0:BEQ READ
READ                LDY MWK+0:LDA Secret,Y
                    BEQ x5:INC MWK+0
                    LSRA:TAX
                    LDA CodeTab-"A",X
                    STA MWK+1
                    AND #3:STA MWK+2
                    LDX #SH-READ:BNE x
SH                  ASLMWK+1:BCC sDIT
                    LDA #6:LDX #DAH-READ
xF                  LDY #33:BNE x4
sDIT                LDA #2:LDX #DIT-READ
                    BNE xF
SPC                 DEC MWK+3:BPL x1
                    DEC MWK+2
                    BPL SH:LDA #6:STA MWK+3
                    LDX #GAP-READ:BNE x
GAP                 DEC MWK+3:BPL x1
                    BMI READ
DAH                 DEC MWK+3:BPL x1
                    BMI sSPC
DIT                 DEC MWK+3:BPL x1
sSPC                LDA #2:LDX #SPC-READ
                    LDY #32
x4                  STA MWK+3:BNE x2
STARTMC             LDA #$A0:STA $D406
                    LDX #$4B:STX $D400
                    LDY #$22:STY $D401
                    LDX #MCREFR
                    LDY ^MCREFR
                    STX MUS+1
                    STY MUS+2
                    LDA #0:TAX:TAY
                    STA MWK+0:STA $D405
                    STA SB0+28
x2                  STY $D404
x                   STX MCREFR+3
x1                  JMP REFRESH
;
Secret              DFB 2*"B",2*"I",2*"L",2*"L"
                    DFB 2*"B",2*"A",2*"R",2*"N"
                    DFB 2*"A"
                    DFB 2*"D",2*"A",2*"V",2*"I"
                    DFB 2*"D",2*"C",2*"O",2*"L"
                    DFB 2*"L",2*"I",2*"E",2*"R"
                    DFB 2*"M",2*"A",2*"R",2*"T"
                    DFB 2*"I",2*"N",2*"G",2*"A"
                    DFB 2*"L",2*"W",2*"A",2*"Y"
                    DFB 2*"T",2*"O",2*"N",2*"Y"
                    DFB 2*"P",2*"O",2*"M",2*"F"
                    DFB 2*"R",2*"E",2*"T"
                    DFB 2*"S",2*"T",2*"E",2*"V"
                    DFB 2*"E",2*"W",2*"A",2*"H"
                    DFB 2*"I",2*"D"
                    DFB 0
;
CodeTab             DFW $8341,$82A3,$2300
                    DFW $03C2,$7310,$43A2
                    DFW $81C1,$63E2,$42D3
                    DFW $8002,$1322,$9362
                    DFW $C3B3
;
DE
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The End! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^