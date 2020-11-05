"
I am the binding to the LLVM disassembler. To create a disassembler, you can use the #createDisassembler: method using a triple name as argument.

LLVMDisassembler createDisassembler: 'x86_64'.

Or use one of the predefined factory methods in the class side such as:

LLVMDisassembler i386.
LLVMDisassembler arm.

# Usage

The main method of the disassembler is #disassembleInstructionIn:pc: which receives the bytes to disassemble and the current program counter. This method disassembles a single instructions and returns the disassembled text and the number of bytes of the instruction

x86_CODE32 := #[ 16r41 ]. ""INC ecx""
llvmDisassembler disassembleInstructionIn: x86_CODE32 pc: 0.

   => #('incl	%ecx' 1)
	
Alternatively, the convenience method #disassembleNext:instructionsIn:pc: disassembles the next N instructions in the byte array.
"
Class {
	#name : #LLVMDisassembler,
	#superclass : #FFIExternalObject,
	#instVars : [
		'options'
	],
	#category : #LLVMDisassembler
}

{ #category : #'instance-creation' }
LLVMDisassembler class >> aarch64 [
	"Returns a disassembler for ARMv8 A64 encoding"
	LLVMTarget initializeAArch64.
	^ self createDisassembler: 'aarch64'
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> amd64 [

	LLVMTarget initializeX86.
	^ self createDisassembler: 'amd64'
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> arm [

	LLVMTarget initializeARM.
	^ self createDisassembler: 'arm'
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> arm64 [

	LLVMTarget initializeAArch64.
	^ self createDisassembler: 'arm64'
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> armv5 [

	LLVMTarget initializeARM.
	^ self createDisassembler: 'armv5'
]

{ #category : #'as yet unclassified' }
LLVMDisassembler class >> armv6 [

	"Returns a disassembler for ARMv8 A32 encoding"
	LLVMTarget initializeARM.
	^ self createDisassembler: 'armv6'
]

{ #category : #'as yet unclassified' }
LLVMDisassembler class >> armv6k [

	LLVMTarget initializeARM.
	^ self createDisassembler: 'armv6k'
	
]

{ #category : #'as yet unclassified' }
LLVMDisassembler class >> armv6m [

	LLVMTarget initializeARM.
	^ self createDisassembler: 'armv6m'
]

{ #category : #'as yet unclassified' }
LLVMDisassembler class >> armv7 [
	
	LLVMTarget initializeARM.
	^ self createDisassembler: 'armv7'
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> armv8 [
	"Returns a disassembler for ARMv8 A32 encoding"
	LLVMTarget initializeARM.
	^ self createDisassembler: 'armv8'
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> createDisassembler: aTripleString [

	| disassembler |
	disassembler := self
		createDisassemblerForTriple: aTripleString
		info: nil
		tagType: 0
		opInfoCallback: nil
		symbolLookupCallback: nil.
	disassembler isNull ifTrue: [ 
		self error: 'Could not instantiate disassembler for: ', aTripleString ].
	disassembler initialize.
	^ disassembler
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> createDisassemblerForTriple: aTripleName info: disInfo tagType: tagType opInfoCallback: getOpInfo symbolLookupCallback: symbolLookUp [ 


	| address |
	address := self primCreateDisassemblerForTriple: aTripleName info: disInfo tagType: tagType opInfoCallback: getOpInfo symbolLookupCallback: symbolLookUp.

	^ self fromHandle: address
]

{ #category : #resources }
LLVMDisassembler class >> ffiLibrary [
	^ LibLLVMDisassembler
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> i386 [

	LLVMTarget initializeX86.
	^ self createDisassembler: 'i386'
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> primCreateDisassemblerForTriple: aTripleName info: disInfo tagType: tagType opInfoCallback: getOpInfo symbolLookupCallback: symbolLookUp [ 

	"/**
	 * Create a disassembler for the TripleName.  Symbolic disassembly is supported
	 * by passing a block of information in the DisInfo parameter and specifying the
	 * TagType and callback functions as described above.  These can all be passed
	 * as NULL.  If successful, this returns a disassembler context.  If not, it
	 * returns NULL. This function is equivalent to calling
	 * LLVMCreateDisasmCPUFeatures() with an empty CPU name and feature set.
	 */
	LLVMDisasmContextRef LLVMCreateDisasm(const char *TripleName, void *DisInfo,
                                      int TagType, LLVMOpInfoCallback GetOpInfo,
                                      LLVMSymbolLookupCallback SymbolLookUp);"

	self ffiCall: #(void* LLVMCreateDisasm( char *aTripleName, void *disInfo,
                                      int tagType, void* getOpInfo,
                                      void* symbolLookUp))
]

{ #category : #disassembling }
LLVMDisassembler >> disassembleInstructionBytes: instructionBytes address: startAddress pc: pc [

	| result |

		[ result := self disassembleInstructionIn: instructionBytes pc: pc ]
			on: LLVMInvalidInstructionError
			do: [ ^ nil].
		
		result address: startAddress.
		
		^ result
]

{ #category : #disassembling }
LLVMDisassembler >> disassembleInstructionIn: bytes bufferSize: bytesSize pc: pc outString: outString outStringSize: outStringSize [

	self ffiCall: #(size_t LLVMDisasmInstruction(self, uint8 *bytes,
                             uint64 bytesSize, uint64 pc,
                             char *outString, size_t outStringSize))
]

{ #category : #disassembling }
LLVMDisassembler >> disassembleInstructionIn: bytes pc: pc [

	| string opsize |
	string := ByteArray new: 255.
	opsize := self
		disassembleInstructionIn: bytes
		bufferSize: bytes size
		pc: pc
		outString: string
		outStringSize: string size.
		
	opsize = 0 ifTrue: [ 
		LLVMInvalidInstructionError new
			instruction: bytes first;
			signal ].
	
	^ self newInstruction
		assembly: (string utf8Decoded trimBoth: [ :char | char isSeparator | (char = Character null) ]);
		size: opsize;
		yourself
]

{ #category : #disassembling }
LLVMDisassembler >> disassembleNext: numberOfInstructions instructionsIn: bytes startAddress: startAddress pc: pc [

	| instructions result offset instructionBytes |
	instructions := OrderedCollection new.
	offset := 0.
	[instructions size < numberOfInstructions] 
		whileTrue: [
			"assume 50 bytes tops per instruction"
			instructionBytes := bytes copyFrom: offset + 1 to: ((offset + 50) min: bytes size).
			
			result := self 
				disassembleInstructionBytes: instructionBytes 
				address: startAddress + offset 
				pc: pc. 

			"Stop when no more valid instructions are found"
			result ifNil: [ ^ instructions ].

			result offset: offset.
			offset := offset + result size. 
			instructions add: result].
	
	^ instructions
]

{ #category : #finalization }
LLVMDisassembler >> dispose [

	self ffiCall: #(void LLVMDisasmDispose(self))
]

{ #category : #configuring }
LLVMDisassembler >> ensureOption: value [
	
	self setOptions: (options := options bitOr: value)
]

{ #category : #resources }
LLVMDisassembler >> ffiLibrary [

	^ self class ffiLibrary
]

{ #category : #finalization }
LLVMDisassembler >> finalize [

	^ self dispose
]

{ #category : #initialization }
LLVMDisassembler >> initialize [

	"Should not call super initialize, because it will reinitialize the handle..."
	options := 0.
	WeakRegistry default add: self
]

{ #category : #factory }
LLVMDisassembler >> newInstruction [

	^ LLVMInstruction new
]

{ #category : #configuration }
LLVMDisassembler >> printImmediatesInHexa [

	self ensureOption: "LLVMDisassembler_Option_PrintImmHex" 2
]

{ #category : #configuration }
LLVMDisassembler >> printLatency [

	self ensureOption: "LLVMDisassembler_Option_PrintLatency" 16
]

{ #category : #configuration }
LLVMDisassembler >> setInstructionComments [

	self ensureOption: "LLVMDisassembler_Option_SetInstrComments" 8
]

{ #category : #initialization }
LLVMDisassembler >> setOptions: options [

	self ffiCall: #(int LLVMSetDisasmOptions(self, uint64 options))
]

{ #category : #configuring }
LLVMDisassembler >> useAlternatePrinterVariant [
	
	self ensureOption: "LLVMDisassembler_Option_AsmPrinterVariant" 4
]
