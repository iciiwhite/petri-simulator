Class {
  #name : #ReachabilityGraphMorph,
  #superclass : #Morph,
  #instVars : [
    'explorer',
    'nodeMorphs'
  ],
  #category : #'PetriSimulator-GUI'
}

ReachabilityGraphMorph >> initialize
  super initialize.
  self extent: 600 @ 500.
  self color: Color white.
  nodeMorphs := Dictionary new.

ReachabilityGraphMorph >> on: aPetriNet
  explorer := ReachabilityExplorer on: aPetriNet.
  explorer explore.
  self layoutGraph.

ReachabilityGraphMorph >> layoutGraph
  | nodes root index |
  nodes := explorer reachableNodes.
  nodes ifEmpty: [ ^ self ].
  root := nodes detect: [ :n | n parent isNil ].
  index := 0.
  self layoutNode: root atX: 300 y: 20.

ReachabilityGraphMorph >> layoutNode: aNode atX: x y: y
  | morph |
  morph := EllipseMorph new.
  morph extent: 80 @ 30.
  morph color: Color lightBlue.
  morph borderWidth: 1.
  morph position: x - 40 @ y.
  self addMorph: morph.
  nodeMorphs at: aNode put: morph.
  aNode children doWithIndex: [ :child :i | 
    self layoutNode: child atX: x + (i * 100) - 150 y: y + 80 ].