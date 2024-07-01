"
I represent a compilation/disassembly target in the LLVM library.
The targets required to work with should be initialized to be available in LLVM.

See my class side for initialization methods. For example, the following methods initialize x86 (32 and 64 bits), arm 32 bits and arm 64 bits.

LLVMTarget initializeX86.
LLVMTarget initializeARM.
LLVMTarget initializeARM64.
"
Class {
	#name : 'LLVMTarget',
	#superclass : 'FFIExternalObject',
	#category : 'LLVMDisassembler',
	#package : 'LLVMDisassembler'
}

{ #category : 'accessing' }
LLVMTarget class >> ffiLibrary [
	^ LibLLVMDisassembler
]

{ #category : 'accessing' }
LLVMTarget class >> firstTarget [

	self ffiCall: #(LLVMTarget LLVMGetFirstTarget(void))
]

{ #category : 'accessing' }
LLVMTarget class >> getTargetIn: targetHolder fromTriple: triple errorMessage: errorHolder [

	self ffiCall: #(Boolean LLVMGetTargetFromTriple(const char* triple, LLVMTarget *targetHolder,
                                 char **errorHolder))
]

{ #category : 'accessing' }
LLVMTarget class >> initializeAArch64 [

	self initializeAArch64Target.
	self initializeAArch64TargetInfo.
	self initializeAArch64TargetMC.
	self initializeAArch64Disassembler.
	self initializeAArch64AsmPrinter.
]

{ #category : 'accessing' }
LLVMTarget class >> initializeAArch64AsmPrinter [

	self ffiCall: #(void LLVMInitializeAArch64AsmPrinter())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeAArch64Disassembler [

	self ffiCall: #(void LLVMInitializeAArch64Disassembler())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeAArch64Target [

	self ffiCall: #(void LLVMInitializeAArch64Target())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeAArch64TargetInfo [

	self ffiCall: #(void LLVMInitializeAArch64TargetInfo())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeAArch64TargetMC [

	self ffiCall: #(void LLVMInitializeAArch64TargetMC())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeARM [

	self initializeARMTarget.
	self initializeARMTargetInfo.
	self initializeARMTargetMC.
	self initializeARMDisassembler.
	self initializeARMAsmPrinter.
]

{ #category : 'accessing' }
LLVMTarget class >> initializeARMAsmPrinter [

	self ffiCall: #(void LLVMInitializeARMAsmPrinter())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeARMDisassembler [

	self ffiCall: #(void LLVMInitializeARMDisassembler())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeARMTarget [

	self ffiCall: #(void LLVMInitializeARMTarget())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeARMTargetInfo [

	self ffiCall: #(void LLVMInitializeARMTargetInfo())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeARMTargetMC [

	self ffiCall: #(void LLVMInitializeARMTargetMC())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeRISCV [

	self initializeRISCVTarget.
	self initializeRISCVTargetInfo.
	self initializeRISCVTargetMC.
	self initializeRISCVDisassembler.
	self initializeRISCVAsmPrinter.
]

{ #category : 'accessing' }
LLVMTarget class >> initializeRISCVAsmPrinter [

	self ffiCall: #(void LLVMInitializeRISCVAsmPrinter())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeRISCVDisassembler [

	self ffiCall: #(void LLVMInitializeRISCVDisassembler())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeRISCVTarget [

	self ffiCall: #(void LLVMInitializeRISCVTarget())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeRISCVTargetInfo [

	self ffiCall: #(void LLVMInitializeRISCVTargetInfo())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeRISCVTargetMC [

	self ffiCall: #(void LLVMInitializeRISCVTargetMC())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeX86 [

	self initializeX86Target.
	self initializeX86TargetInfo.
	self initializeX86TargetMC.
	self initializeX86Disassembler.
	self initializeX86AsmPrinter.
]

{ #category : 'accessing' }
LLVMTarget class >> initializeX86AsmPrinter [

	self ffiCall: #(void LLVMInitializeX86AsmPrinter())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeX86Disassembler [

	self ffiCall: #(void LLVMInitializeX86Disassembler())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeX86Target [

	self ffiCall: #(void LLVMInitializeX86Target())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeX86TargetInfo [

	self ffiCall: #(void LLVMInitializeX86TargetInfo())
]

{ #category : 'accessing' }
LLVMTarget class >> initializeX86TargetMC [

	self ffiCall: #(void LLVMInitializeX86TargetMC())
]

{ #category : 'accessing' }
LLVMTarget >> description [

	self ffiCall: #(const char *LLVMGetTargetDescription(self))
]

{ #category : 'resources' }
LLVMTarget >> ffiLibrary [

	^ self class ffiLibrary
]

{ #category : 'accessing' }
LLVMTarget >> name [

	self ffiCall: #(const char *LLVMGetTargetName(self))
]

{ #category : 'accessing' }
LLVMTarget >> next [

	self ffiCall: #(LLVMTarget LLVMGetNextTarget(self))
]
