Class {
  #name : #PetriNetMorph,
  #superclass : #Morph,
  #instVars : [
    'net',
    'placeMorphs',
    'transitionMorphs',
    'arcMorphs'
  ],
  #category : #'PetriSimulator-GUI'
}

PetriNetMorph >> initialize
  super initialize.
  self extent: 800 @ 600.
  self color: Color veryLightGray.
  placeMorphs := Dictionary new.
  transitionMorphs := Dictionary new.
  arcMorphs := OrderedCollection new.

PetriNetMorph >> net: aPetriNet
  net := aPetriNet.
  self rebuild.

PetriNetMorph >> rebuild
  self removeAllMorphs.
  placeMorphs := Dictionary new.
  transitionMorphs := Dictionary new.
  arcMorphs := OrderedCollection new.
  net places do: [ :p | self addPlaceMorph: p ].
  net transitions do: [ :t | self addTransitionMorph: t ].
  net arcs do: [ :a | self addArcMorph: a ].

PetriNetMorph >> addPlaceMorph: aPlace
  | m |
  m := PlaceMorph new.
  m place: aPlace.
  m position: (100 + (placeMorphs size * 80)) @ 200.
  self addMorph: m.
  placeMorphs at: aPlace put: m.

PetriNetMorph >> addTransitionMorph: aTransition
  | m |
  m := TransitionMorph new.
  m transition: aTransition.
  m position: (150 + (transitionMorphs size * 90)) @ 400.
  self addMorph: m.
  transitionMorphs at: aTransition put: m.

PetriNetMorph >> addArcMorph: anArc
  | sourceMorph targetMorph arcMorph |
  sourceMorph := placeMorphs at: anArc source ifAbsent: [ transitionMorphs at: anArc source ].
  targetMorph := placeMorphs at: anArc target ifAbsent: [ transitionMorphs at: anArc target ].
  arcMorph := ArcMorph new.
  arcMorph from: sourceMorph to: targetMorph.
  arcMorph weight: anArc weight.
  self addMorph: arcMorph.
  arcMorphs add: arcMorph.

PetriNetMorph >> updateSimulator: aSimulator
  placeMorphs valuesDo: [ :m | m updateTokens ].
  transitionMorphs valuesDo: [ :m | m updateEnabled ].