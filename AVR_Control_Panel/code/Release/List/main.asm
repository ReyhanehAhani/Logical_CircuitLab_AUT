
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Release
;Chip type              : ATmega16A
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16A
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _menu_number=R5
	.DEF _old_menu_number=R4
	.DEF _i=R7
	.DEF _n=R6
	.DEF _pass=R9
	.DEF _task=R8
	.DEF _loop_count=R10
	.DEF _loop_count_msb=R11
	.DEF _task_run=R12
	.DEF _task_run_msb=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext_int0_isr
	JMP  _ext_int1_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_PASSWORD:
	.DB  0x31,0x32,0x33,0x34
_digits:
	.DB  0x3F,0x6,0x5B,0x4F,0x66,0x6D,0x7D,0x7
	.DB  0x7F,0x67

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x4,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x0:
	.DB  0x45,0x6E,0x74,0x65,0x72,0x20,0x70,0x61
	.DB  0x73,0x73,0x77,0x72,0x6F,0x64,0x3A,0x20
	.DB  0x0,0x49,0x4E,0x43,0x4F,0x52,0x52,0x45
	.DB  0x43,0x54,0x20,0x50,0x41,0x53,0x53,0x57
	.DB  0x4F,0x52,0x44,0x0,0x43,0x6F,0x72,0x72
	.DB  0x65,0x63,0x74,0x20,0x50,0x61,0x73,0x73
	.DB  0x77,0x6F,0x72,0x64,0x0,0x31,0x29,0x4C
	.DB  0x45,0x44,0x3C,0x3D,0xA,0x32,0x29,0x42
	.DB  0x75,0x7A,0x7A,0x65,0x72,0x0,0x31,0x29
	.DB  0x4C,0x45,0x44,0xA,0x32,0x29,0x42,0x75
	.DB  0x7A,0x7A,0x65,0x72,0x3C,0x3D,0x0,0x33
	.DB  0x29,0x52,0x65,0x6C,0x61,0x79,0x3C,0x3D
	.DB  0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x11
	.DW  _0xC
	.DW  _0x0*2

	.DW  0x13
	.DW  _0xC+17
	.DW  _0x0*2+17

	.DW  0x11
	.DW  _0xC+36
	.DW  _0x0*2+36

	.DW  0x11
	.DW  _0xC+53
	.DW  _0x0*2+53

	.DW  0x11
	.DW  _0xC+70
	.DW  _0x0*2+70

	.DW  0x0A
	.DW  _0xC+87
	.DW  _0x0*2+87

	.DW  0x11
	.DW  _0x7D
	.DW  _0x0*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;#include <mega16a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <alcd.h>
;#include <delay.h>
;
;const char PASSWORD[] = { '1', '2', '3', '4' };
;const unsigned char digits[] = { 0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67 };
;
;char get_key();
;unsigned char verify_password();
;
;unsigned char menu_number = 0, old_menu_number = 4, i = 0, n = 0, pass = 0, task = 0;
;unsigned int loop_count = 0, task_run = 0;
;bit t = 0, logged_in = 0;
;
;interrupt[EXT_INT0] void ext_int0_isr(void)
; 0000 0010 {

	.CSEG
_ext_int0_isr:
; .FSTART _ext_int0_isr
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 0011 	if (logged_in == 0)
	SBRS R2,1
; 0000 0012 		return;
	RJMP _0x84
; 0000 0013 
; 0000 0014 	n++;
	INC  R6
; 0000 0015 	if (n > 99)
	LDI  R30,LOW(99)
	CP   R30,R6
	BRSH _0x4
; 0000 0016 		n = 0;
	CLR  R6
; 0000 0017 }
_0x4:
	RJMP _0x84
; .FEND
;
;interrupt[EXT_INT1] void ext_int1_isr(void)
; 0000 001A {
_ext_int1_isr:
; .FSTART _ext_int1_isr
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 001B 	if (logged_in == 0)
	SBRS R2,1
; 0000 001C 		return;
	RJMP _0x84
; 0000 001D 
; 0000 001E 	n--;
	DEC  R6
; 0000 001F 	if (n > 99)
	LDI  R30,LOW(99)
	CP   R30,R6
	BRSH _0x6
; 0000 0020 		n = 0;
	CLR  R6
; 0000 0021 }
_0x6:
_0x84:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	RETI
; .FEND
;
;void main(void)
; 0000 0024 {
_main:
; .FSTART _main
; 0000 0025 	DDRC = 0x0F;
	LDI  R30,LOW(15)
	OUT  0x14,R30
; 0000 0026 	PORTC = 0b11110000;
	LDI  R30,LOW(240)
	OUT  0x15,R30
; 0000 0027 
; 0000 0028 	DDRD = 0b01110000;
	LDI  R30,LOW(112)
	OUT  0x11,R30
; 0000 0029 	PORTD = 0b00000011;
	LDI  R30,LOW(3)
	OUT  0x12,R30
; 0000 002A 
; 0000 002B 	DDRA = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 002C 	DDRB.3 = 1;
	SBI  0x17,3
; 0000 002D 
; 0000 002E     //INT
; 0000 002F 	GICR |= (1 << INT1) | (1 << INT0) | (0 << INT2);
	IN   R30,0x3B
	ORI  R30,LOW(0xC0)
	OUT  0x3B,R30
; 0000 0030 	MCUCR = (1 << ISC11) | (1 << ISC10) | (1 << ISC01) | (0 << ISC00);
	LDI  R30,LOW(14)
	OUT  0x35,R30
; 0000 0031 	MCUCSR = (0 << ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 0032 	GIFR = (1 << INTF1) | (1 << INTF0) | (0 << INTF2);
	LDI  R30,LOW(192)
	OUT  0x3A,R30
; 0000 0033 	#asm("sei")
	sei
; 0000 0034 
; 0000 0035 	lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 0036 
; 0000 0037 	while (1)
_0x9:
; 0000 0038 	{
; 0000 0039         lcd_clear();
	RCALL _lcd_clear
; 0000 003A 		lcd_puts("Enter passwrod: ");
	__POINTW2MN _0xC,0
	RCALL _lcd_puts
; 0000 003B 
; 0000 003C         pass = verify_password();
	RCALL _verify_password
	MOV  R9,R30
; 0000 003D 
; 0000 003E         if(pass == 1)
	LDI  R30,LOW(1)
	CP   R30,R9
	BREQ _0xB
; 0000 003F             break;
; 0000 0040 
; 0000 0041 		if (pass == 0)
	TST  R9
	BRNE _0xE
; 0000 0042 		{
; 0000 0043 			lcd_clear();
	RCALL _lcd_clear
; 0000 0044 			lcd_puts("INCORRECT PASSWORD");
	__POINTW2MN _0xC,17
	RCALL SUBOPT_0x0
; 0000 0045 			delay_ms(300);
; 0000 0046 		}
; 0000 0047 	}
_0xE:
	RJMP _0x9
_0xB:
; 0000 0048 
; 0000 0049 	lcd_clear();
	RCALL _lcd_clear
; 0000 004A 	lcd_puts("Correct Password");
	__POINTW2MN _0xC,36
	RCALL SUBOPT_0x0
; 0000 004B 	delay_ms(300);
; 0000 004C 	lcd_clear();
	RCALL _lcd_clear
; 0000 004D 
; 0000 004E 	logged_in = 1;
	SET
	BLD  R2,1
; 0000 004F 	menu_number = 1;
	LDI  R30,LOW(1)
	MOV  R5,R30
; 0000 0050 
; 0000 0051 	while (1)
_0xF:
; 0000 0052 	{
; 0000 0053 		if (t == 0)
	SBRC R2,0
	RJMP _0x12
; 0000 0054 		{
; 0000 0055 			PORTA = digits[n / 10];
	MOV  R26,R6
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	SUBI R30,LOW(-_digits*2)
	SBCI R31,HIGH(-_digits*2)
	LPM  R0,Z
	OUT  0x1B,R0
; 0000 0056 			t = 1;
	SET
	BLD  R2,0
; 0000 0057 			PORTA.7 = 0;
	CBI  0x1B,7
; 0000 0058 			PORTB.3 = 1;
	SBI  0x18,3
; 0000 0059 		}
; 0000 005A 		else if (t == 1)
	RJMP _0x17
_0x12:
	SBRS R2,0
	RJMP _0x18
; 0000 005B 		{
; 0000 005C 			PORTA = digits[n % 10];
	MOV  R26,R6
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
	SUBI R30,LOW(-_digits*2)
	SBCI R31,HIGH(-_digits*2)
	LPM  R0,Z
	OUT  0x1B,R0
; 0000 005D 			t = 0;
	CLT
	BLD  R2,0
; 0000 005E 			PORTA.7 = 1;
	SBI  0x1B,7
; 0000 005F 			PORTB.3 = 0;
	CBI  0x18,3
; 0000 0060 		}
; 0000 0061 
; 0000 0062 		if (old_menu_number != menu_number)
_0x18:
_0x17:
	CP   R5,R4
	BREQ _0x1D
; 0000 0063 		{
; 0000 0064 			old_menu_number = menu_number;
	MOV  R4,R5
; 0000 0065 			switch (menu_number)
	MOV  R30,R5
	LDI  R31,0
; 0000 0066 			{
; 0000 0067 				case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x21
; 0000 0068 					lcd_clear();
	RCALL _lcd_clear
; 0000 0069 					lcd_puts("1)LED<=\n2)Buzzer");
	__POINTW2MN _0xC,53
	RJMP _0x83
; 0000 006A 					break;
; 0000 006B 				case 2:
_0x21:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x22
; 0000 006C 					lcd_clear();
	RCALL _lcd_clear
; 0000 006D 					lcd_puts("1)LED\n2)Buzzer<=");
	__POINTW2MN _0xC,70
	RJMP _0x83
; 0000 006E 					break;
; 0000 006F 				case 3:
_0x22:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x20
; 0000 0070 					lcd_clear();
	RCALL _lcd_clear
; 0000 0071 					lcd_puts("3)Relay<=");
	__POINTW2MN _0xC,87
_0x83:
	RCALL _lcd_puts
; 0000 0072 					break;
; 0000 0073 			}
_0x20:
; 0000 0074 		}
; 0000 0075 
; 0000 0076 		if (PIND.0 == 0 && (loop_count % 15 == 0))
_0x1D:
	SBIC 0x10,0
	RJMP _0x25
	RCALL SUBOPT_0x1
	BREQ _0x26
_0x25:
	RJMP _0x24
_0x26:
; 0000 0077 		{
; 0000 0078 			menu_number++;
	INC  R5
; 0000 0079 			if (menu_number > 3)
	LDI  R30,LOW(3)
	CP   R30,R5
	BRSH _0x27
; 0000 007A 			{
; 0000 007B 				menu_number = 1;
	LDI  R30,LOW(1)
	MOV  R5,R30
; 0000 007C 			}
; 0000 007D 		}
_0x27:
; 0000 007E 
; 0000 007F 		if (PIND.1 == 0 && (loop_count % 15 == 0) && task == 0)
_0x24:
	SBIC 0x10,1
	RJMP _0x29
	RCALL SUBOPT_0x1
	BRNE _0x29
	TST  R8
	BREQ _0x2A
_0x29:
	RJMP _0x28
_0x2A:
; 0000 0080 		{
; 0000 0081 			old_menu_number = 4;
	LDI  R30,LOW(4)
	MOV  R4,R30
; 0000 0082 			task = menu_number;
	MOV  R8,R5
; 0000 0083 		}
; 0000 0084 
; 0000 0085 		if (PIND.7 == 1  && (loop_count % 15 == 0))
_0x28:
	SBIS 0x10,7
	RJMP _0x2C
	RCALL SUBOPT_0x1
	BREQ _0x2D
_0x2C:
	RJMP _0x2B
_0x2D:
; 0000 0086 		{
; 0000 0087 			n++;
	INC  R6
; 0000 0088 			if (n > 99)
	LDI  R30,LOW(99)
	CP   R30,R6
	BRSH _0x2E
; 0000 0089 				n = 0;
	CLR  R6
; 0000 008A 		}
_0x2E:
; 0000 008B 
; 0000 008C         if(task != 0)
_0x2B:
	TST  R8
	BREQ _0x2F
; 0000 008D         {
; 0000 008E             task_run++;
	MOVW R30,R12
	ADIW R30,1
	MOVW R12,R30
; 0000 008F             switch (task)
	MOV  R30,R8
	LDI  R31,0
; 0000 0090             {
; 0000 0091                 case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x33
; 0000 0092                     PORTD.4 = 1;
	SBI  0x12,4
; 0000 0093                 case 2:
	RJMP _0x36
_0x33:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x37
_0x36:
; 0000 0094                     PORTD.5 = 1;
	SBI  0x12,5
; 0000 0095                 case 3:
	RJMP _0x3A
_0x37:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x32
_0x3A:
; 0000 0096                     PORTD.6 = 1;
	SBI  0x12,6
; 0000 0097             }
_0x32:
; 0000 0098 
; 0000 0099             if(task_run == 40)
	LDI  R30,LOW(40)
	LDI  R31,HIGH(40)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x3E
; 0000 009A             {
; 0000 009B                 task_run = 0;
	CLR  R12
	CLR  R13
; 0000 009C                 task = 0;
	CLR  R8
; 0000 009D                 PORTD.4 = 0;
	CBI  0x12,4
; 0000 009E                 PORTD.5 = 0;
	CBI  0x12,5
; 0000 009F                 PORTD.6 = 0;
	CBI  0x12,6
; 0000 00A0             }
; 0000 00A1         }
_0x3E:
; 0000 00A2 
; 0000 00A3 		loop_count++;
_0x2F:
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
; 0000 00A4         delay_ms(25);
	LDI  R26,LOW(25)
	LDI  R27,0
	CALL _delay_ms
; 0000 00A5 
; 0000 00A6 	}
	RJMP _0xF
; 0000 00A7 }
_0x45:
	RJMP _0x45
; .FEND

	.DSEG
_0xC:
	.BYTE 0x61
;
;char get_key(void)
; 0000 00AA {

	.CSEG
_get_key:
; .FSTART _get_key
; 0000 00AB 	while (1)
_0x46:
; 0000 00AC 	{
; 0000 00AD 		PORTC.0 = 0;
	CBI  0x15,0
; 0000 00AE 		PORTC.1 = 1;
	SBI  0x15,1
; 0000 00AF 		PORTC.2 = 1;
	SBI  0x15,2
; 0000 00B0 		PORTC.3 = 1;
	SBI  0x15,3
; 0000 00B1 		if (PINC.4 == 0)
	SBIC 0x13,4
	RJMP _0x51
; 0000 00B2 		{
; 0000 00B3 			return '1';
	LDI  R30,LOW(49)
	RET
; 0000 00B4 		}
; 0000 00B5 
; 0000 00B6 		if (PINC.5 == 0)
_0x51:
	SBIC 0x13,5
	RJMP _0x52
; 0000 00B7 		{
; 0000 00B8 			return '2';
	LDI  R30,LOW(50)
	RET
; 0000 00B9 		}
; 0000 00BA 
; 0000 00BB 		if (PINC.6 == 0)
_0x52:
	SBIC 0x13,6
	RJMP _0x53
; 0000 00BC 		{
; 0000 00BD 			return '3';
	LDI  R30,LOW(51)
	RET
; 0000 00BE 		}
; 0000 00BF 
; 0000 00C0 		if (PINC.7 == 0)
_0x53:
	SBIC 0x13,7
	RJMP _0x54
; 0000 00C1 		{
; 0000 00C2 			return 'A';
	LDI  R30,LOW(65)
	RET
; 0000 00C3 		}
; 0000 00C4 
; 0000 00C5 		PORTC.0 = 1;
_0x54:
	SBI  0x15,0
; 0000 00C6 		PORTC.1 = 0;
	CBI  0x15,1
; 0000 00C7 		PORTC.2 = 1;
	SBI  0x15,2
; 0000 00C8 		PORTC.3 = 1;
	SBI  0x15,3
; 0000 00C9 		if (PINC.4 == 0)
	SBIC 0x13,4
	RJMP _0x5D
; 0000 00CA 		{
; 0000 00CB 			return '4';
	LDI  R30,LOW(52)
	RET
; 0000 00CC 		}
; 0000 00CD 
; 0000 00CE 		if (PINC.5 == 0)
_0x5D:
	SBIC 0x13,5
	RJMP _0x5E
; 0000 00CF 		{
; 0000 00D0 			return '5';
	LDI  R30,LOW(53)
	RET
; 0000 00D1 		}
; 0000 00D2 
; 0000 00D3 		if (PINC.6 == 0)
_0x5E:
	SBIC 0x13,6
	RJMP _0x5F
; 0000 00D4 		{
; 0000 00D5 			return '6';
	LDI  R30,LOW(54)
	RET
; 0000 00D6 		}
; 0000 00D7 
; 0000 00D8 		if (PINC.7 == 0)
_0x5F:
	SBIC 0x13,7
	RJMP _0x60
; 0000 00D9 		{
; 0000 00DA 			return 'B';
	LDI  R30,LOW(66)
	RET
; 0000 00DB 		}
; 0000 00DC 
; 0000 00DD 		PORTC.0 = 1;
_0x60:
	SBI  0x15,0
; 0000 00DE 		PORTC.1 = 1;
	SBI  0x15,1
; 0000 00DF 		PORTC.2 = 0;
	CBI  0x15,2
; 0000 00E0 		PORTC.3 = 1;
	SBI  0x15,3
; 0000 00E1 		if (PINC.4 == 0)
	SBIC 0x13,4
	RJMP _0x69
; 0000 00E2 		{
; 0000 00E3 			return '7';
	LDI  R30,LOW(55)
	RET
; 0000 00E4 		}
; 0000 00E5 
; 0000 00E6 		if (PINC.5 == 0)
_0x69:
	SBIC 0x13,5
	RJMP _0x6A
; 0000 00E7 		{
; 0000 00E8 			return '8';
	LDI  R30,LOW(56)
	RET
; 0000 00E9 		}
; 0000 00EA 
; 0000 00EB 		if (PINC.6 == 0)
_0x6A:
	SBIC 0x13,6
	RJMP _0x6B
; 0000 00EC 		{
; 0000 00ED 			return '9';
	LDI  R30,LOW(57)
	RET
; 0000 00EE 		}
; 0000 00EF 
; 0000 00F0 		if (PINC.7 == 0)
_0x6B:
	SBIC 0x13,7
	RJMP _0x6C
; 0000 00F1 		{
; 0000 00F2 			return 'C';
	LDI  R30,LOW(67)
	RET
; 0000 00F3 		}
; 0000 00F4 
; 0000 00F5 		PORTC.0 = 1;
_0x6C:
	SBI  0x15,0
; 0000 00F6 		PORTC.1 = 1;
	SBI  0x15,1
; 0000 00F7 		PORTC.2 = 1;
	SBI  0x15,2
; 0000 00F8 		PORTC.3 = 0;
	CBI  0x15,3
; 0000 00F9 		if (PINC.4 == 0)
	SBIC 0x13,4
	RJMP _0x75
; 0000 00FA 		{
; 0000 00FB 			return '*';
	LDI  R30,LOW(42)
	RET
; 0000 00FC 		}
; 0000 00FD 
; 0000 00FE 		if (PINC.5 == 0)
_0x75:
	SBIC 0x13,5
	RJMP _0x76
; 0000 00FF 		{
; 0000 0100 			return '0';
	LDI  R30,LOW(48)
	RET
; 0000 0101 		}
; 0000 0102 
; 0000 0103 		if (PINC.6 == 0)
_0x76:
	SBIC 0x13,6
	RJMP _0x77
; 0000 0104 		{
; 0000 0105 			return '#';
	LDI  R30,LOW(35)
	RET
; 0000 0106 		}
; 0000 0107 
; 0000 0108 		if (PINC.7 == 0)
_0x77:
	SBIC 0x13,7
	RJMP _0x78
; 0000 0109 		{
; 0000 010A 			return 'D';
	LDI  R30,LOW(68)
	RET
; 0000 010B 		}
; 0000 010C 	}
_0x78:
	RJMP _0x46
; 0000 010D }
; .FEND
;
;unsigned char verify_password()
; 0000 0110 {
_verify_password:
; .FSTART _verify_password
; 0000 0111 	unsigned char input[4];
; 0000 0112 	char temp;
; 0000 0113 
; 0000 0114 	for (i = 0; i <= 3; i++)
	SBIW R28,4
	ST   -Y,R17
;	input -> Y+1
;	temp -> R17
	CLR  R7
_0x7A:
	LDI  R30,LOW(3)
	CP   R30,R7
	BRLO _0x7B
; 0000 0115 	{
; 0000 0116 		temp = get_key();
	RCALL _get_key
	MOV  R17,R30
; 0000 0117 		lcd_putchar(temp);
	MOV  R26,R17
	RCALL _lcd_putchar
; 0000 0118 		input[i] = temp;
	MOV  R30,R7
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,1
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R17
; 0000 0119 		delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 011A 		if (temp == '*')
	CPI  R17,42
	BRNE _0x7C
; 0000 011B 		{
; 0000 011C 			lcd_clear();
	RCALL _lcd_clear
; 0000 011D 			lcd_puts("Enter passwrod: ");
	__POINTW2MN _0x7D,0
	RCALL _lcd_puts
; 0000 011E 			return 2;
	LDI  R30,LOW(2)
	RJMP _0x2020003
; 0000 011F 		}
; 0000 0120 	}
_0x7C:
	INC  R7
	RJMP _0x7A
_0x7B:
; 0000 0121 
; 0000 0122 	for (i = 0; i <= 3; i++)
	CLR  R7
_0x7F:
	LDI  R30,LOW(3)
	CP   R30,R7
	BRLO _0x80
; 0000 0123 	{
; 0000 0124 		if (input[i] == PASSWORD[i])
	MOV  R30,R7
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,1
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	MOV  R30,R7
	LDI  R31,0
	SUBI R30,LOW(-_PASSWORD*2)
	SBCI R31,HIGH(-_PASSWORD*2)
	LPM  R30,Z
	CP   R30,R26
	BRNE _0x81
; 0000 0125 		{
; 0000 0126 			temp = 1;
	LDI  R17,LOW(1)
; 0000 0127 		}
; 0000 0128 		else
	RJMP _0x82
_0x81:
; 0000 0129 		{
; 0000 012A 			temp = 0;
	LDI  R17,LOW(0)
; 0000 012B 			return temp;
	RJMP _0x2020002
; 0000 012C 		}
_0x82:
; 0000 012D 	}
	INC  R7
	RJMP _0x7F
_0x80:
; 0000 012E 
; 0000 012F 	return temp;
_0x2020002:
	MOV  R30,R17
_0x2020003:
	LDD  R17,Y+0
	ADIW R28,5
	RET
; 0000 0130 }
; .FEND

	.DSEG
_0x7D:
	.BYTE 0x11
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R26
	IN   R30,0x18
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x18,R30
	__DELAY_USB 27
	SBI  0x18,2
	__DELAY_USB 27
	CBI  0x18,2
	__DELAY_USB 27
	RJMP _0x2020001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RJMP _0x2020001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x2
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x2
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000005
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000007
	RJMP _0x2020001
_0x2000007:
_0x2000004:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x18,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x18,0
	RJMP _0x2020001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x17
	ORI  R30,LOW(0xF0)
	OUT  0x17,R30
	SBI  0x17,2
	SBI  0x17,0
	SBI  0x17,1
	CBI  0x18,2
	CBI  0x18,0
	CBI  0x18,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x3
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 400
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2020001:
	ADIW R28,1
	RET
; .FEND

	.DSEG
__base_y_G100:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	RCALL _lcd_puts
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1:
	MOVW R26,R10
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	CALL __MODW21U
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 400
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

;END OF CODE MARKER
__END_OF_CODE:
