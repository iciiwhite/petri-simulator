Class {
  #name : #IOTest,
  #superclass : #TestCase,
  #category : #'PetriSimulator-Tests'
}

IOTest >> testJsonRoundtrip
  | original exported imported |
  original := ExampleNets simpleNet.
  exported := PetriNetJsonExporter new export: original.
  imported := PetriNetJsonImporter new importFromString: exported.
  self assert: imported name equals: original name.
  self assert: imported places size equals: original places size.
  self assert: imported transitions size equals: original transitions size.
  self assert: imported arcs size equals: original arcs size.