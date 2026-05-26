Class {
  #name : #PetriNetBuilder,
  #superclass : #Object,
  #instVars : [
    'net'
  ],
  #category : #'PetriSimulator-Core'
}

PetriNetBuilder >> initialize
  super initialize.
  net := PetriNet new.

PetriNetBuilder >> net
  ^ net.

PetriNetBuilder >> reset
  net := PetriNet new.

PetriNetBuilder >> addPlaceNamed: aString initialTokens: anInteger
  | p |
  p := Place new.
  p name: aString.
  p tokens: anInteger.
  net addPlace: p.
  ^ self.

PetriNetBuilder >> addTransitionNamed: aString
  | t |
  t := Transition new.
  t name: aString.
  net addTransition: t.
  ^ self.

PetriNetBuilder >> addArcFrom: sourceName to: targetName weight: anInteger
  | source target arc |
  source := net placeNamed: sourceName.
  source ifNil: [ source := net transitionNamed: sourceName ].
  target := net placeNamed: targetName.
  target ifNil: [ target := net transitionNamed: targetName ].
  arc := Arc new.
  arc source: source.
  arc target: target.
  arc weight: anInteger.
  net addArc: arc.
  ^ self.

PetriNetBuilder >> addArcFrom: sourceName to: targetName
  ^ self addArcFrom: sourceName to: targetName weight: 1.

PetriNetBuilder >> name: aString
  net name: aString.
  ^ self.

PetriNetBuilder >> build
  ^ net.