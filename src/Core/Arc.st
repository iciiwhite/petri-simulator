Class {
  #name : #Arc,
  #superclass : #Object,
  #instVars : [
    'source',
    'target',
    'weight'
  ],
  #category : #'PetriSimulator-Core'
}

Arc >> initialize
  super initialize.
  weight := 1.

Arc >> source: anObject
  source := anObject.

Arc >> source
  ^ source.

Arc >> target: anObject
  target := anObject.

Arc >> target
  ^ target.

Arc >> weight: anInteger
  weight := anInteger.

Arc >> weight
  ^ weight.

Arc >> isEnabledIn: aPetriNet
  (source isKindOf: Place) ifTrue: [ 
    ^ source tokens >= weight ].
  ^ true.

Arc >> fireIn: aPetriNet
  (source isKindOf: Place) ifTrue: [ 
    source removeTokens: weight ].
  (target isKindOf: Place) ifTrue: [ 
    target addTokens: weight ].

Arc >> printOn: aStream
  super printOn: aStream.
  aStream nextPutAll: ' (', source name, '->', target name, ' w=', weight printString, ')'.