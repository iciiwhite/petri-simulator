Class {
  #name : #PetriNetTest,
  #superclass : #TestCase,
  #category : #'PetriSimulator-Tests'
}

PetriNetTest >> testAddPlace
  | net p |
  net := PetriNet new.
  p := Place new.
  p name: 'p1'.
  net addPlace: p.
  self assert: (net placeNamed: 'p1') equals: p.

PetriNetTest >> testFireTransition
  | net p1 p2 t1 |
  net := PetriNet new.
  p1 := Place new name: 'p1'; tokens: 1; yourself.
  p2 := Place new name: 'p2'; tokens: 0; yourself.
  t1 := Transition new name: 't1'.
  net addPlace: p1; addPlace: p2; addTransition: t1.
  net addArc: ((Arc new) source: p1; target: t1; weight: 1; yourself).
  net addArc: ((Arc new) source: t1; target: p2; weight: 1; yourself).
  self assert: (net isEnabled: t1).
  net fireTransition: t1.
  self assert: p1 tokens equals: 0.
  self assert: p2 tokens equals: 1.

PetriNetTest >> testStep
  | net p1 p2 t1 |
  net := PetriNet new.
  p1 := Place new name: 'p1'; tokens: 1; yourself.
  p2 := Place new name: 'p2'; tokens: 0; yourself.
  t1 := Transition new name: 't1'.
  net addPlace: p1; addPlace: p2; addTransition: t1.
  net addArc: ((Arc new) source: p1; target: t1; weight: 1; yourself).
  net addArc: ((Arc new) source: t1; target: p2; weight: 1; yourself).
  net step.
  self assert: p1 tokens equals: 0.
  self assert: p2 tokens equals: 1.