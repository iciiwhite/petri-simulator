Class {
  #name : #PetriNetPNMLImporter,
  #superclass : #Object,
  #instVars : [
    'builder',
    'xmlDoc'
  ],
  #category : #'PetriSimulator-IO'
}

PetriNetPNMLImporter >> importFromFile: aFileName
  builder := PetriNetBuilder new.
  xmlDoc := XMLDOMParser parseDocumentFrom: (StandardFileStream oldFileNamed: aFileName).
  self parsePlaces.
  self parseTransitions.
  self parseArcs.
  ^ builder build.

PetriNetPNMLImporter >> parsePlaces
  (xmlDoc nodesMatching: 'place') do: [ :node | 
    | id tokensNode |
    id := node attributeAt: 'id'.
    tokensNode := node elementAt: 'initialMarking'.
    tokensNode ifNil: [ builder addPlaceNamed: id initialTokens: 0 ]
      ifNotNil: [ 
        | value |
        value := (tokensNode elementAt: 'text') contentString asInteger.
        builder addPlaceNamed: id initialTokens: value ] ].

PetriNetPNMLImporter >> parseTransitions
  (xmlDoc nodesMatching: 'transition') do: [ :node | 
    builder addTransitionNamed: (node attributeAt: 'id') ].

PetriNetPNMLImporter >> parseArcs
  (xmlDoc nodesMatching: 'arc') do: [ :node | 
    | source target weightNode |
    source := node attributeAt: 'source'.
    target := node attributeAt: 'target'.
    weightNode := node elementAt: 'inscription'.
    weightNode ifNil: [ builder addArcFrom: source to: target ]
      ifNotNil: [ 
        | weight |
        weight := (weightNode elementAt: 'text') contentString asInteger.
        builder addArcFrom: source to: target weight: weight ] ].