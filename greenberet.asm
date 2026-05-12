 ;Konami/Imagine's "Green Beret" ( Commodore 64/128 Version )
 ;
 ;Sound.Effects and Music Source File
 ;
 ;Composition by Galway & Konami
 ;Arrangement, design & coding by Galway
 ;
 ;*****(C) OCEAN SOFTWARE LTD***** 5th April 1986.
 ;
;GAP            EQU $9AAD-.
MOBJlengt      EQU DE-XE000
HOWFAR2GO      EQU $1FF0-MOBJlengt
ALLOWANCE      EQU 30 ;scan lines
BDR            EQU $D020
 ;
 ;ZeroPage
 ;
A0             EQU $0016 ;\
A1             EQU A0+02
A2             EQU A0+04
CLOK0          EQU A0+06
CLOK1          EQU A0+07
CLOK2          EQU A0+08
SP0            EQU A0+09
SP1            EQU A0+10
SP2            EQU A0+11
TR0            EQU A0+12
TR1            EQU A0+13
TR2            EQU A0+14
MFL0           EQU A0+15
MFL1           EQU A0+16
MFL2           EQU A0+17
SFL0           EQU A0+18
SFL1           EQU A0+19
SFL2           EQU A0+20
RF             EQU A0+21
Z8             EQU A0+22
IND            EQU A0+23
SZ             EQU A0+25
ZPSIZE         EQU IND-A0
 ;
 ;Instruction codes
 ;
COM            EQU $C0
Sil            EQU $5E
Rst            EQU $5F
R              EQU $60
 ;
Ret            EQU $C0
Call           EQU $C2
Jmp            EQU $C4
CT             EQU $C6
JT             EQU $C8
Moke           EQU $CA
For            EQU $CC
Next           EQU $CE
 ;
Load           EQU $D0
Chrd           EQU $D2
Frq            EQU $D4
Vlm            EQU $D6
Soke           EQU $D8
Code           EQU $DA
Tsp            EQU $DC
 ;
 ;Datablock Variables
 ;
FMG0           EQU 0
FMG1           EQU 2
FMG2           EQU 4
FMG3           EQU 6
FMD0           EQU 8
FMD1           EQU 9
FMD2           EQU 10
FMD3           EQU 11
FMDLY          EQU 12
FMC            EQU 13
 ;
PMD0           EQU 14
PMD1           EQU 15
PMDLY          EQU 16
PMC            EQU 17
PMG0           EQU 18
PMG1           EQU 20
PINIT          EQU 22
 ;
VWF            EQU 24
VADV           EQU 25
VSRV           EQU 26
VADSD          EQU 27
VRD            EQU 28
 ;
 ;Soundblock Variables
 ;
FBG            EQU 6
CFMD0          EQU 8
CFMD1          EQU 9
CFMD2          EQU 10
FOLB           EQU 10
CFMD3          EQU 11
FOLII          EQU 11
FBD            EQU 12
FMDLYC         EQU 12
FOLCI          EQU 12
CPMD0          EQU 14
CPMD1          EQU 15
PMDLYC         EQU 16
FINIT          EQU 24
VWFG           EQU 26
VADSC          EQU 27
VRC            EQU 28
FCURR          EQU 29
FMD0C          EQU 31
FMD1C          EQU 32
FMD2C          EQU 33
FMD3C          EQU 34
PCURR          EQU 35
PMD0C          EQU 37
PMD1C          EQU 38
 ;
 ;================================
 ;
X3E00          EQU .
               ORG $3E00 ;\
			   ENT
 ;
               JMP title
               JMP gametune1
               JMP gametune3
               JMP challenge
               JMP highscore
               JMP gameover
               JMP missionac
               JMP lostalife
               JMP gamestart
               JMP truckoff
               JMP FULLRESET
               JMP MUSICTEST
               JMP autogyron
               JMP dogbarkin
               JMP flamethro
               JMP truckon
               JMP comlevel1
               JMP comlevel2
               JMP comlevel3
               JMP jet
               JMP kill
               JMP gun
               JMP explosion
               JMP SOUND0
               JMP SOUND1
               JMP SOUND2
               JMP MUSIC0
               JMP MUSIC1
               JMP MUSIC2
               JMP TUNE
 ;
flamethro      LDA #FLAME1
               LDY ^FLAME1
               LDX #1
               JSR EFFECT
               LDA #FLAME2
               LDY ^FLAME2
               LDX #2
               JMP EFFECT
dogbarkin      LDY CDOG
               LDX LFC,Y 
               STX CDOG
               LDA #DOG0
               LDY ^DOG0
               JMP EFFECT
CDOG           DFB 0
truckoff       LDA #0
               STA MFL0
               RTS 
jet            LDA #JET1
               LDY ^JET1
               LDX #1
               JSR EFFECT
               LDA #JET0
               LDY ^JET0
               JMP EFFECT0
kill           LDA #KILL0
               LDY ^KILL0
               JMP EFFECT0
gun            LDA #GUN1
               LDY ^GUN1
               LDX #1
               JSR EFFECT
               LDA #GUN0
               LDY ^GUN0
               JMP EFFECT0
explosion      LDA #EXPL0
               LDY ^EXPL0
               JSR EFFECT0
               LDA #EXPL1
               LDY ^EXPL1
               LDX #1
               JSR EFFECT
               LDA #EXPL2
               LDY ^EXPL2
               LDX #2
               JMP EFFECT
 ;
autogyron      LDY #13*6+5
               DFB $2C
truckon        LDY #12*6+5
               DFB $2C
challenge      LDY #11*6+5
               DFB $2C
gametune3      LDY #01*6+5
               DFB $2C
gamestart      LDY #00*6+5
               DFB $2C
gametune1      LDY #10*6+5
               DFB $2C
missionac      LDY #02*6+5
               DFB $2C
comlevel1      LDY #03*6+5
               DFB $2C
comlevel2      LDY #04*6+5
               DFB $2C
gameover       LDY #05*6+5
               DFB $2C
lostalife      LDY #06*6+5
               DFB $2C
highscore      LDY #07*6+5
               DFB $2C
title          LDY #08*6+5
               DFB $2C
comlevel3      LDY #09*6+5
 ;
TUNE           LDX #5
gettd          LDA TUNETAB,Y 
               STA A0,X 
               DEY 
               DEX 
               BPL gettd
               LDX #2
ttrans         LDY DTAB,X 
               LDA #0
               STA TR0,X 
               STA D0+FMC,Y 
               STA D0+PMC,Y 
               STA D0+PINIT,Y 
               LDA #1
               STA CLOK0,X 
               STA MFL0,X 
               STA SFL0,X 
               LDA #7
               STA SP0,X 
               LDA #8
               STA D0+PINIT+1,Y 
               DEX 
               BPL ttrans
               RTS 
 ;
TUNETAB        EQU .
               DFW STRT0,STRT1,STRT2
               DFW GAM30,EXIT,GAM32
               DFW ACCO0,ACCO1,ACCO2
               DFW COL10,COL11,COL12
               DFW COL20,COL21,COL22
               DFW OVER0,OVER1,OVER2
               DFW LIFE0,LIFE1,LIFE2
               DFW HIGH0,HIGH1,HIGH2
               DFW TITL0,TITL1,TITL2
               DFW COL30,COL31,COL32
               DFW GAM10,EXIT,GAM12
               DFW CHAL0,EXIT,CHAL2
               DFW TRUK0,EXIT,EXIT
               DFW AUTO0,EXIT,EXIT
 ;
MUSICTEST      LDA MFL0
               ORA MFL1
               ORA MFL2
               ORA S0+VRC
               ORA S1+VRC
               ORA S2+VRC
               RTS 
 ;
SOFTRESET      LDX #0
               STX MFL0
               STX MFL1
               STX MFL2
               STX S0+VRC
               STX S1+VRC
               STX S2+VRC
               DEX 
               STX SFL0
               STX SFL1
               STX SFL2
               RTS 
 ;
FULLRESET      JSR SOFTRESET
HARDRESET      LDX #$14
RL             LDA #8
               STA $D400,X 
               LDA #0
               STA $D400,X 
               DEX 
               BPL RL
               RTS 
 ;
refvol         LDA CHP+0
               STA $D415
               LDA CHP+1
               STA $D416
               LDA CHP+2
               STA $D417
               RTS 
ENDPROT        EQU .
 ;
               ORG $5000 ;\
 ;
XE000          EQU .
 ;
trnsfrpm0      LDX S0+PINIT
               LDY S0+PINIT+1
               STX S0+PCURR
               STY S0+PCURR+1
               LDA S0+CPMD0
               STA S0+PMD0C
               LDA S0+CPMD1
               STA S0+PMD1C
               RTS 
 ;
trnsfrpm1      LDX S1+PINIT
               LDY S1+PINIT+1
               STX S1+PCURR
               STY S1+PCURR+1
               LDA S1+CPMD0
               STA S1+PMD0C
               LDA S1+CPMD1
               STA S1+PMD1C
               RTS 
 ;
trnsfrpm2      LDX S2+PINIT
               LDY S2+PINIT+1
               STX S2+PCURR
               STY S2+PCURR+1
               LDA S2+CPMD0
               STA S2+PMD0C
               LDA S2+CPMD1
               STA S2+PMD1C
               RTS 
 ;
EFFECT0        LDX #0
EFFECT         STA IND
               STY IND+1
               STX Z8
               LDA #0
               STA SFL0,X 
               LDA CHTAB,X 
               STA el2+3
               LDY #26
               LDX #4
el2            LDA (IND),Y 
               STA $D4FF,X 
               DEY 
               DEX 
               BPL el2
               LDY #29
               LDX el2+3
               LDA (IND),Y 
               STA $D3FE,X 
               INY 
               LDA (IND),Y 
               STA $D3FF,X 
               LDY Z8
               LDX SBTAB,Y 
               LDY #27
               LDA (IND),Y 
               STA S0+4,X 
               INY 
               LDA (IND),Y 
               STA S0+5,X 
               LDY #24
               LDA (IND),Y 
               STA S0+3,X 
               LDY #30
               LDA (IND),Y 
               STA S0+2,X 
               DEY 
               LDA (IND),Y 
               STA S0+1,X 
               LDY #23
el3            LDA (IND),Y 
               STA S0,X 
               DEX 
               DEY 
               BPL el3
               INX 
               BNE ch1or2
 ;
               LDA S0+PMC
               BEQ trnsferf0
               JSR trnsfrpm0
               LDA S0+FMC
               BEQ ex0
trnsferf0      LDX S0+FINIT
               LDY S0+FINIT+1
               STX S0+FCURR
               STY S0+FCURR+1
               LDA S0+CFMD3
               STA S0+FMD3C
               LDA S0+CFMD2
               STA S0+FMD2C
               LDA S0+CFMD1
               STA S0+FMD1C
               LDA S0+CFMD0
               STA S0+FMD0C
ex0            RTS 
ch1or2         CPX #$4E
               BEQ ch2
 ;
               LDA S1+PMC
               BEQ lll1
               JSR trnsfrpm1
lll1           LDA S1+FMC
               BEQ ex1
trnsferf1      LDX S1+FINIT
               LDY S1+FINIT+1
               STX S1+FCURR
               STY S1+FCURR+1
               LDA S1+CFMD3
               STA S1+FMD3C
               LDA S1+CFMD2
               STA S1+FMD2C
               LDA S1+CFMD1
               STA S1+FMD1C
               LDA S1+CFMD0
               STA S1+FMD0C
ex1            RTS 
 ;
ch2            LDA S2+PMC
               BEQ lll2
               JSR trnsfrpm2
lll2           LDA S2+FMC
               BEQ ex2
trnsferf2      LDX S2+FINIT
               LDY S2+FINIT+1
               STX S2+FCURR
               STY S2+FCURR+1
               LDA S2+CFMD3
               STA S2+FMD3C
               LDA S2+CFMD2
               STA S2+FMD2C
               LDA S2+CFMD1
               STA S2+FMD1C
               LDA S2+CFMD0
               STA S2+FMD0C
ex2            RTS 
 ;
MUSIC0         LDA MFL0
               BEQ ex2
               DEC CLOK0
               BEQ read0
               RTS 
ad3c0          LDA #3
adc0           CLC 
               ADC A0
               STA A0
               BCC read0
               INC A0+1
read0          LDY #0
               LDA (A0),Y 
               CMP #192
               BCC notctrl0
               TAX 
               LDA vt0-192,X 
               STA v0+1
               LDA vt0-191,X 
               STA v0+2
v0             JMP $FFFF
js0            JMP st0
notctrl0       STA Z8
               CMP #96
               BCC idr0
               SBC #96
idr0           CMP #Rst
               BEQ js0
 ; CMP #Sil:BEQ gotnote0;@
               ADC TR0
gotnote0       TAX 
               LDA RF
               AND #1
               BEQ js0 ;\
NOTE0          LDA SFL0
               BEQ js0
               LDA D0+VSRV
               STA $D406
               LDA D0+VADV
               STA $D405
 ; LDA D0+VWF:STA S0+VWFG:ORA #8:STA $D404:AND #247:STA $D404
               LDA #8
               STA $D404
               LDA D0+VWF
               STA S0+VWFG
               AND #247
               STA $D404
               LDA D0+PINIT+1
               STA $D403
               LDA D0+PINIT
               STA $D402
               LDY HIFRQ,X 
               LDA LOFRQ,X 
               STA S0+FINIT
               STY S0+FINIT+1
               STA $D400
               STY $D401
               LDA D0+PMC
               STA S0+PMC
               BEQ dlf0
               LDY D0+PINIT+1
               STY S0+PINIT+1
               LDX D0+PINIT
               STX D0+PINIT
               STX S0+PCURR
               STY S0+PCURR+1
               LDA D0+PMG1+1
               STA S0+PMG1+1
               LDA D0+PMG1
               STA S0+PMG1
               LDA D0+PMG0+1
               STA S0+PMG0+1
               LDA D0+PMG0
               STA S0+PMG0
               LDA D0+PMDLY
               STA S0+PMDLYC
               LDY D0+PMD1
               STY S0+CPMD1
               LDX D0+PMD0
               STX S0+CPMD0
               STX S0+PMD0C
               STY S0+PMD1C
dlf0           LDX D0+FMC
               STX S0+FMC
               BEQ dld0
               LDY #12
dlfl0          LDA D0,Y 
               STA S0,Y 
               DEY 
               BPL dlfl0
               TXA 
               AND #8
               BEQ nolm0
               LDA Z8
               CMP #96
               BCC idr0a
               SBC #96
               CLC 
idr0a          ADC TR0
               STA S0+FOLB
               BNE dld0
nolm0          JSR trnsferf0
dld0           LDX D0+VADSD
               LDY D0+VRD
               STX S0+VADSC
               STY S0+VRC
st0            LDY #1
               LDA (A0),Y 
               LDX Z8
               CPX #96
               BCS ddr0
               TAX 
               LDA IDR-1,X 
ddr0           STA CLOK0
               LDA #2
adn0           CLC 
               ADC A0
               STA A0
               BCC dia0
               INC A0+1
dia0           RTS 
 ;
MC0            EQU .
retrut0        INC SP0
               LDY SP0
               CPY #8
               BEQ rc0
               LDX ST0L,Y 
               LDA ST0H,Y 
               STX A0
               STA A0+1
               JMP read0
rc0            DEC MFL0
               RTS 
for0           LDX SP0
               CLC 
               LDA #2
               ADC A0
               STA ST0L,X 
               LDA #0
               ADC A0+1
               STA ST0H,X 
               INY 
               LDA (A0),Y 
               STA ST0C,X 
               DEC SP0
               LDA #2
               JMP adc0
next0          LDX SP0
               DEC ST0C+1,X 
               BEQ n0a
               LDY ST0L+1,X 
               LDA ST0H+1,X 
               STY A0
               STA A0+1
               JMP read0
n0a            INC SP0
               LDA #1
               JMP adc0
volume0        INY 
               LDA (A0),Y 
               STA IND
               INY 
               LDA (A0),Y 
               STA IND+1
               LDY #4
tr0            LDA (IND),Y 
               STA D0+VWF,Y 
               DEY 
               BPL tr0
               JMP ad3c0
freq0          INY 
               LDA (A0),Y 
               STA IND
               INY 
               LDA (A0),Y 
               STA IND+1
               LDY #13
fr0a           LDA (IND),Y 
               STA D0,Y 
               DEY 
               LDA (IND),Y 
               STA D0,Y 
               DEY 
               BPL fr0a
               JMP ad3c0
chord0         INY 
               LDA (A0),Y 
               STA IND
               INY 
               LDA (A0),Y 
               STA IND+1
               LDY #9
tr0a           LDA (IND),Y 
               STA D0,Y 
               DEY 
               LDA (IND),Y 
               STA D0,Y 
               DEY 
               BPL tr0a
               JMP ad3c0
load0          INY 
               LDA (A0),Y 
               TAX 
               INY 
               LDA (A0),Y 
               STA Z8
               INY 
               LDA (A0),Y 
               STA IND
               INY 
               LDA (A0),Y 
               STA IND+1
               LDY Z8
load0l         LDA (IND),Y 
               STA D0,X 
               DEX 
               DEY 
               BPL load0l
               LDA #5
               JMP adc0
gotot0         INY 
               LDA (A0),Y 
               STA TR0
               INY 
               LDA (A0),Y 
               TAX 
               INY 
               LDA (A0),Y 
               STX A0
               STA A0+1
               JMP read0
goto0          INY 
               LDA (A0),Y 
               TAX 
               INY 
               LDA (A0),Y 
               STX A0
               STA A0+1
               JMP read0
code0          LDA ^ad3c0-1
               PHA 
               LDA #ad3c0-1
               PHA 
               INY 
               LDA (A0),Y 
               STA codev0+1
               INY 
               LDA (A0),Y 
               STA codev0+2
codev0         JMP $FFFF
callt0         LDY #1
               LDX #2
               LDA (A0),Y 
               STA TR0
               LDA #4
c0a            LDY SP0
               CLC 
               ADC A0
               STA ST0L,Y 
               LDA #0     
               ADC A0+1
               STA ST0H,Y 
               DEC SP0
               TXA 
               TAY 
               LDA (A0),Y 
               TAX 
               INY 
               LDA (A0),Y 
               STX A0
               STA A0+1
               JMP read0
call0          LDA #3
               LDX #1
               BNE c0a
transp0        INY 
               LDA (A0),Y 
               STA TR0
               LDA #2
               JMP adc0
pokedb0        INY 
               LDA (A0),Y 
               TAX 
               INY 
               LDA (A0),Y 
               STA D0,X 
               JMP ad3c0
pokesb0        INY 
               LDA (A0),Y 
               TAX 
               INY 
               LDA (A0),Y 
               STA S0,X 
               JMP ad3c0
nosound0       RTS 
SOUND0         LDX S0+VRC
               BEQ nosound0
 ;
VE0            LDA S0+VWFG
               AND #8
               BEQ adsr0
               LDA CLOK0
               CMP S0+VADSC
               BCS PM0
               LDA #0
               STA S0+VADSC
               LDA S0+VWFG
               AND #246
               STA S0+VWFG
               BNE trigrel0
adsr0          LDA S0+VADSC
               BNE ad0
               DEC S0+VRC
               BNE PM0
               LDX #6
cc0            STA $D400,X 
               DEX 
               BPL cc0
               STX SFL0
               RTS 
ad0            DEC S0+VADSC
               BNE PM0
               LDA S0+VWFG
               AND #246
trigrel0       STA $D404
 ;
PM0            LDA S0+PMC
               BEQ FM0
               LDA S0+PMDLYC
               BEQ pmdel0
               DEC S0+PMDLYC
               JMP FM0
pmdel0         CLC 
               LDX S0+PCURR
               LDY S0+PCURR+1
pms00          LDA S0+PMD0C
               BEQ pms10
               TXA 
               ADC S0+PMG0
               TAX 
               TYA 
               ADC S0+PMG0+1
               TAY 
               DEC S0+PMD0C
               JMP stpm0
pms10          LDA S0+PMD1C
               BEQ pmrep0
               TXA 
               ADC S0+PMG1
               TAX 
               TYA 
               ADC S0+PMG1+1
               TAY 
               DEC S0+PMD1C
               JMP stpm0
pmrep0         LDA S0+PMC
               AND #$81
               BEQ stpm0
               BPL npmopy0
               JSR trnsfrpm0
               JMP pmdel0
npmopy0        JSR trnsfrpm0+12
               JMP pmdel0
stpm0          STX S0+PCURR
               STY S0+PCURR+1
               STX $D402
               STY $D403
 ;
FM0            LDA S0+FMC
               BEQ exit0
               AND #8
               BNE olm0
               LDX S0+FCURR
               LDY S0+FCURR+1
 ; TXA:STY SZ:ORA SZ:BEQ exit0;@
               CLC 
               LDA S0+FMDLYC
               BEQ fcs10+1
               DEC S0+FMDLYC
               LDA S0+FMC
               AND #2
               BNE fcs40l1
exit0          RTS 
olm0           LDX S0+FOLCI
               BPL no0
               LDX S0+FOLII
no0            LDA S0+FOLB
               CLC 
               ADC S0,X 
               DEX 
               STX S0+FOLCI
               TAY 
               LDX LOFRQ,Y 
               LDA HIFRQ,Y 
               STX $D400
               STA $D401
               RTS 
fcs10          CLC 
               LDA S0+FMD0C
               BEQ fcs20
               DEC S0+FMD0C
               TXA 
               ADC S0+FMG0
               TAX 
               TYA 
               ADC S0+FMG0+1
               JMP stf0TAY
               RTS 
fcs20          LDA S0+FMD1C
               BEQ fcs30
               DEC S0+FMD1C
               TXA 
               ADC S0+FMG1
               TAX 
               TYA 
               ADC S0+FMG1+1
               JMP stf0TAY
fcs30          LDA S0+FMD2C
               BEQ fcs40
               DEC S0+FMD2C
               TXA 
               ADC S0+FMG2
               TAX 
               TYA 
               ADC S0+FMG2+1
               JMP stf0TAY
fcs40          LDA S0+FMD3C
               BEQ fcrep0
               DEC S0+FMD3C
fcs40l1        TXA 
               ADC S0+FMG3
               TAX 
               TYA 
               ADC S0+FMG3+1
stf0TAY        TAY 
stf0           STX $D400
               STY $D401
               STX S0+FCURR
               STY S0+FCURR+1
               RTS 
fcrep0         LDA S0+FMC
               AND #$81
               BEQ stf0
               BPL nfcopy0
               JSR trnsferf0
               JMP fcs10
nfcopy0        JSR trnsferf0+12
               JMP fcs10
 ;
 ;
MUSIC1         LDA MFL1
               BEQ mx1
               DEC CLOK1
               BEQ read1
mx1            RTS 
ad3c1          LDA #3
adc1           CLC 
               ADC A1
               STA A1
               BCC read1
               INC A1+1
read1          LDY #0
               LDA (A1),Y 
               CMP #192
               BCC notctrl1
               TAX 
               LDA vt1-192,X 
               STA v1+1
               LDA vt1-191,X 
               STA v1+2
v1             JMP $FFFF
js1            JMP st1
notctrl1       STA Z8
               CMP #96
               BCC idr1
               SBC #96
idr1           CMP #Rst
               BEQ js1
 ; CMP #Sil:BEQ gotnote1;@
               ADC TR1
gotnote1       TAX 
               LDA RF
               AND #2
               BEQ js1 ;\
NOTE1          LDA SFL1
               BEQ js1
               LDA D1+VSRV
               STA $D40D
               LDA D1+VADV
               STA $D40C
               LDA D1+VWF
               STA S1+VWFG
               ORA #8
               STA $D40B
               AND #247
               STA $D40B
               LDA D1+PINIT+1
               STA $D40A
               LDA D1+PINIT
               STA $D409
               LDY HIFRQ,X 
               LDA LOFRQ,X 
               STA S1+FINIT
               STY S1+FINIT+1
               STA $D407
               STY $D408
               LDA D1+PMC
               STA S1+PMC
               BEQ dlf1
               LDY D1+PINIT+1
               STY S1+PINIT+1
               LDX D1+PINIT
               STX S1+PINIT
               STX S1+PCURR
               STY S1+PCURR+1
               LDA D1+PMG1+1
               STA S1+PMG1+1
               LDA D1+PMG1
               STA S1+PMG1
               LDA D1+PMG0+1
               STA S1+PMG0+1
               LDA D1+PMG0
               STA S1+PMG0
               LDA D1+PMDLY
               STA S1+PMDLYC
               LDY D1+PMD1
               STY S1+CPMD1
               LDX D1+PMD0
               STX S1+CPMD0
               STX S1+PMD0C
               STY S1+PMD1C
dlf1           LDX D1+FMC
               STX S1+FMC
               BEQ dld1
               LDY #12
dlfl1          LDA D1,Y 
               STA S1,Y 
               DEY 
               BPL dlfl1
               TXA 
               AND #8
               BEQ nolm1
               LDA Z8
               CMP #96
               BCC idr1a
               SBC #96
               CLC 
idr1a          ADC TR1
               STA S1+FOLB
               BNE dld1
nolm1          JSR trnsferf1
dld1           LDX D1+VADSD
               LDY D1+VRD
               STX S1+VADSC
               STY S1+VRC
st1            LDY #1
               LDA (A1),Y 
               LDX Z8
               CPX #96
               BCS ddr1
               TAX 
               LDA IDR-1,X 
ddr1           STA CLOK1
               LDA #2
adn1           CLC 
               ADC A1
               STA A1
               BCC dia1
               INC A1+1
dia1           RTS 
 ;
MC1            EQU .
retrut1        INC SP1
               LDY SP1
               CPY #8
               BEQ rc1
               LDX ST1L,Y 
               LDA ST1H,Y 
               STX A1
               STA A1+1
               JMP read1
rc1            DEC MFL1
               RTS 
for1           LDX SP1
               CLC 
               LDA #2
               ADC A1
               STA ST1L,X 
               LDA #0
               ADC A1+1
               STA ST1H,X 
               INY 
               LDA (A1),Y 
               STA ST1C,X 
               DEC SP1
               LDA #2
               JMP adc1
next1          LDX SP1
               DEC ST1C+1,X 
               BEQ n1a
               LDY ST1L+1,X 
               LDA ST1H+1,X 
               STY A1
               STA A1+1
               JMP read1
n1a            INC SP1
               LDA #1
               JMP adc1
volume1        INY 
               LDA (A1),Y 
               STA IND
               INY 
               LDA (A1),Y 
               STA IND+1
               LDY #4
tr1            LDA (IND),Y 
               STA D1+VWF,Y 
               DEY 
               BPL tr1
               JMP ad3c1
freq1          INY 
               LDA (A1),Y 
               STA IND
               INY 
               LDA (A1),Y 
               STA IND+1
               LDY #13
fr1a           LDA (IND),Y 
               STA D1,Y 
               DEY 
               LDA (IND),Y 
               STA D1,Y 
               DEY 
               BPL fr1a
               JMP ad3c1
chord1         INY 
               LDA (A1),Y 
               STA IND
               INY 
               LDA (A1),Y 
               STA IND+1
               LDY #9
tr1a           LDA (IND),Y 
               STA D1,Y 
               DEY 
               LDA (IND),Y 
               STA D1,Y 
               DEY 
               BPL tr1a
               JMP ad3c1
load1          INY 
               LDA (A1),Y 
               TAX 
               INY 
               LDA (A1),Y 
               STA Z8
               INY 
               LDA (A1),Y 
               STA IND
               INY 
               LDA (A1),Y 
               STA IND+1
               LDY Z8
load1l         LDA (IND),Y 
               STA D1,X 
               DEX 
               DEY 
               BPL load1l
               LDA #5
               JMP adc1
gotot1         INY 
               LDA (A1),Y 
               STA TR1
               INY 
               LDA (A1),Y 
               TAX 
               INY 
               LDA (A1),Y 
               STX A1
               STA A1+1
               JMP read1
goto1          INY 
               LDA (A1),Y 
               TAX 
               INY 
               LDA (A1),Y 
               STX A1
               STA A1+1
               JMP read1
code1          LDA ^ad3c1-1
               PHA 
               LDA #ad3c1-1
               PHA 
               INY 
               LDA (A1),Y 
               STA codev1+1
               INY 
               LDA (A1),Y 
               STA codev1+2
codev1         JMP $FFFF
callt1         LDY #1
               LDX #2
               LDA (A1),Y 
               STA TR1
               LDA #4
c1a            LDY SP1
               CLC 
               ADC A1
               STA ST1L,Y 
               LDA #0     
               ADC A1+1
               STA ST1H,Y 
               DEC SP1
               TXA 
               TAY 
               LDA (A1),Y 
               TAX 
               INY 
               LDA (A1),Y 
               STX A1
               STA A1+1
               JMP read1
call1          LDA #3
               LDX #1
               BNE c1a
transp1        INY 
               LDA (A1),Y 
               STA TR1
               LDA #2
               JMP adc1
pokedb1        INY 
               LDA (A1),Y 
               TAX 
               INY 
               LDA (A1),Y 
               STA D1,X 
               JMP ad3c1
pokesb1        INY 
               LDA (A1),Y 
               TAX 
               INY 
               LDA (A1),Y 
               STA S1,X 
               JMP ad3c1
 ;
nosound1       RTS 
SOUND1         LDX S1+VRC
               BEQ nosound1
 ;
VE1            LDA S1+VWFG
               AND #8
               BEQ adsr1
               LDA CLOK1
               CMP S1+VADSC
               BCS PM1
               LDA #00
               STA S1+VADSC
               LDA S1+VWFG
               AND #246
               STA S1+VWFG
               BNE trigrel1
adsr1          LDA S1+VADSC
               BNE ad1
               DEC S1+VRC
               BNE PM1
               LDX #6
cc1            STA $D407,X 
               DEX 
               BPL cc1
               STX SFL1
               RTS 
ad1            DEC S1+VADSC
               BNE PM1
               LDA S1+VWFG
               AND #246
trigrel1       STA $D40B
 ;
PM1            LDA S1+PMC
               BEQ FM1
               LDA S1+PMDLYC
               BEQ pmdel1
               DEC S1+PMDLYC
               JMP FM1
pmdel1         CLC 
               LDX S1+PCURR
               LDY S1+PCURR+1
pms01          LDA S1+PMD0C
               BEQ pms11
               TXA 
               ADC S1+PMG0
               TAX 
               TYA 
               ADC S1+PMG0+1
               TAY 
               DEC S1+PMD0C
               JMP stpm1
pms11          LDA S1+PMD1C
               BEQ pmrep1
               TXA 
               ADC S1+PMG1
               TAX 
               TYA 
               ADC S1+PMG1+1
               TAY 
               DEC S1+PMD1C
               JMP stpm1
pmrep1         LDA S1+PMC
               AND #$81
               BEQ stpm1
               BPL npmopy1
               JSR trnsfrpm1
               JMP pmdel1
npmopy1        JSR trnsfrpm1+12
               JMP pmdel1
stpm1          STX S1+PCURR
               STY S1+PCURR+1
               STX $D409
               STY $D40A
 ;
FM1            LDA S1+FMC
               BEQ exit1
               AND #8
               BNE olm1
               LDX S1+FCURR
               LDY S1+FCURR+1
 ; TXA:STY SZ:ORA SZ:BEQ exit2;@
               CLC 
               LDA S1+FMDLYC
               BEQ fcs11+1
               DEC S1+FMDLYC
               LDA S1+FMC
               AND #2
               BNE fcs41l1
exit1          RTS 
olm1           LDX S1+FOLCI
               BPL no1
               LDX S1+FOLII
no1            LDA S1+FOLB
               CLC 
               ADC S1,X 
               DEX 
               STX S1+FOLCI
               TAY 
               LDX LOFRQ,Y 
               LDA HIFRQ,Y 
               STX $D407
               STA $D408
               RTS 
fcs11          CLC 
               LDA S1+FMD0C
               BEQ fcs21
               DEC S1+FMD0C
               TXA 
               ADC S1+FMG0
               TAX 
               TYA 
               ADC S1+FMG0+1
               JMP stf1TAY
fcs21          LDA S1+FMD1C
               BEQ fcs31
               DEC S1+FMD1C
               TXA 
               ADC S1+FMG1
               TAX 
               TYA 
               ADC S1+FMG1+1
               JMP stf1TAY
fcs31          LDA S1+FMD2C
               BEQ fcs41
               DEC S1+FMD2C
               TXA 
               ADC S1+FMG2
               TAX 
               TYA 
               ADC S1+FMG2+1
               JMP stf1TAY
fcs41          LDA S1+FMD3C
               BEQ fcrep1
               DEC S1+FMD3C
fcs41l1        TXA 
               ADC S1+FMG3
               TAX 
               TYA 
               ADC S1+FMG3+1
stf1TAY        TAY 
stf1           STX $D407
               STY $D408
               STX S1+FCURR
               STY S1+FCURR+1
               RTS 
fcrep1         LDA S1+FMC
               AND #$81
               BEQ stf1
               BPL nfcopy1
               JSR trnsferf1
               JMP fcs11
nfcopy1        JSR trnsferf1+12
               JMP fcs11
 ;
MUSIC2         LDA MFL2
               BEQ mx2
               DEC CLOK2
               BEQ read2
mx2            RTS 
ad3c2          LDA #3
adc2           CLC 
               ADC A2
               STA A2
               BCC read2
               INC A2+1
read2          LDY #0
               LDA (A2),Y 
               CMP #192
               BCC notctrl2
               TAX 
               LDA vt2-192,X 
               STA v2+1
               LDA vt2-191,X 
               STA v2+2
v2             JMP $FFFF
js2            JMP st2
notctrl2       STA Z8
               CMP #96
               BCC idr2
               SBC #96
idr2           CMP #Rst
               BEQ js2
 ; CMP #Sil:BEQ gotnote2;@
               ADC TR2
gotnote2       TAX 
               LDA RF
               AND #4
               BEQ js2 ;\
NOTE2          LDA SFL2
               BEQ js2
               LDA D2+VSRV
               STA $D414
               LDA D2+VADV
               STA $D413
               LDA D2+VWF
               STA S2+VWFG
               ORA #8
               STA $D412
               AND #247
               STA $D412
               LDA D2+PINIT+1
               STA $D411
               LDA D2+PINIT
               STA $D410
               LDY HIFRQ,X 
               LDA LOFRQ,X 
               STA S2+FINIT
               STY S2+FINIT+1
               STA $D40E
               STY $D40F
               LDA D2+PMC
               STA S2+PMC
               BEQ dlf2
               LDY D2+PINIT+1
               STY S2+PINIT+1
               LDX D2+PINIT
               STX S2+PINIT
               STX S2+PCURR
               STY S2+PCURR+1
               LDA D2+PMG1+1
               STA S2+PMG1+1
               LDA D2+PMG1
               STA S2+PMG1
               LDA D2+PMG0+1
               STA S2+PMG0+1
               LDA D2+PMG0
               STA S2+PMG0
               LDA D2+PMDLY
               STA S2+PMDLYC
               LDY D2+PMD1
               STY S2+CPMD1
               LDX D2+PMD0
               STX S2+CPMD0
               STX S2+PMD0C
               STY S2+PMD1C
dlf2           LDX D2+FMC
               STX S2+FMC
               BEQ dld2
               LDY #12
dlfl2          LDA D2,Y 
               STA S2,Y 
               DEY 
               BPL dlfl2
               TXA 
               AND #8
               BEQ nolm2
               LDA Z8
               CMP #96
               BCC idr2a
               SBC #96
               CLC 
idr2a          ADC TR2
               STA S2+FOLB
               BNE dld2
nolm2          JSR trnsferf2
dld2           LDX D2+VADSD
               LDY D2+VRD
               STX S2+VADSC
               STY S2+VRC
st2            LDY #1
               LDA (A2),Y 
               LDX Z8
               CPX #96
               BCS ddr2
               TAX 
               LDA IDR-1,X 
ddr2           STA CLOK2
               LDA #2
adn2           CLC 
               ADC A2
               STA A2
               BCC dia2
               INC A2+1
dia2           RTS 
 ;
MC2            EQU .
retrut2        INC SP2
               LDY SP2
               CPY #8
               BEQ rc2
               LDX ST2L,Y 
               LDA ST2H,Y 
               STX A2
               STA A2+1
               JMP read2
rc2            DEC MFL2
               RTS 
for2           LDX SP2
               CLC 
               LDA #2
               ADC A2
               STA ST2L,X 
               LDA #0
               ADC A2+1
               STA ST2H,X 
               INY 
               LDA (A2),Y 
               STA ST2C,X 
               DEC SP2
               LDA #2
               JMP adc2
next2          LDX SP2
               DEC ST2C+1,X 
               BEQ n2a
               LDY ST2L+1,X 
               LDA ST2H+1,X 
               STY A2
               STA A2+1
               JMP read2
n2a            INC SP2
               LDA #1
               JMP adc2
volume2        INY 
               LDA (A2),Y 
               STA IND
               INY 
               LDA (A2),Y 
               STA IND+1
               LDY #4
tr2            LDA (IND),Y 
               STA D2+VWF,Y 
               DEY 
               BPL tr2
               JMP ad3c2
freq2          INY 
               LDA (A2),Y 
               STA IND
               INY 
               LDA (A2),Y 
               STA IND+1
               LDY #13
fr2a           LDA (IND),Y 
               STA D2,Y 
               DEY 
               LDA (IND),Y 
               STA D2,Y 
               DEY 
               BPL fr2a
               JMP ad3c2
chord2         INY 
               LDA (A2),Y 
               STA IND
               INY 
               LDA (A2),Y 
               STA IND+1
               LDY #9
tr2a           LDA (IND),Y 
               STA D2,Y 
               DEY 
               LDA (IND),Y 
               STA D2,Y 
               DEY 
               BPL tr2a
               JMP ad3c2
load2          INY 
               LDA (A2),Y 
               TAX 
               INY 
               LDA (A2),Y 
               STA Z8
               INY 
               LDA (A2),Y 
               STA IND
               INY 
               LDA (A2),Y 
               STA IND+1
               LDY Z8
load2l         LDA (IND),Y 
               STA D2,X 
               DEX 
               DEY 
               BPL load2l
               LDA #5
               JMP adc2
gotot2         INY 
               LDA (A2),Y 
               STA TR2
               INY 
               LDA (A2),Y 
               TAX 
               INY 
               LDA (A2),Y 
               STX A2
               STA A2+1
               JMP read2
goto2          INY 
               LDA (A2),Y 
               TAX 
               INY 
               LDA (A2),Y 
               STX A2
               STA A2+1
               JMP read2
code2          LDA ^ad3c2-1
               PHA 
               LDA #ad3c2-1
               PHA 
               INY 
               LDA (A2),Y 
               STA codev2+1
               INY 
               LDA (A2),Y 
               STA codev2+2
codev2         JMP $FFFF
callt2         LDY #1
               LDX #2
               LDA (A2),Y 
               STA TR2
               LDA #4
c2a            LDY SP2
               CLC 
               ADC A2
               STA ST2L,Y 
               LDA #0     
               ADC A2+1
               STA ST2H,Y 
               DEC SP2
               TXA 
               TAY 
               LDA (A2),Y 
               TAX 
               INY 
               LDA (A2),Y 
               STX A2
               STA A2+1
               JMP read2
call2          LDA #3
               LDX #1
               BNE c2a
transp2        INY 
               LDA (A2),Y 
               STA TR2
               LDA #2
               JMP adc2
pokedb2        INY 
               LDA (A2),Y 
               TAX 
               INY 
               LDA (A2),Y 
               STA D2,X 
               JMP ad3c2
pokesb2        INY 
               LDA (A2),Y 
               TAX 
               INY 
               LDA (A2),Y 
               STA S2,X 
               JMP ad3c2
 ;
nosound2       RTS 
SOUND2         LDX S2+VRC
               BEQ nosound2
 ;
VE2            LDA S2+VWFG
               AND #8
               BEQ adsr2
               LDA CLOK2
               CMP S2+VADSC
               BCS PM2
               LDA #00
               STA S2+VADSC
               LDA S2+VWFG
               AND #246
               STA S2+VWFG
               BNE trigrel2
adsr2          LDA S2+VADSC
               BNE ad2
               DEC S2+VRC
               BNE PM2
               LDX #6
cc2            STA $D40E,X 
               DEX 
               BPL cc2
               STX SFL2
               RTS 
ad2            DEC S2+VADSC
               BNE PM2
               LDA S2+VWFG
               AND #246
trigrel2       STA $D412
 ;
PM2            LDA S2+PMC
               BEQ FM2
               LDA S2+PMDLYC
               BEQ pmdel2
               DEC S2+PMDLYC
               JMP FM2
pmdel2         CLC 
               LDX S2+PCURR
               LDY S2+PCURR+1
pms02          LDA S2+PMD0C
               BEQ pms12
               TXA 
               ADC S2+PMG0
               TAX 
               TYA 
               ADC S2+PMG0+1
               TAY 
               DEC S2+PMD0C
               JMP stpm2
pms12          LDA S2+PMD1C
               BEQ pmrep2
               TXA 
               ADC S2+PMG1
               TAX 
               TYA 
               ADC S2+PMG1+1
               TAY 
               DEC S2+PMD1C
               JMP stpm2
pmrep2         LDA S2+PMC
               AND #$81
               BEQ stpm2
               BPL npmopy2
               JSR trnsfrpm2
               JMP pmdel2
npmopy2        JSR trnsfrpm2+12
               JMP pmdel2
stpm2          STX S2+PCURR
               STY S2+PCURR+1
               STX $D410
               STY $D411
 ;
FM2            LDA S2+FMC
               BEQ exit2
               AND #8
               BNE olm2
               LDX S2+FCURR
               LDY S2+FCURR+1
 ; TXA:STY SZ:ORA SZ:BEQ exit2;@
               CLC 
               LDA S2+FMDLYC
               BEQ fcs12+1
               DEC S2+FMDLYC
               LDA S2+FMC
               AND #2
               BNE fcs42l1
exit2          RTS 
olm2           LDX S2+FOLCI
               BPL no2
               LDX S2+FOLII
no2            LDA S2+FOLB
               CLC 
               ADC S2,X 
               DEX 
               STX S2+FOLCI
               TAY 
               LDX LOFRQ,Y 
               LDA HIFRQ,Y 
               STX $D40E
               STA $D40F
               RTS 
fcs12          CLC 
               LDA S2+FMD0C
               BEQ fcs22
               DEC S2+FMD0C
               TXA 
               ADC S2+FMG0
               TAX 
               TYA 
               ADC S2+FMG0+1
               JMP stf2TAY
fcs22          LDA S2+FMD1C
               BEQ fcs32
               DEC S2+FMD1C
               TXA 
               ADC S2+FMG1
               TAX 
               TYA 
               ADC S2+FMG1+1
               JMP stf2TAY
fcs32          LDA S2+FMD2C
               BEQ fcs42
               DEC S2+FMD2C
               TXA 
               ADC S2+FMG2
               TAX 
               TYA 
               ADC S2+FMG2+1
               JMP stf2TAY
fcs42          LDA S2+FMD3C
               BEQ fcrep2
               DEC S2+FMD3C
fcs42l1        TXA 
               ADC S2+FMG3
               TAX 
               TYA 
               ADC S2+FMG3+1
stf2TAY        TAY 
stf2           STX $D40E
               STY $D40F
               STX S2+FCURR
               STY S2+FCURR+1
               RTS 
fcrep2         LDA S2+FMC
               AND #$81
               BEQ stf2
               BPL nfcopy2
               JSR trnsferf2
               JMP fcs12
nfcopy2        JSR trnsferf2+12
               JMP fcs12
 ;
CE             EQU .
TS             EQU .
 ;
D0             DFS 29,1
ST0L           DFS 8,0
ST0H           DFS 8,0
ST0C           DFS 8,0
 ;
D1             DFS 29,1
ST1L           DFS 8,0
ST1H           DFS 8,0
ST1C           DFS 8,0
 ;
D2             DFS 29,1
ST2L           DFS 8,0
ST2H           DFS 8,0
ST2C           DFS 8,0
IDR            DFS 16,0
 ;
S0             DFS 39,1
S1             DFS 39,1
S2             DFS 39,1
CHP            DFB 0,0,0
SBTAB          DFB S0+23-S0,S1+23-S0,S2+23-S0
CHTAB          DFB $D402+0*7-$D400,$D402+1*7-$D400,$D402+2*7-$D400
DTAB           DFB D0-D0,D1-D0,D2-D0
LFC            DFB 1,2,0
HIFRQ          DFB 1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,4,4,4,4,5,5,5
               DFB 6,6,6,7,7,8,8,9,9,10,10,11,12,12,13,14,15,16,17,18,19,20,21
               DFB 22,24,25,27,28,30,32,34,36,38,40,43,45,48,51,54,57,61,64,68
               DFB 72,76,81,86,91,96,102,108,115,122,129,137,145,153,163,172
               DFB 183,193,205,217,230,0
LOFRQ          DFB 18,35,52,70,90,110,132,155,179,205,233,6,37,69,104,140,179
               DFB 220,8,54,103,155,210,12,73,139,208,25,103,185,16,108,206
               DFB 53,163,23,147,21,159,60,205,114,32,216,156,107,70,47,37,42
               DFB 63,100,154,227,63,177,56,214,141,94,75,85,126,200,52,198
               DFB 127,97,111,172,126,188,149,169,252,161,105,140,254,194,223
               DFB 88,52,120,43,83,247,31,210,25,252,133,189,176,0
vt0            DFW retrut0,call0
               DFW goto0,callt0
               DFW gotot0,pokedb0
               DFW for0,next0
               DFW load0,chord0
               DFW freq0,volume0
               DFW pokesb0,code0
               DFW transp0
vt1            DFW retrut1,call1
               DFW goto1,callt1
               DFW gotot1,pokedb1
               DFW for1,next1
               DFW load1,chord1
               DFW freq1,volume1
               DFW pokesb1,code1
               DFW transp1
vt2            DFW retrut2,call2
               DFW goto2,callt2
               DFW gotot2,pokedb2
               DFW for2,next2
               DFW load2,chord2
               DFW freq2,volume2
               DFW pokesb2,code2
               DFW transp2
TE             EQU .
DS             EQU .
 ;
 ;=====SOUND EFFECT DATABLOCKS====
 ;
DOG0           DFB 9,256-35,1,2,3
               DFB 4,5,6,7,8,35,9,0,13
               DFB 15,255,0,4
               DFW +100,-50,$400
               DFB 65,$16,$67,19,6
               DFW 2071
FLAME1         DFW +100,0,0,0
               DFB 5,0,0,0,3,5+128
               DFB 15,255,0,5
               DFW +50,-5,$800
               DFB 65,$90,$F0,30,2
               DFW 1000
FLAME2         DFW +100,-100,0,+3
               DFB 4,4,0,0,10,7
               DFB 5,5,5,5
               DFW +5,-5,$800
               DFB 67,$90,$F0,30,2
               DFW 2000
EXPL0          DFW -3000,0,+4000,-50
               DFB 1,6,1,255,4,4
               DFS 10,0
               DFB 129,0,$C8,25,25
               DFW 3000
EXPL1          DFW -30000,+20000
               DFW -40000,+30000
               DFB 3,3,3,3,12,5
               DFS 10,0
               DFB 21,$11,$D8,17,20
               DFW 0
EXPL2          DFW -1300,0,+1700,-15
               DFB 1,6,1,255,4,4
               DFB 255,0,0,4
               DFW +40,0,$800
               DFB 67,0,$C8,20,30
               DFW 1300
JET0           DFW -50,0,0,0
               DFB 255,0,0,0,0,5
               DFS 10,0
               DFB 129,$A4,$AA,70,40
               DFW 6750
JET1           DFW 300,-50,0,3
               DFB 10,255,0,0,20,7
               DFS 10,0
               DFB 129,$A4,$AA,70,40
               DFW 1000
KILL0          DFW +200,0,0,0
               DFB 255,0,0,0,0,5
               DFS 10,0
               DFB 129,$00,$F0,9,1
               DFW 1500
GUN0           DFS 14,0
               DFS 10,0
               DFB 129,$00,$D9,2,28
               DFW 11500
GUN1           DFS 14,0
               DFS 10,0
               DFB 129,$00,$D9,2,28
               DFW 9500
 ;
 ;========GAME START MUSIC========
 ;
E              EQU 5
TIME           DFB 1*E,2*E,3*E,4*E ;E=5
               DFB 5*E,6*E,7*E,8*E
               DFB 9*E,10*E,11*E,12*E
               DFB 13*E,14*E,15*E,16*E
D              EQU 4
TIMD           DFB 1*D,2*D,3*D,4*D ;D=4
               DFB 5*D,6*D,7*D,8*D
               DFB 9*D,10*D,11*D,12*D
               DFB 13*D,14*D,15*D,16*D
BD             EQU 40
SN             EQU 50
TH             EQU 47
TL             EQU 43
 ;
STRT0          DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
               DFB 50,2,50,1,49,6
               DFB 50,2,50,1,49,3
               DFB 50,2,52,1,53,2,53,1
               DFB 53,3,52,1,53,1,52,1
               DFB 50,2,50,1,49,6
               DFB 50,2,50,1,49,3
               DFB 50,1,55,1,58,1
               DFB Moke,VSRV,$77
               DFB 62,4
EXIT           DFB Ret
 ;
STRT1          DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
               DFB 46,2,46,1,45,6
               DFB 46,2,46,1,45,3
               DFB 46,2,49,1,50,2,50,1
               DFB 50,3,49,1,50,1,49,1
               DFB 46,2,46,1,45,6
               DFB 46,2,46,1,45,3
               DFB 46,1,50,1,55,1
               DFB Moke,VSRV,$77
               DFB 58,4
               DFB Ret
 ;
STRT2          DFB Load,68,15
               DFW TIMF
               DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
               DFB 31,2,31,1,38,3,26,2
               DFB 26,1
               DFB 31,2,31,1,38,3,31,2
               DFB 33,1
               DFB 34,2,34,1,34,3
               DFB 33,1,34,1,33,1
               DFB 31,2,31,1,38,3,26,2
               DFB 26,1
               DFB 31,2,31,1,38,2,26,1
               DFB 31,2,29,1
               DFB Moke,VSRV,$77
               DFB 27,4
               DFB Ret
 ;
 ;=====CHALLENGE STAGE MUSIC======
 ;
CD00           DFW +30,-30,+30,+300
               DFB 4,8,4,0,25,7
               DFB 5,5,25,5
               DFW +50,-50,$800
               DFB 65,$A6,$F8,90,10
CHAL0          DFB Load,28,28
               DFW CD00
               DFB For,3
               DFB 10+R,92
               DFB Next
               DFB Ret
 ;
CHAL2          DFB Load,28,28
               DFW CD00
               DFB Moke,FMG3
               DFL +302
               DFB For,3
               DFB 13+R,92
               DFB Next
               DFB Ret
 ;
 ;==PERSONNEL TRUCK SOUND EFFECT==
 ;
TRUK           DFW +45,-45,+20,-20
               DFB 5,5,5,5,80,7
               DFS 10,0
               DFB 33,$BB,$5A,255,50
 ;
TRUK0          DFB Load,28,28
               DFW TRUK
               DFB 37+R,10
TRUK0L         DFB Rst+R,5
               DFB Soke,VADSC,10
               DFB Jmp
               DFW TRUK0L
 ;
 ;==AUTOGYRO ROTOR SOUND EFFECT===
 ;
AUTO           DFW -100,-1042,0,0
               DFB 7,1,2,0,0,5+128
               DFS 10,0
               DFB 129,$AA,$DA,255,50
 ;
AUTO0          DFB Load,28,28
               DFW AUTO
               DFB 32+R,10
AUTO0L         DFB Rst+R,5
               DFB Soke,VADSC,10
               DFB Jmp
               DFW AUTO0L
 ;
 ;====GAME MUSIC WITH 3 SIREN=====
 ;
GAM32          DFB For,3
               DFB Call
               DFW SYRN2
               DFB Rst+R,60
               DFB Next
               DFB Jmp
               DFW GAM12a
 ;
 ;====GAME MUSIC WITH 1 SIREN=====
 ;
GS20           DFB For,2
               DFB Code
               DFW SNARE
               DFB Rst,4
               DFB For,2
               DFB Code
               DFW SNARE
               DFB Rst,2
               DFB Next
               DFB Next
               DFB For,3
               DFB Code
               DFW SNARE
               DFB Rst,4
               DFB Next
               DFB For,4
               DFB Code
               DFW SNARE
               DFB Rst,1
               DFB Next
               DFB Ret
 ;
GS21           DFB Code
               DFW SNARE
               DFB Rst,4
               DFB For,6
               DFB Code
               DFW SNARE
               DFB Rst,2
               DFB Next
               DFB Code
               DFW SNARE
               DFB Rst,4
               DFB For,4
               DFB Code
               DFW SNARE
               DFB Rst,1
               DFB Next
               DFB Code
               DFW SNARE
               DFB Rst,8
               DFB Ret
 ;
GS22           DFB For,2
               DFB Code
               DFW SNARE
               DFB Rst,4
               DFB Code
               DFW SNARE
               DFB Rst,12
               DFB Next
               DFB For,16
               DFB Code
               DFW SNARE
               DFB Rst,1
               DFB Next
               DFB Code
               DFW SNARE
               DFB Rst,4
               DFB Code
               DFW SNARE
               DFB Rst,12
               DFB Ret
 ;
SNARE          RTS  ;LDA SFL0:AND SFL1:AND SFL2:BEQ NOSNARE
               LDA #0
               STA S0+FMC
               STA S1+FMC
               STA S2+FMC
               STA S0+PMC
               STA S1+PMC
               STA S2+PMC
               LDX #10000
               LDY ^10000
               STX $D400
               STY $D401
               LDX #5000
               LDY ^5000
               STX $D407
               STY $D408
               LDX #1000
               LDY ^1000
               STX $D40E
               STY $D40F
               STA $D405
               LDA #3
               STA $D40C
               STA $D413
               STA S0+VADSC
               STA S1+VADSC
               STA S2+VADSC
               LDA #$86
               STA $D406
               LDX #$C4
               STA $D40D
               DEX 
               STA $D414
               LDX #$11
               STX $D412
               STX $D40B
               STX S2+VWFG
               STX S1+VWFG
               LDX #$81
               STX $D404
               STX S0+VWFG
               LDA #8
               STA S0+VRC
               STA S1+VRC
               STA S2+VRC
NOSNARE        RTS 
 ;
GAM12          DFB Call
               DFW SYRN2
               DFB Rst+R,60
GAM12a         DFB For,2
               DFB For,3
               DFB Call
               DFW GS20
               DFB Next
               DFB Call
               DFW GS21
               DFB Next
               DFB Call
               DFW GS20
               DFB Call
               DFW GS20
               DFB Call
               DFW GS22
               DFB Jmp
               DFW GAM12a
 ;
 ;======== LOST A LIFE MUSIC =====
 ;
F              EQU 6
TIMF           DFB 1*F,2*F,3*F,4*F ;F=6
               DFB 5*F,6*F,7*F,8*F
               DFB 9*F,10*F,11*F,12*F
               DFB 13*F,14*F,15*F,16*F
 ;
Q              EQU 6
LIFE0          DFB Call
               DFW RESTOWR
               DFB 62+R,Q,58+R,Q
               DFB 57+R,Q,55+R,Q
               DFB 53+R,Q,55+R,Q
               DFB 53+R,Q,52+R,Q
               DFB Frq
               DFW HD00
               DFB 50+R,1
               DFB Ret
 ;
RESTOWR        DFB Load,28,14
               DFW LD00
               DFB Moke,24,65
               DFB Moke,27,25
               DFB Ret
 ;
LIFE1          DFB Call
               DFW RESTOWR
               DFB Tsp,256-12
               DFB 62+R,Q,58+R,Q
               DFB 57+R,Q,55+R,Q
               DFB 53+R,Q,55+R,Q
               DFB 53+R,Q,52+R,Q
               DFB Frq
               DFW HD00
               DFB 53+R,1
               DFB Ret
 ;
LIFE2          DFB Call
               DFW RESTOWR
               DFB 33+R,Q,31+R,Q
               DFB 29+R,Q,28+R,Q
               DFB 33+R,Q,34+R,Q
               DFB 33+R,Q,31+R,Q
               DFB Frq
               DFW HD00
               DFB 29+R,1
               DFB Ret
 ;
 ;========GAME OVER MUSIC=========
 ;
OVER0          DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
               DFB 53,9,56,2,53,1
               DFB 60,9,56,2,53,1
               DFB 63,3,62,6,58,2,53,1
               DFB 58,6,58,3,60,3
               DFB 61,6,56,3,53,3
               DFB 63,2,58,1,55,3
               DFB 53,1,51,1,46,1
               DFB 43,1,46,1,51,1
               DFB 53,1,48,1,46,1
               DFB 45,8
               DFB Ret
 ;
OVER1          DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
               DFB 48,9,53,2,48,1
               DFB 53,9,53,2,48,1
               DFB 58,3,58,6,53,2,46,1
               DFB 53,6,53,3,55,3
               DFB 56,6,53,3,49,3
               DFB Tsp,+12
               DFB 63,2,58,1,55,3
               DFB 53,1,51,1,46,1
               DFB 43,1,46,1,51,1
               DFB 53,1,48,1,46,1
               DFB 45,8
               DFB Ret
 ;
OVER2          DFB Load,68,15
               DFW TIMF
               DFB Load,28,28
               DFW AD20
               DFB For,2
               DFB 29,3,29,1,29,1,29,1
               DFB 29,3,29,3
               DFB Next
               DFB 34,3,34,1,34,1,34,1
               DFB 34,3,34,3
               DFB 34,3,34,1,34,1,34,1
               DFB 34,3,36,3
               DFB 37,3,37,1,37,1,37,1
               DFB 37,3,37,3
               DFB For,4,39,3,Next
               DFB Moke,VADSD,50
               DFB 29,1
               DFB Ret
 ;
 ;===MISSION ACCOMPLISHED MUSIC===
 ;
ACCO1          DFB Rst,2
ACCO0          DFB Load,28,28
               DFW AD20
               DFB Moke,VADSD,40
ACCOb          DFB 56,4,53,2,49,6
               DFB 53,6,56,6,61,12
               DFB 65,4,63,2,61,6
               DFB 53,6,55,6,56,12
               DFB 56,6,65,9,63,3
               DFB 61,6,60,12,58,4
               DFB 60,2
ACCOa          DFB 61,6,61,6,56,6,53,6
               DFB Moke,VADSD,20
               DFB 49,1
               DFB Ret
 ;
AD20           DFW +15,-15,+15,0
               DFB 3,6,3,0,7,5
               DFB 8,255,3,4
               DFW +64,-5,$700
               DFB 65,$18,$79,8,30
 ;
ACCO2          DFB Load,68,15
               DFW TIMD
               DFB Load,28,28
               DFW AD20
               DFB Moke,VADSD,30
               DFB Tsp,+12
               DFB 32,4,29,2,25,6
               DFB 25,6,24,6,22,12
               DFB 21,6,22,6
               DFB 29,6,27,6,20,10
               DFB 18,2,17,4,15,2
               DFB Tsp,+0
               DFB 25,10,27,2,29,4
               DFB 30,2,32,12,34,4
               DFB 36,2
               DFB Moke,VADSD,40
               DFB JT,256-12
               DFW ACCOa
 ;
 ;======SIRENS WAILING MUSIC======
 ;
SD00           DFW +30,-30,+30,+273
               DFB 4,8,4,0,25,7
               DFB 5,5,25,5
               DFW +50,-50,$800
               DFB 65,$86,$FA,65,75
GAM30          DFB Call
               DFW SYRN0
               DFB Rst+R,60
               DFB Call
               DFW SYRN0
               DFB Rst+R,60
GAM10          EQU .
SYRN0          DFB Rst+R,1
               DFB Load,28,28
               DFW SD00
               DFB Rst+R,1
               DFB 22+R,66
               DFB Soke,FBD,255
               DFB Soke,FBG
               DFL -105
               DFB Soke,FBG+1
               DFH -105
               DFB Rst+R,1
               DFB Ret
 ;
SYRN2          DFB Rst+R,1
               DFB Load,28,28
               DFW SD00
               DFB Load,68,15
               DFW TIMC
               DFB Rst+R,1
               DFB 23+R,66
               DFB Soke,FBD,255
               DFB Soke,FBG
               DFL -105
               DFB Soke,FBG+1
               DFH -105
               DFB Rst+R,1
               DFB Ret
 ;
 ;=====COMPLETED LEVEL 1 MUSIC====
 ;
LD00           DFB 8,255,3,4
               DFW +64,-5,$700
               DFB 73,$18,$79,3,30
COL10          DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
               DFB 51,4,51,4,58,6,53,1
               DFB 55,1,56,2,55,2,53,2
               DFB 51,2,53,4,46,4,48,4
               DFB 48,3,44,1,56,2,55,2
               DFB 53,2,51,2,58,8,53,4
               DFB 50,3,50,1
               DFB 44,2,48,2,51,2
               DFB 48,2,46,2,50,2,53,2
               DFB 50,2,51,8
               DFB Ret
 ;
COL11          DFB Call
               DFW RESTOWR
               DFB Frq
               DFW HD00
               DFB 51,4,51,4,58,6,56,1
               DFB 58,1,60,2,55,2,53,2
               DFB 51,2,53,4,46,4,48,4
               DFB 48,3,44,1,56,2,55,2
               DFB 53,2,51,2,53,8,53,4
               DFB 50,3,50,1
               DFB 44,1,48,1,51,1,56,1
               DFB 60,1,56,1,51,1,48,1
               DFB 46,1,50,1,53,1,58,1
               DFB 62,1,58,1,53,1,50,1
               DFB Moke,VSRV,$7A
               DFB Moke,VADSD,15
               DFB 55,1
               DFB Ret
 ;
COL12          DFB Load,68,15
               DFW TIMD
               DFB Load,28,28
               DFW AD20
               DFB 39,4,34,4,39,4,34,4
               DFB 36,2,34,2,32,2,31,2
               DFB 34,2,36,2,34,4
               DFB 36,4,32,4,36,4,32,4
               DFB 34,4,36,4,34,4,31,4
               DFB Moke,FMC,0
               DFB 32,8,34,8,31,1
               DFB Ret
 ;
 ;=====COMPLETED LEVEL 2 MUSIC====
 ;
COL20          DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
               DFB 51,2,51,1,56,3,51,3
               DFB 58,3,51,1,55,1,58,1
               DFB 63,2,60,1,56,5,56,1
               DFB 60,2,56,1,53,3,61,6
               DFB 58,2,55,1
               DFB 56,8
               DFB Ret
 ;
COL21          DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
               DFB Tsp,+12
               DFB 51,2,51,1,56,3,51,3
               DFB 58,3,51,1,55,1,58,1
               DFB 63,2,60,1,56,5
               DFB Tsp,+0
               DFB 56,1,60,2,56,1,53,3
               DFB 58,6,55,2,51,1
               DFB 48,8
               DFB Ret
 ;
COL22          DFB Load,68,15
               DFW TIMF
               DFB Load,28,28
               DFW AD20
               DFB Rst,3,32,3,32,3
               DFB 27,3,27,3
               DFB 32,3,32,3,32,3,27,3
               DFB 25,3,25,3,27,3,27,3
               DFB 32,3,27,3,32,1
               DFB Ret
 ;
 ;=====COMPLETED LEVEL 3 MUSIC====
 ;
COL31          DFB Rst+R,2*F
COL30          DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
               DFB 54,2,54,1,59,4,51,1
               DFB 54,1,63,1,59,1,63,1
               DFB 66,3,63,3,63,2,63,1
               DFB 64,3,59,2,59,1,64,1
               DFB 63,1,61,1,59,3,58,3
               DFB 54,1,54,1,54,1,59,3
               DFB 54,2,59,1,63,1,61,1
               DFB 59,1,66,3,63,3,64,2
               DFB 64,1,66,3,58,2,61,1
               DFB 66,1,66,1,66,1,59,6
               DFB Ret
 ;
COL32          DFB Load,68,15
               DFW TIMF
               DFB Load,28,28
               DFW AD20
               DFB Rst,3
               DFB 35,3,35,1,35,1,35,1
               DFB 35,2,35,1,35,3,35,3
               DFB 32,2,32,1,28,3,28,2
               DFB 28,1,29,2,29,1,30,2
               DFB 25,1,30,3,34,3
               DFB 35,3,35,1,35,1,35,1
               DFB 35,3
               DFB 35,3,35,3,28,3,30,3
               DFB 30,2,30,1,30,1,30,1
               DFB 30,1,35,2,30,1,35,1
               DFB Ret
 ;
 ;=====HIGH-SCORE TABLE MUSIC=====
 ;
HD00           DFW +15,-15,+15,0
               DFB 3,6,3,0,7,5
               DFB 6,255,1,4
               DFW +100,-50,$600
HV00           DFB 65,$06,$D7,10,10
 ;
HIGH0          DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
HIGH0L         DFB 53,2,58,8,53,2
               DFB 62,3,60,1,58,2
               DFB 55,14
               DFB 60,2,60,4,58,2
               DFB 57,3,58,1,57,2,55,2
               DFB 53,2,50,8
               DFB 50,2,51,2,52,2
               DFB 53,2,58,8,53,2
               DFB 62,3,60,1,58,2
               DFB 55,14
               DFB 60,2,60,4,58,2
               DFB 57,2,53,4,60,2
               DFB 58,16
               DFB Jmp
               DFW HIGH0L
 ;
HIGH1          DFB Load,28,14
               DFW LD00
               DFB Frq
               DFW HD00
HIGH1L         DFB 50,2,53,8,50,2
               DFB 58,3,57,1,55,2
               DFB 51,14
               DFB 57,2,57,4,55,2
               DFB 53,3,55,1,53,2,51,2
               DFB 50,2,46,8
               DFB 46,2,48,2,49,2
               DFB 50,2,53,8,50,2
               DFB 58,3,57,1,55,2
               DFB 51,14
               DFB 57,2,57,4,55,2
               DFB 53,2,48,4,51,2
               DFB 50,16
               DFB Jmp
               DFW HIGH1L
 ;
HIGH2          DFB Load,68,15
               DFW TIME
               DFB Load,28,28
               DFW AD20
HIGH2L         DFB For,2
               DFB 34,2,38,2,29,2,38,2
               DFB Next
               DFB 39,2,46,2,34,2,46,2
               DFB 39,2,36,2,34,2,31,2
               DFB 41,2,48,2,29,2,48,2
               DFB 41,2,48,2,36,2,48,2
               DFB For,4
               DFB 34,2,38,2,29,2,38,2
               DFB Next
               DFB 39,2,46,2,34,2,46,2
               DFB 39,2,36,2,34,2,31,2
               DFB 41,2,48,2,29,2,48,2
               DFB 41,2,48,2,36,2,48,2
               DFB 34,2,38,2,29,2,38,2
               DFB 34,2,29,2,31,2,33,2
               DFB Jmp
               DFW HIGH2L
 ;
 ;=========TITLE MUSIC============
 ;
DATA0          EQU .
TD00           DFB 0,7,3,12
               DFS 6,0
               DFB 0,3,0,13
               DFB 255,0,5,4
               DFW +10,0,$700
TV00           DFB 65,$05,$B9,4,50
TD01           DFW +20,-20,+20,0
               DFB 3,6,3,0,10,5
               DFB 80,80,9,0
               DFW +20,-20,$880
TF00           DFW 0,-100,0,0
               DFB 10,10,0,0,1,133
MINER2         DFB 0,8,5,12
RMAJER         DFB 0,7,4,12
MAJER1         DFB 0,8,3,12
MAJER2         DFB 0,9,5,12
BEND00         DFW -10,0,0,0
               DFB 9,0,0,0,3,4
C              EQU 3
TIMC           DFB 1*C,2*C,3*C,4*C ;C=3
               DFB 5*C,6*C,7*C,8*C
               DFB 9*C,10*C,11*C,12*C
               DFB 13*C,14*C,15*C,16*C
TS01           DFB Moke,VSRV,$F9
               DFB 0,4
               DFB Moke,VSRV,$B9
               DFB 0,2,0,2
               DFB 12,2,0,4,0,2,Ret
TS02           DFB CT,34
               DFW TS00
               DFB Rst,1
               DFB CT,38
               DFW TS00
               DFB Rst,1
               DFB CT,32
               DFW TS00
               DFB Rst,1
               DFB CT,39
               DFW TS00
               DFB Rst,1
TS02a          DFB CT,34
               DFW TS00
               DFB Rst,1
               DFB CT,38
               DFW TS00
               DFB Rst,1
               DFB CT,32
               DFW TS00
               DFB Tsp,39
               DFB Rst,1
TS00           DFB For,3
               DFB Call
               DFW TS01
               DFB Next
TS00a          DFB Moke,VSRV,$F9
               DFB 0,4
               DFB Moke,VSRV,$B9
               DFB 0,2,0,2
               DFB Moke,VSRV,$F9
               DFB 12,2
               DFB Moke,VSRV,$B9
               DFB 0,2
               DFB Moke,VSRV,$F9
               DFB 10,2,12,1
               DFB Ret
 ;
TITL0          DFB Load,28,28
               DFW TD00
               DFB Chrd
               DFW MINER2
               DFB Rst,4
               DFB For,2
               DFB CT,55
               DFW TS20
               DFB Call
               DFW TS20
               DFB CT,50
               DFW TS20
               DFB Call
               DFW TS20
               DFB Next
               DFB Chrd
               DFW RMAJER
               DFB For,2
               DFB CT,50
               DFW TS20
               DFB Call
               DFW TS20
               DFB Chrd
               DFW MINER2
               DFB Next
               DFB Moke,FMC,0
               DFB Rst+R,1
               DFB For,3
               DFB CT,31
               DFW TS00
               DFB Rst,1
               DFB Call
               DFW TS00
               DFB Rst,1
               DFB CT,29
               DFW TS00
               DFB Rst,1
               DFB CT,30
               DFW TS01
               DFB Call
               DFW TS01
               DFB CT,26
               DFW TS01
               DFB Call
               DFW TS00a
               DFB Rst,1
               DFB Next
               DFB CT,31
               DFW TS00
               DFB Rst,1
               DFB Call
               DFW TS00
               DFB Rst,1
               DFB Call
               DFW TS02a
               DFB Load,28,14
               DFW TP10
               DFB Rst,1
               DFB Call
               DFW TS02
               DFB Rst,1
               DFB Call
               DFW TS02
               DFB Tsp,+0
               DFB Moke,VSRV,$AD
               DFB Moke,VADSD,50
               DFB Frq
               DFW TF00
               DFB Rst+R,1
X0             DFB 34+R,64*C
               DFB For,8
               DFB Soke,VRD,255
               DFB Rst+R,64*C
               DFB Next
               DFB Rst+R,61*C
               DFB Jmp
               DFW TITL0
 ;
DATA1          EQU .
DRUM           DFB 9,0,1,2,3,4,5,6,7,8
               DFB 0,9,0,13
               DFS 8,0
               DFW $800
               DFB 65,$03,$78,5,18
BEND10         DFW +50,-50,+50,+32
               DFB 3,6,3,0,48*C,7
               DFB 48,48,0,5
               DFW +30,-30,$820
               DFB 65,$DD,$FD,255,255
TD10           DFW +40,-40,+40,0
               DFB 3,6,3,0,20,7
               DFB 80,80,9,5
               DFW +20,-20,$880
               DFB 73,$DD,$DB,30,200
TP10           DFB 10,255,0,5
               DFW +200,-20,$400
               DFB 65,0,$D9,5,255
BEND11         DFW +50,-50,+50,+32
               DFB 3,6,3,0,48*C,7
TS10           DFB Moke,FMG3
               DFL +51
               DFB 46+R,64*C ;end on 50
               DFB Moke,FMG3
               DFL +35
               DFB 45+R,64*C ;end on 48
               DFB Moke,FMG3
               DFL +32
               DFB 38+R,32*C ;end on 42
               DFB Moke,FMG3
               DFL +27
               DFB Moke,VADSD,20
               DFB 48,16 ;    end on 50
               DFB Moke,FMG3
               DFL +0
               DFB 48+R,16*C-1 ;d on 48
               DFB Moke,FMG3
               DFL +41
               DFB Moke,VADSD,30
               DFB Rst+R,1
               DFB 38+R,64*C ;end on 43
               DFB Ret
TS12           DFB Chrd
               DFW MAJER2
               DFB CT,53
               DFW TS11
TS12a          DFB Chrd
               DFW MINER2
               DFB CT,57
               DFW TS11
               DFB Chrd
               DFW RMAJER
               DFB CT,56
               DFW TS11
               DFB Chrd
               DFW MAJER1
               DFB Tsp,55
TS11           DFB Moke,VSRV,$F9
               DFB 0,2
               DFB Moke,VSRV,$B9
               DFB For,3,0,2,Next
               DFB 0,4,0,2
               DFB 0,4,0,2,0,2,0,2
               DFB For,4,0,1,Next
               DFB 0,4
               DFB Moke,VSRV,$F9
               DFB 0,4
               DFB Moke,VSRV,$B9
               DFB For,5,0,2,Next
               DFB 0,4,0,2,0,2,0,2
               DFB 0,4
               DFB 0,1,0,1,Rst,2
               DFB Ret
TS13           DFB BD,8,SN,8,BD,8,SN,8
               DFB BD,8,SN,8
               DFB BD,6,BD,2,SN,4,BD,4
TS13a          DFB BD,8,SN,8,BD,8,SN,8
               DFB BD,8,SN,8
               DFB SN,2,SN,2,SN,4
               DFB SN,2,SN,2,SN,2,SN,2
               DFB Ret
TS15           DFB BD,16,BD,16,BD,16
               DFB BD,8,SN,8
               DFB Ret
TS16           DFB BD,16,BD,16,BD,16
               DFB SN,4,SN,6,SN,6
               DFB Ret
TS17           DFB SN,6,SN,4
               DFB BD,4,SN,4
               DFB TH,6,TH,4
               DFB TH,4,SN,6
               DFB SN,4,BD,4
               DFB SN,4,TL,6
               DFB TL,4,TL,4
               DFB Ret
TS18           DFB SN,5,SN,2,SN,5,SN,4
               DFB TH,4,SN,2,SN,2
               DFB TH,2,TH,2,SN,2,TH,2
               DFB BD,4,BD,6,BD,6,BD,2
               DFB BD,2,BD,2,BD,2,SN,4
               DFB Ret
 ;
TITL1          DFB Load,28,28
               DFW TD20
               DFB 19,2,22,2,24+R,58*C
               DFB Moke,FMG3
               DFL +6
               DFB Moke,FMG3+1
               DFH +6
               DFB Moke,FMC,7,21+R,11
               DFB Soke,FBG
               DFL 978
               DFB Soke,FBG+1
               DFH 978
               DFB Rst+R,7
               DFB Frq
               DFW BEND00
               DFB Moke,VADSD,12
               DFB Moke,VRD,2
               DFB Rst+R,1
               DFB 19+R,60*C
               DFB Frq
               DFW TD20
               DFB Moke,VADSD,255
               DFB Moke,VRD,20
               DFB 19,2,22,2,24+R,32*C
               DFB Moke,FMC,7,33,16
               DFB Moke,FMC,5,33,16
               DFB Moke,VADSD,12
               DFB Moke,VRD,2,22+R,60*C
               DFB Moke,VADSD,255
               DFB Moke,VRD,20
               DFB 42,2,40,2,38+R,32*C
               DFB 33,16,30+R,16*C-1
               DFB Moke,VADSD,12
               DFB Moke,VRD,2
               DFB Rst+R,1
               DFB 31+R,16*C-1
               DFB Load,28,28
               DFW BEND10
               DFB Rst+R,1
               DFB 2+R,48*C-1
               DFB Soke,VADSD,255
               DFB Soke,FCURR
               DFL 4927
               DFB Soke,FCURR+1
               DFH 4927
               DFB Rst+R,0,Rst+R,225
               DFB Soke,VRD,255
               DFB Load,28,28
               DFW TD10
               DFB Moke,PMDLY,40
               DFB Rst+R,80*C,Rst,8
               DFB 43+R,72*3
               DFB Call
               DFW TS10
               DFB Call
               DFW TS10
               DFB Rst+R,32*C
               DFB Load,28,14
               DFW TP10
               DFB Moke,FMC,0
               DFB 31,4,43,2,43,4,31,4
               DFB 31,4,43,4,31,2
               DFB 42,2,43,2,44,2,45,1
               DFB Frq
               DFW TD00
               DFB Vlm
               DFW TV00
               DFB Moke,PMC,0
               DFB Rst,1
               DFB Call
               DFW TS12
               DFB Call
               DFW TS12
               DFB Rst,2
               DFB Load,28,28
               DFW TD21
               DFB CT,0
               DFW TS24
               DFB Rst+R,22*C
               DFB 63,12
               DFB Soke,FBG
               DFL -49
               DFB Soke,FBG+1
               DFH -49
               DFB Soke,FBD,12
               DFB Soke,FMC,7
               DFB Rst,4
X1             DFB Rst+R,64*C
               DFB Frq
               DFW TD00
               DFB Vlm
               DFW TV00
               DFB Moke,PMC,0
               DFB Moke,PINIT+1,4
               DFB Call
               DFW TS12a
               DFB Load,28,28
               DFW DRUM
               DFB For,3
               DFB CT,0
               DFW TS13
               DFB Next
               DFB Call
               DFW TS15
               DFB Call
               DFW TS16
               DFB Call
               DFW TS15
               DFB Call
               DFW TS17
               DFB Call
               DFW TS15
               DFB Call
               DFW TS16
               DFB Call
               DFW TS15
               DFB Call
               DFW TS18
               DFB Rst+R,1
               DFB Jmp
               DFW TITL1
 ;
DATA2          EQU .
TD20           DFW +30,-30,+30,+11
               DFB 3,6,3,0,11,5
               DFB 10,10,5,5
               DFW +15,-10,$700
TV20           DFB 65,$03,$C9,255,20
TD21           DFW +70,-70,+70,-90
               DFB 3,6,3,0,20,5
               DFB 11,255,1,5
               DFW +200,-5,$000
TV21           DFB 65,$09,$EB,120,100
TV22           DFB 73,$09,$E7,8,10
BEND20         DFW -20,0,0,0
               DFB 9,0,0,0,3,4
BEND21         DFW +20,-20,+20,-412
               DFB 3,6,3,0,48*C+7,7
               DFB 48,48,0,5
               DFW +30,-30,$820
               DFB 65,$DD,$FD,255,255
TS21           DFB Rst,1
               DFB Moke,FMG3,+41
               DFB 43+R,63*C ;end on 46
               DFB Moke,FMG3,+51
               DFB 41+R,64*C ;end on 45
               DFB Moke,FMG3,+39
               DFB 42+R,32*C ;end on 45
               DFB Moke,FMG3,+15
               DFB Moke,VADSD,20
               DFB 45,16 ;    end on 46
               DFB Moke,FMG3,+0
               DFB 45+R,16*C-1 ;d on 45
               DFB Moke,FMG3,+41
               DFB Moke,VADSD,30
               DFB Rst+R,1
               DFB 43+R,64*C ;end on 46
               DFB Ret
TS22           DFB Chrd
               DFW MAJER2
               DFB CT,53
               DFW TS20
               DFB Call
               DFW TS20
               DFB Chrd
               DFW MINER2
               DFB CT,57
               DFW TS20
               DFB Call
               DFW TS20
               DFB Chrd
               DFW RMAJER
               DFB CT,56
               DFW TS20
               DFB Call
               DFW TS20
               DFB Chrd
               DFW MAJER1
               DFB CT,55
               DFW TS20
TS20           DFB Moke,VSRV,$E9,0,2
               DFB Moke,VSRV,$B9
               DFB For,4,0,2,Next,0,4
               DFB 0,2,Moke,VSRV,$E9,0,4
               DFB Moke,VSRV,$B9
               DFB 0,4,0,2,0,2,0,4,Ret
TS23           DFB Rst+R,1
               DFB 58+R,16*C,62,16
               DFB 65,16,70,16
               DFB 69+R,20*C,65,4,62,4
               DFB 58,4,57+R,32*C
               DFB 56,8,60,8,63,8,60,8
               DFB 68,16,68+R,16
               DFB 70+R,16,72+R,16
               DFB 67+R,20*C,65,4,63,4
               DFB 62,4
               DFB 60,12,62,2,60,2
               DFB 58,2
               DFB Ret
TS24           DFB 65+R,32*C
               DFB 70,8,65,8,63,8
               DFB Moke,FMDLY,12*C
               DFB 62,4
               DFB Soke,FMC,7
               DFB Rst,4
               DFB Soke,FBG
               DFL +90
               DFB Soke,FBG+1
               DFH +90
               DFB Moke,FMDLY,20
               DFB Moke,FMC,5
               DFB Rst+R,28*C
               DFB 62+R,4,63+R,4
               DFB 62+R,4,60+R,32*C
               DFB Vlm
               DFW TV22
               DFB 56+R,16,51+R,16
               DFB 56+R,16
               DFB 60+R,16,63+R,16
               DFB 67+R,16,68,16
               DFB 72+R,16,70+R,16
               DFB 68+R,16
               DFB Vlm
               DFW TV21
               DFB 72+R,24*C
               DFB Soke,FBG
               DFL -72
               DFB Soke,FBG+1
               DFH -72
               DFB Soke,FBD,24
               DFB Soke,FMC,7
               DFB Ret
TS25           DFB Rst,8,SN,16,SN,16
               DFB SN,14,BD,6,BD,4
               DFB Ret
TS26           DFB Rst,8,SN,16,SN,16
               DFB SN,10,SN,6,SN,4
               DFB SN,4,Ret
TS27           DFB Rst,2
               DFB SN,6,SN,4
               DFB SN,4,TH,6
               DFB TH,4,BD,4
               DFB TH,4,SN,6
               DFB SN,4,SN,4
               DFB TL,6,TL,4
               DFB BD,4,TL,2
               DFB Ret
TS28           DFB Rst,4
               DFB SN,2,SN,2,SN,2,SN,4
               DFB SN,4,TH,3,TH,2,TH,2
               DFB TH,2,TH,2,SN,2,TH,3
               DFB BD,4,BD,8,BD,3,BD,2
               DFB BD,2,BD,2,BD,5
               DFB Ret
 ;
TITL2          DFB Load,68,15
               DFW TIMC
TITL2L         DFB Load,28,28
               DFW TD20
               DFB 31,2,34,2,36+R,58*C
               DFB Moke,FMC,7
               DFB 33,5
               DFB Frq
               DFW BEND20
               DFB Moke,VADSD,12
               DFB Moke,VRD,2
               DFB Rst,1
               DFB 31+R,60*C
               DFB Frq
               DFW TD20
               DFB Moke,VADSD,255
               DFB Moke,VRD,20
               DFB 31,2,34,2,36+R,32*C
               DFB Moke,FMG3
               DFL +22
               DFB Moke,FMC,7,45,16
               DFB Moke,FMC,5,45,16
               DFB Moke,VADSD,12
               DFB Moke,VRD,2
               DFB 34+R,60*C
               DFB Moke,VADSD,255
               DFB Moke,VRD,20
               DFB 45,2,43,2,42+R,32*C
               DFB 38,16,36+R,16*C
               DFB Moke,VADSD,12
               DFB Moke,VRD,2
               DFB 34+R,16*C
               DFB Load,28,28
               DFW BEND21
               DFB 94+R,1
               DFB Soke,FCURR
               DFL 62204
               DFB Soke,FCURR+1
               DFH 62204
               DFB Rst+R,48*C-1
               DFB Soke,FMC,5
               DFB Soke,VADSD,255
               DFB Rst+R,0,Rst+R,224
               DFB Soke,VRD,255
               DFB Load,28,28
               DFW TD10
               DFB Moke,FMDLY,15
               DFB Rst+R,80*C,Rst,8
 ;
               DFB 46+R,72*C
               DFB Call
               DFW TS21
               DFB Call
               DFW TS21
               DFB Load,28,28
               DFW DRUM
               DFB Rst+R,32*C
               DFB For,4,BD,2,Next
               DFB SN,2,BD,1,BD,1,BD,2
               DFB BD,2,SN,4,SN,2,SN,4
               DFB SN,2,SN,4
               DFB Load,28,28
               DFW TD21
               DFB Call
               DFW TS23
               DFB Rst,14
               DFB Call
               DFW TS23
               DFB Rst,8
               DFB 60,2,62,2,63,2
               DFB Call
               DFW TS24
               DFB Rst+R,24*C
               DFB 67,12
               DFB Soke,FBG
               DFL -120
               DFB Soke,FBG+1
               DFH -120
               DFB Soke,FBD,12
               DFB Soke,FMC,7
               DFB Load,28,28
               DFW TD00
               DFB Rst+R,4*C-1
               DFB Call
               DFW TS22
               DFB Call
               DFW TS22
               DFB Load,28,14
               DFW TP10
               DFB Moke,VSRV,$AD
               DFB Moke,VADSD,50
               DFB Frq
               DFW TF00
               DFB Tsp,+0
X2             DFB 38+R,64*C
               DFB Soke,VRD,255
               DFB Load,28,28
               DFW DRUM
               DFB Rst+R,64*C
               DFB Call
               DFW TS25
               DFB Call
               DFW TS26
               DFB Call
               DFW TS25
               DFB Call
               DFW TS27
               DFB Call
               DFW TS25
               DFB Call
               DFW TS26
               DFB Call
               DFW TS25
               DFB Call
               DFW TS28
               DFB Rst+R,1
               DFB Jmp
               DFW TITL2L
DE             EQU .
 ;
 ;================================
 ;
               ORG $1000 ;\
START          JSR setscreen
               JSR FULLRESET
               LDX #15
               STX $D418
 ; LDX #00:STX RF
 ; LDA #55:STA $427
 ;I JSR fast:DEC $427:BNE I
               LDX #7
               STX RF
 ;
DLoop          SEI 
               LDA #59
               LDX #160
raster1        CMP $D012
               BNE raster1
 ;rasterd2 CPX $D012:BNE rasterd2
 ;rasterd3 CMP $D012:BNE rasterd3
               JSR DREFRESH
               JSR $EA87
               JSR $F13E
               BEQ nk
               CMP #3
               BEQ STOP
               CMP #32
               BEQ START
cf0            CMP #13
               BNE cf1
               INC RF
               JMP nk
cf1            CMP #&Z+1
               BCC cf2
               JSR fast
               JMP nk
cf2            CMP #&A
               BCC nk
               ASL 
               TAY 
               LDA DVTAB-&A-&A,Y 
               STA DVEC+1
               LDA DVTAB-&A-&A+1,Y 
               STA DVEC+2
               DEC BDR
DVEC           JSR $FFFF
               INC BDR
nk             JSR show
               JMP DLoop
 ;
STOP           JSR FULLRESET
cls            LDX #0
               LDA #32
cls1           STA $400,X 
               STA $500,X 
               STA $580,X 
               DEX 
               BNE cls1
               RTS 
 ;
DVTAB          DFW title
               DFW gametune1
               DFW gametune3
               DFW challenge
               DFW highscore
               DFW gameover
               DFW missionac
               DFW lostalife
               DFW gamestart
               DFW truckoff
               DFW FULLRESET
               DFW MUSICTEST
               DFW autogyron
               DFW dogbarkin
               DFW flamethro
               DFW truckon
               DFW comlevel1
               DFW comlevel2
               DFW comlevel3
               DFW jet
               DFW kill
               DFW gun
               DFW explosion
               DFW fast
               DFW fast
               DFW fast
 ;
DREFRESH       LDA #1
               STA BDR
               JSR MUSIC2
               LDA #12
               STA BDR
               JSR MUSIC1
               LDA #11
               STA BDR
               JSR MUSIC0
 ; LDA #2:STA BDR
 ; LDA #58+ALLOWANCE
 ; CMP $D012:BCC tooslow
 ;rasterd2 CMP $D012:BCS rasterd2
               LDA #0
               STA BDR
tooslow        LDA #150
rasterd3       CMP $D012
               BNE rasterd3
               LDA #1
               STA BDR
               JSR SOUND2
               LDA #12
               STA BDR
               JSR SOUND1
               LDA #11
               STA BDR
               JSR SOUND0
               LDA #0
               STA BDR
               RTS 
 ;
fast           JSR f1
f1             JSR f2
f2             JSR f3
f3             JSR f4
f4             JSR f5
f5             JSR f6
f6             JSR f7
f7             JSR MUSIC2
               JSR MUSIC1
               JSR MUSIC0
               JSR SOUND2
               JSR SOUND1
               JMP SOUND0
 ;
setscreen      JSR cls
               LDX #29+16+8+8+7
s2             LDA #12
               STA $D850,X 
               LDA #15
               STA $D8C8,X 
               LDA #1
               STA $D940,X 
               DEX 
               BPL s2
               LDX #38
s3             LDA #12
               STA $D9B8,X 
               LDA #15
               STA $DA08,X 
               LDA #1
               STA $DA58,X 
               DEX 
               BPL s3
               LDA #255
               STA 650
               RTS 
 ;
show           EQU .
               LDX #31
d1             LDA A0,X 
               STA $400,X 
               DEX 
               BPL d1
               LDX #29+8+8+8-1
d2             LDA D0,X 
               STA $450,X 
               LDA D1,X 
               STA $4C8,X 
               LDA D2,X 
               STA $540,X 
               DEX 
               BPL d2
               LDX #16-1
d2a            LDA IDR,X 
               STA $575,X 
               DEX 
               BPL d2a
               LDX #38
d3             LDA S0,X 
               STA $5B8,X 
               LDA S1,X 
               STA $608,X 
               LDA S2,X 
               STA $658,X 
               DEX 
               BPL d3
               LDA RF
               LDX #2
inc1           LSR  A
               PHA 
               BCC NO
               LDA #&Y
               DFB $2C
NO             LDA #&N
               STA $421,X 
               PLA 
               DEX 
               BPL inc1
               RTS 
 ;
PE             EQU .
               DFC "END"
               DFW START ;\
 ; DFC "END":DFW $C000;\

