Class {
  #name : #Marking,
  #superclass : #Object,
  #instVars : [
    'dict'
  ],
  #category : #'PetriSimulator-Core'
}

Marking >> initialize
  super initialize.
  dict := Dictionary new.

Marking >> at: aPlace put: tokens
  dict at: aPlace put: tokens.

Marking >> at: aPlace
  ^ dict at: aPlace ifAbsent: [ 0 ].

Marking >> places
  ^ dict keys.

Marking >> tokensForPlace: aPlace
  ^ self at: aPlace.

Marking >> = anObject
  self class = anObject class ifFalse: [ ^ false ].
  ^ dict = anObject instVarNamed: 'dict'.

Marking >> hash
  ^ dict hash.

Marking >> printOn: aStream
  aStream nextPutAll: 'Marking('.
  dict keysAndValuesDo: [ :p :t | 
    aStream nextPutAll: p name; nextPutAll: '->'; print: t; space ].
  aStream nextPut: $).