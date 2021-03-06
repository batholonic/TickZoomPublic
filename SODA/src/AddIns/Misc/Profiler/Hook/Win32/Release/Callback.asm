; Listing generated by Microsoft (R) Optimizing Compiler Version 15.00.30729.01 

	TITLE	c:\Local\SharpDevelop_3.2.0.5777_Source\src\AddIns\Misc\Profiler\Hook\Callback.cpp
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB OLDNAMES

PUBLIC	_IID_IMetaDataImport
PUBLIC	_IID_IMetaDataAssemblyImport
PUBLIC	?g_tkCorEncodeToken@@3QBIB			; g_tkCorEncodeToken
;	COMDAT ?g_tkCorEncodeToken@@3QBIB
CONST	SEGMENT
?g_tkCorEncodeToken@@3QBIB DD 02000000H			; g_tkCorEncodeToken
	DD	01000000H
	DD	01b000000H
	DD	072000000H
CONST	ENDS
;	COMDAT _IID_IMetaDataAssemblyImport
CONST	SEGMENT
_IID_IMetaDataAssemblyImport DD 0ee62470bH
	DW	0e94bH
	DW	0424eH
	DB	09bH
	DB	07cH
	DB	02fH
	DB	00H
	DB	0c9H
	DB	024H
	DB	09fH
	DB	093H
CONST	ENDS
;	COMDAT _IID_IMetaDataImport
CONST	SEGMENT
_IID_IMetaDataImport DD 07dac8207H
	DW	0d3aeH
	DW	04c75H
	DB	09bH
	DB	067H
	DB	092H
	DB	080H
	DB	01aH
	DB	049H
	DB	07dH
	DB	044H
PUBLIC	?FunctionLeaveNaked@@YAXIIIPAU_COR_PRF_FUNCTION_ARGUMENT_RANGE@@@Z ; FunctionLeaveNaked
; Function compile flags: /Ogtpy
; File c:\local\sharpdevelop_3.2.0.5777_source\src\addins\misc\profiler\hook\callback.cpp
;	COMDAT ?FunctionLeaveNaked@@YAXIIIPAU_COR_PRF_FUNCTION_ARGUMENT_RANGE@@@Z
_TEXT	SEGMENT
_functionID$ = 8					; size = 4
_clientData$ = 12					; size = 4
_func$ = 16						; size = 4
_retvalRange$ = 20					; size = 4
?FunctionLeaveNaked@@YAXIIIPAU_COR_PRF_FUNCTION_ARGUMENT_RANGE@@@Z PROC ; FunctionLeaveNaked, COMDAT

; 65   : 	__asm
; 66   : 	{
; 67   : 		#define CallPopSize 0
; 68   : 		#define SavedRegisterOffset CallPopSize
; 69   : 		#define SavedRegister(X) [esp + SavedRegisterOffset + X]
; 70   : 		#define SavedFPRegister(X) [esp + SavedRegisterOffset + 12 + X]
; 71   : 		#define SavedFloatRegisterSize 12
; 72   : 		#define SavedRegisterSize 12 + SavedFloatRegisterSize
; 73   : 		#define FrameSize (SavedRegisterOffset + SavedRegisterSize)
; 74   : 		
; 75   : 		sub esp, FrameSize

	sub	esp, 24					; 00000018H

; 76   : 		mov SavedRegister(8), eax

	mov	DWORD PTR [esp+8], eax

; 77   : 		mov SavedRegister(4), ecx

	mov	DWORD PTR [esp+4], ecx

; 78   : 		mov SavedRegister(0), edx

	mov	DWORD PTR [esp], edx

; 79   : 		
; 80   : 		// Check if there's anything on the FP stack.
; 81   : 		//
; 82   : 		// Again technically you need only save what you use. You might think that
; 83   : 		// FP regs are not commonly used in the kind of code you'd write in these,
; 84   : 		// but there are common cases that might interfere. For example, in the 8.0 MS CRT, 
; 85   : 		// memcpy clears the FP stack.
; 86   : 		//
; 87   : 		// In CLR versions 1.x and 2.0, everything from here to NoSaveFPReg
; 88   : 		// is only strictly necessary for FunctionLeave and FunctionLeave2.
; 89   : 		// Of course that may change in future releases, so use this code for all of your
; 90   : 		// enter/leave function hooks if you want to avoid breaking.
; 91   : 		fstsw   ax

	fstsw	ax

; 92   : 		test    ax, 3800h		// Check the top-of-fp-stack bits

	test	ax, 14336				; 00003800H

; 93   : 		jnz     SaveFPReg

	jne	SHORT $SaveFPReg$69987

; 94   : 		mov     dword ptr SavedFPRegister(0), 0 // otherwise, mark that there is no float value

	mov	DWORD PTR [esp+12], 0

; 95   : 		jmp     NoSaveFPReg

	jmp	SHORT $NoSaveFPReg$69988
$SaveFPReg$69987:

; 96   : 	SaveFPReg:
; 97   : 		fstp    qword ptr SavedFPRegister(4) // Copy the FP value to the buffer as a double

	fstp	QWORD PTR [esp+16]

; 98   : 		mov     dword ptr SavedFPRegister(0), 1	// mark that a float value is present

	mov	DWORD PTR [esp+12], 1
$NoSaveFPReg$69988:

; 99   : 	NoSaveFPReg:
; 100  : 		
; 101  : 		
; 102  : 		call    FunctionLeaveGlobal

	call	?FunctionLeaveGlobal@@YIXXZ		; FunctionLeaveGlobal

; 103  : 		// the call causes CallPopSize bytes to be popped from the stack
; 104  : 		
; 105  : 		// Now see if we have to restore any floating point registers
; 106  : 		// In CLR versions 1.x and 2.0, everything from here to 
; 107  : 		// RestoreFPRegsDone is only strictly necessary for FunctionLeave and FunctionLeave2
; 108  : 		// Of course that may change in future releases, so use this code for all of your
; 109  : 		// enter/leave function hooks if you want to avoid breaking.
; 110  : 		cmp     dword ptr SavedFPRegister(0 - CallPopSize), 0		// Check the flag

	cmp	DWORD PTR [esp+12], 0

; 111  : 		jz      NoRestoreFPRegs		// If zero, no FP regs

	je	SHORT $NoRestoreFPRegs$69989

; 112  : 	//RestoreFPRegs:
; 113  : 		fld     qword ptr SavedFPRegister(4 - CallPopSize)	// Restore FP regs

	fld	QWORD PTR [esp+16]
$NoRestoreFPRegs$69989:

; 114  : 	NoRestoreFPRegs:
; 115  : 	//RestoreFPRegsDone:
; 116  : 		
; 117  : 		mov edx, SavedRegister(0 - CallPopSize)

	mov	edx, DWORD PTR [esp]

; 118  : 		mov ecx, SavedRegister(4 - CallPopSize)

	mov	ecx, DWORD PTR [esp+4]

; 119  : 		mov eax, SavedRegister(8 - CallPopSize)

	mov	eax, DWORD PTR [esp+8]

; 120  : 		add esp, FrameSize - CallPopSize

	add	esp, 24					; 00000018H

; 121  : 		ret    16

	ret	16					; 00000010H
?FunctionLeaveNaked@@YAXIIIPAU_COR_PRF_FUNCTION_ARGUMENT_RANGE@@@Z ENDP ; FunctionLeaveNaked
PUBLIC	?FunctionTailcallNaked@@YAXIII@Z		; FunctionTailcallNaked
; Function compile flags: /Ogtpy
;	COMDAT ?FunctionTailcallNaked@@YAXIII@Z
_TEXT	SEGMENT
_functionID$ = 8					; size = 4
_clientData$ = 12					; size = 4
_func$ = 16						; size = 4
?FunctionTailcallNaked@@YAXIII@Z PROC			; FunctionTailcallNaked, COMDAT

; 131  : 	__asm
; 132  : 	{
; 133  : 		#define CallPopSize 0
; 134  : 		#define SavedRegisterOffset CallPopSize
; 135  : 		#define SavedRegister(X) [esp + SavedRegisterOffset + X]
; 136  : 		#define SavedRegisterSize 12
; 137  : 		#define FrameSize (SavedRegisterOffset + SavedRegisterSize)
; 138  : 		
; 139  : 		sub esp, FrameSize

	sub	esp, 12					; 0000000cH

; 140  : 		// eax, ecx and edx are scratch registers in stdcall, so we need to save those
; 141  : 		mov SavedRegister(8), eax

	mov	DWORD PTR [esp+8], eax

; 142  : 		mov SavedRegister(4), ecx

	mov	DWORD PTR [esp+4], ecx

; 143  : 		mov SavedRegister(0), edx

	mov	DWORD PTR [esp], edx

; 144  : 				
; 145  : 		call    FunctionTailcallGlobal

	call	?FunctionTailcallGlobal@@YIXXZ		; FunctionTailcallGlobal

; 146  : 		// the call causes CallPopSize bytes to be popped from the stack
; 147  : 				
; 148  : 		mov edx, SavedRegister(0 - CallPopSize)

	mov	edx, DWORD PTR [esp]

; 149  : 		mov ecx, SavedRegister(4 - CallPopSize)

	mov	ecx, DWORD PTR [esp+4]

; 150  : 		mov eax, SavedRegister(8 - CallPopSize)

	mov	eax, DWORD PTR [esp+8]

; 151  : 		
; 152  : 		add esp, FrameSize - CallPopSize

	add	esp, 12					; 0000000cH

; 153  : 		ret    12

	ret	12					; 0000000cH
?FunctionTailcallNaked@@YAXIII@Z ENDP			; FunctionTailcallNaked
PUBLIC	?FunctionEnterNaked@@YAXIIIPAU_COR_PRF_FUNCTION_ARGUMENT_INFO@@@Z ; FunctionEnterNaked
; Function compile flags: /Ogtpy
;	COMDAT ?FunctionEnterNaked@@YAXIIIPAU_COR_PRF_FUNCTION_ARGUMENT_INFO@@@Z
_TEXT	SEGMENT
_functionID$ = 8					; size = 4
_clientData$ = 12					; size = 4
_func$ = 16						; size = 4
_argumentInfo$ = 20					; size = 4
?FunctionEnterNaked@@YAXIIIPAU_COR_PRF_FUNCTION_ARGUMENT_INFO@@@Z PROC ; FunctionEnterNaked, COMDAT

; 18   : 	__asm
; 19   : 	{
; 20   : 		#define CallPopSize 0
; 21   : 		#define SavedRegisterOffset CallPopSize
; 22   : 		#define SavedRegister(X) [esp + SavedRegisterOffset + X]
; 23   : 		#define SavedRegisterSize 12
; 24   : 		#define FrameSize (SavedRegisterOffset + SavedRegisterSize)
; 25   : 		
; 26   : 		// stack layout:
; 27   : 		// esp +  0   -> functionID       \
; 28   : 		//     +  4   -> low bits of tsc  |- parameters for FunctionEnterGlobal
; 29   : 		//     +  8   -> high bits of tsc /
; 30   : 		//     + 12   -> saved edx
; 31   : 		//     + 16   -> saved ecx
; 32   : 		//     + 20   -> saved eax
; 33   : 		//     + 24   -> saved esi
; 34   : 		//     + 28   -> return address
; 35   : 		//     + 32   -> functionID      \
; 36   : 		//     + 36   -> clientData      |- parameters for FunctionEnterNaked
; 37   : 		//     + 40   -> ...             /
; 38   : 		
; 39   : 		sub esp, FrameSize

	sub	esp, 12					; 0000000cH

; 40   : 		// eax, ecx and edx are scratch registers in stdcall, so we need to save those
; 41   : 		mov SavedRegister(8), eax

	mov	DWORD PTR [esp+8], eax

; 42   : 		mov SavedRegister(4), ecx

	mov	DWORD PTR [esp+4], ecx

; 43   : 		mov SavedRegister(0), edx

	mov	DWORD PTR [esp], edx

; 44   : 				
; 45   : 		mov ecx, [esp+FrameSize+8] // get clientData = custom FunctionID

	mov	ecx, DWORD PTR [esp+20]

; 46   : 		// first argument is in ecx
; 47   : 		
; 48   : 		call    FunctionEnterGlobal

	call	?FunctionEnterGlobal@@YIXH@Z		; FunctionEnterGlobal

; 49   : 		// the call causes CallPopSize bytes to be popped from the stack
; 50   : 				
; 51   : 		mov edx, SavedRegister(0 - CallPopSize)

	mov	edx, DWORD PTR [esp]

; 52   : 		mov ecx, SavedRegister(4 - CallPopSize)

	mov	ecx, DWORD PTR [esp+4]

; 53   : 		mov eax, SavedRegister(8 - CallPopSize)

	mov	eax, DWORD PTR [esp+8]

; 54   : 		
; 55   : 		add esp, FrameSize - CallPopSize

	add	esp, 12					; 0000000cH

; 56   : 		ret    16

	ret	16					; 00000010H
?FunctionEnterNaked@@YAXIIIPAU_COR_PRF_FUNCTION_ARGUMENT_INFO@@@Z ENDP ; FunctionEnterNaked
END
