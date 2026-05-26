Class {
  #name : #DiningPhilosophersNet,
  #superclass : #Object,
  #category : #'PetriSimulator-Examples'
}

DiningPhilosophersNet class >> newNetFor: n
  | builder i |
  builder := PetriNetBuilder new.
  builder name: ('DiningPhilosophers_', n printString).
  1 to: n do: [ :idx | 
    builder addPlaceNamed: ('fork', idx printString) initialTokens: 1.
    builder addTransitionNamed: ('take', idx printString).
    builder addTransitionNamed: ('release', idx printString).
    builder addPlaceNamed: ('eat', idx printString) initialTokens: 0 ].
  1 to: n do: [ :idx | 
    | next |
    next := idx \\ n + 1.
    builder addArcFrom: ('fork', idx printString) to: ('take', idx printString).
    builder addArcFrom: ('fork', next printString) to: ('take', idx printString).
    builder addArcFrom: ('take', idx printString) to: ('eat', idx printString).
    builder addArcFrom: ('eat', idx printString) to: ('release', idx printString).
    builder addArcFrom: ('release', idx printString) to: ('fork', idx printString).
    builder addArcFrom: ('release', idx printString) to: ('fork', next printString) ].
  ^ builder build.