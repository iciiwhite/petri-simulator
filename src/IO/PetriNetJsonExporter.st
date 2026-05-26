Class {
  #name : #PetriNetJsonExporter,
  #superclass : #Object,
  #category : #'PetriSimulator-IO'
}

PetriNetJsonExporter >> export: aPetriNet
  | dict |
  dict := Dictionary new.
  dict at: 'name' put: aPetriNet name.
  dict at: 'places' put: (aPetriNet places collect: [ :p | 
    Dictionary new
      at: 'name' put: p name;
      at: 'tokens' put: p tokens;
      yourself ]).
  dict at: 'transitions' put: (aPetriNet transitions collect: [ :t | 
    Dictionary new at: 'name' put: t name; yourself ]).
  dict at: 'arcs' put: (aPetriNet arcs collect: [ :a | 
    Dictionary new
      at: 'source' put: a source name;
      at: 'target' put: a target name;
      at: 'weight' put: a weight;
      yourself ]).
  ^ STONJSON toString: dict.

PetriNetJsonExporter >> export: aPetriNet toFile: aFileName
  | string file |
  string := self export: aPetriNet.
  file := StandardFileStream newFileNamed: aFileName.
  file nextPutAll: string.
  file close.