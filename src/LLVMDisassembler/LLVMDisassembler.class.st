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
	#category : #LLVMDisassembler
}

{ #category : #'instance-creation' }
LLVMDisassembler class >> amd64 [

	^ self createDisassembler: 'amd64'
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> arm [

	^ self createDisassembler: 'arm'
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> arm64 [

	^ self createDisassembler: 'arm64'
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
	^ disassembler
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> createDisassemblerForTriple: aTripleName info: disInfo tagType: tagType opInfoCallback: getOpInfo symbolLookupCallback: symbolLookUp [ 

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

	self ffiCall: #(LLVMDisassembler LLVMCreateDisasm( char *aTripleName, void *disInfo,
                                      int tagType, void* getOpInfo,
                                      void* symbolLookUp))
]

{ #category : #resources }
LLVMDisassembler class >> ffiLibrary [

	^ 'libLLVM.dylib' asFFILibrary
]

{ #category : #'instance-creation' }
LLVMDisassembler class >> i386 [

	^ self createDisassembler: 'i386'
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
	^ {
		(string utf8Decoded trimBoth: [ :char | char isSeparator | (char = Character null) ]).
		opsize }
]

{ #category : #disassembling }
LLVMDisassembler >> disassembleNext: numberOfInstructions instructionsIn: bytes pc: pc [

	| instructions bytesToDisassemble result |
	instructions := OrderedCollection new.
	bytesToDisassemble := bytes.
	instructions size < numberOfInstructions whileTrue: [
		result := self disassembleInstructionIn: bytes pc: pc.
		instructions add: result first.
		bytesToDisassemble := bytesToDisassemble allButFirst: result second.
	].
	^ instructions
]

{ #category : #finalization }
LLVMDisassembler >> dispose [

	self ffiCall: #(void LLVMDisasmDispose(self))
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

	WeakRegistry default add: self
]

{ #category : #initialization }
LLVMDisassembler >> setOptions: options [

	self ffiCall: #(int LLVMSetDisasmOptions(self, uint64 options))
]
