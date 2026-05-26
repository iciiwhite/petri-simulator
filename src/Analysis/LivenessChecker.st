Class {
  #name : #LivenessChecker,
  #superclass : #Object,
  #instVars : [
    'net',
    'deadTransitions'
  ],
  #category : #'PetriSimulator-Analysis'
}

LivenessChecker >> on: aPetriNet
  net := aPetriNet.

LivenessChecker >> check
  deadTransitions := Set new.
  net transitions do: [ :t | 
    (net isEnabled: t) ifFalse: [ deadTransitions add: t ] ].
  ^ deadTransitions isEmpty.

LivenessChecker >> deadlockFree
  ^ net transitions anySatisfy: [ :t | net isEnabled: t ].

LivenessChecker >> printDeadTransitions
  deadTransitions do: [ :t | Transcript show: t name; space ].
  Transcript cr.