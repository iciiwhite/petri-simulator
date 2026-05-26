Class {
  #name : #Place,
  #superclass : #Object,
  #instVars : [
    'name',
    'tokens',
    'capacity',
    'incomingArcs',
    'outgoingArcs'
  ],
  #category : #'PetriSimulator-Core'
}

Place >> initialize
  super initialize.
  tokens := 0.
  capacity := nil.
  incomingArcs := OrderedCollection new.
  outgoingArcs := OrderedCollection new.

Place >> name: aString
  name := aString.

Place >> name
  ^ name.

Place >> tokens
  ^ tokens.

Place >> tokens: anInteger
  tokens := anInteger.

Place >> capacity
  ^ capacity.

Place >> capacity: anInteger
  capacity := anInteger.

Place >> addTokens: anInteger
  tokens := tokens + anInteger.
  capacity ifNotNil: [ tokens := tokens min: capacity ].

Place >> removeTokens: anInteger
  tokens := tokens - anInteger.
  tokens := tokens max: 0.

Place >> reset
  tokens := 0.

Place >> addIncomingArc: anArc
  incomingArcs add: anArc.

Place >> addOutgoingArc: anArc
  outgoingArcs add: anArc.

Place >> incomingArcs
  ^ incomingArcs.

Place >> outgoingArcs
  ^ outgoingArcs.

Place >> canAcceptTokens: anInteger
  capacity ifNil: [ ^ true ].
  ^ tokens + anInteger <= capacity.

Place >> printOn: aStream
  super printOn: aStream.
  aStream nextPutAll: ' (', name, ' tokens=', tokens printString, ')'.