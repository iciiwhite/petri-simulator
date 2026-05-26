Class {
  #name : #SimulatorTest,
  #superclass : #TestCase,
  #category : #'PetriSimulator-Tests'
}

SimulatorTest >> testStep
  | net sim |
  net := ExampleNets simpleNet.
  sim := PetriNetSimulator on: net.
  sim step.
  self assert: ((net placeNamed: 'p1') tokens equals: 0).
  self assert: ((net placeNamed: 'p2') tokens equals: 1).

SimulatorTest >> testReset
  | net sim |
  net := ExampleNets simpleNet.
  sim := PetriNetSimulator on: net.
  sim step.
  sim reset.
  self assert: ((net placeNamed: 'p1') tokens equals: 1).
  self assert: ((net placeNamed: 'p2') tokens equals: 0).