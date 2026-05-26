Class {
  #name : #ReachabilityExplorer,
  #superclass : #Object,
  #instVars : [
    'net',
    'visited',
    'queue',
    'root',
    'nodes'
  ],
  #category : #'PetriSimulator-Analysis'
}

ReachabilityExplorer >> on: aPetriNet
  net := aPetriNet.
  visited := Set new.
  nodes := OrderedCollection new.

ReachabilityExplorer >> explore
  | startMarking |
  startMarking := net currentMarking.
  root := ReachabilityNode new.
  root marking: startMarking.
  root parent: nil.
  queue := OrderedCollection with: root.
  visited add: startMarking.
  [ queue isEmpty ] whileFalse: [ 
    | current node |
    node := queue removeFirst.
    current := node marking.
    net transitions do: [ :t | 
      (net isEnabled: t) ifTrue: [ 
        net fireTransition: t.
        | newMarking child |
        newMarking := net currentMarking.
        net reset.
        (visited includes: newMarking) ifFalse: [ 
          visited add: newMarking.
          child := ReachabilityNode new.
          child marking: newMarking.
          child parent: node.
          node addChild: child.
          queue add: child ] ] ] ].
  ^ nodes.

ReachabilityExplorer >> reachableNodes
  ^ nodes.

ReachabilityExplorer >> rootNode
  ^ root.