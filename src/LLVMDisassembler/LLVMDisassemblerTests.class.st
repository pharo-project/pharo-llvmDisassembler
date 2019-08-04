Class {
	#name : #LLVMDisassemblerTests,
	#superclass : #TestCase,
	#category : #LLVMDisassembler
}

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleAddressReturnsDecimalImmediateAddress [

	| dis instruction |
	dis := LLVMDisassembler i386.
	
	"mov 16r12345678 eax"
	instruction := dis disassembleInstructionIn: #[161 120 86 52 18 0 0 0 0 0] pc: 0.
	
	"addresses do not have $ prefix"
	self assert: instruction assembly equals: 'movl	305419896, %eax'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleAddressWithHexaOptionReturnsHexalImmediateAddress [

	| dis instruction |
	dis := LLVMDisassembler i386.
	dis printImmediatesInHexa.
	
	"mov 16r12345678 eax"
	instruction := dis disassembleInstructionIn: #[161 120 86 52 18 0 0 0 0 0] pc: 0.
	
	"addresses do not have $ prefix"
	self assert: instruction assembly equals: 'movl	0x12345678, %eax'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleImmediateReturnsDecimalStringByDefault [

	| dis instruction |
	dis := LLVMDisassembler i386.
	instruction := dis disassembleInstructionIn: #[ 16rb8 16ra 0 0 0  ] pc: 0.
	
	self assert: instruction assembly equals: 'movl	$10, %eax'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleImmediateWithHexaOptionsReturnsHexaString [

	| dis instruction |
	dis := LLVMDisassembler i386.
	dis printImmediatesInHexa.
	instruction := dis disassembleInstructionIn: #[ 16rb8 16ra 0 0 0  ] pc: 0.
	
	self assert: instruction assembly equals: 'movl	$0xa, %eax'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleIndexedAddressReturnsDecimalIndirectAddress [

	| dis instruction |
	dis := LLVMDisassembler i386.
	
	"mov [esp + 8] eax"
	instruction := dis disassembleInstructionIn: #[139 68 36 16rf 0 0 0 0 0 0] pc: 0.
	
	"addresses do not have $ prefix"
	self assert: instruction assembly equals: 'movl	15(%esp), %eax'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleIndexedAddressWithHexaOptionReturnsHexaIndirectAddress [

	| dis instruction |
	dis := LLVMDisassembler i386.
	dis printImmediatesInHexa.
	
	"mov [esp + 8] eax"
	instruction := dis disassembleInstructionIn: #[139 68 36 16rf 0 0 0 0 0 0] pc: 0.
	
	"addresses do not have $ prefix"
	self assert: instruction assembly equals: 'movl	0xf(%esp), %eax'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleInvalidInstructionRaisesException [

	| dis |
	dis := LLVMDisassembler i386.
	self
		should: [ dis disassembleInstructionIn: #[ 16rff ] pc: 0 ]
		raise: LLVMInvalidInstructionError
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleReturnsInstructionSize [

	| dis instruction |
	dis := LLVMDisassembler i386.
	instruction := dis disassembleInstructionIn: #[ 16r41 ] pc: 0.
		
	self assert: instruction size equals: 1
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleReturnsInstructionString [

	| dis instruction |
	dis := LLVMDisassembler i386.
	instruction := dis disassembleInstructionIn: #[ 16r41 ] pc: 0.
		
	self assert: instruction assembly equals: 'incl	%ecx'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleScaledIndexedAddressReturnsDecimalScaledAddress [

	| dis instruction |
	dis := LLVMDisassembler i386.
	
	"mov [eax * 8 + ebp] edx"
	instruction := dis disassembleInstructionIn: #[139 84 197 0 0 0 0 0 0 0] pc: 0.
	
	self assert: instruction assembly equals: 'movl	(%ebp,%eax,8), %edx'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleScaledIndexedAddressWithAlternativePrinterVariantReturnsAddressInTermsOfCalculation [

	| dis instruction |
	dis := LLVMDisassembler i386.
	dis useAlternatePrinterVariant.
	
	"mov [eax * 8 + ebp] edx"
	instruction := dis disassembleInstructionIn: #[139 84 197 0 0 0 0 0 0 0] pc: 0.
	
	self assert: instruction assembly equals: 'mov	edx, dword ptr [ebp + 8*eax]'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleScaledIndexedAddressWithOffsetAndAlternativePrinterVariantReturnsAddressInTermsOfCalculation [

	| dis instruction |
	dis := LLVMDisassembler i386.
	dis useAlternatePrinterVariant.
	
	"mov [eax * 8 + ebp + 1] edx"
	instruction := dis disassembleInstructionIn: #[139 84 197 1 0 0 0 0 0 0] pc: 0.
	
	self assert: instruction assembly equals: 'mov	edx, dword ptr [ebp + 8*eax + 1]'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleScaledIndexedAddressWithOffsetReturnsDecimalScaledAddress [

	| dis instruction |
	dis := LLVMDisassembler i386.
	
	"mov [eax * 8 + ebp + 1] edx"
	instruction := dis disassembleInstructionIn: #[139 84 197 1 0 0 0 0 0 0] pc: 0.
	
	self assert: instruction assembly equals: 'movl	1(%ebp,%eax,8), %edx'
]

{ #category : #tests }
LLVMDisassemblerTests >> testDisassembleWithAlternatePrinterVariantReturnsAlternateInstructionString [

	| dis instruction |
	dis := LLVMDisassembler i386.
	dis useAlternatePrinterVariant.
	instruction := dis disassembleInstructionIn: #[ 16r41 ] pc: 0.
		
	self assert: instruction assembly equals: 'inc	ecx'
]

{ #category : #tests }
LLVMDisassemblerTests >> testInvalidInstructionErrorContainsInvalidOpcode [

	| dis |
	dis := LLVMDisassembler i386.
	[
	dis disassembleInstructionIn: #[ 16rff ] pc: 0.
	self fail ]
		on: LLVMInvalidInstructionError
		do: [ :e | self assert: e instruction = 16rff ]
]
