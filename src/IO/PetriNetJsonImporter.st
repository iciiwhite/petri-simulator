Class {
  #name : #PetriNetJsonImporter,
  #superclass : #Object,
  #instVars : [
    'builder'
  ],
  #category : #'PetriSimulator-IO'
}

PetriNetJsonImporter >> importFromString: aString
  | data |
  builder := PetriNetBuilder new.
  data := STONJSON fromString: aString.
  builder name: (data at: 'name' ifAbsent: [ 'ImportedNet' ]).
  (data at: 'places' ifAbsent: [ #() ]) do: [ :pDict | 
    builder addPlaceNamed: (pDict at: 'name') initialTokens: (pDict at: 'tokens' ifAbsent: [ 0 ]) ].
  (data at: 'transitions' ifAbsent: [ #() ]) do: [ :tDict | 
    builder addTransitionNamed: (tDict at: 'name') ].
  (data at: 'arcs' ifAbsent: [ #() ]) do: [ :aDict | 
    builder addArcFrom: (aDict at: 'source') to: (aDict at: 'target') weight: (aDict at: 'weight' ifAbsent: [ 1 ]) ].
  ^ builder build.

PetriNetJsonImporter >> importFromFile: aFileName
  | contents |
  contents := (StandardFileStream oldFileNamed: aFileName) contents.
  ^ self importFromString: contents.