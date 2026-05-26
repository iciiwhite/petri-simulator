Class {
  #name : #InvariantAnalyzer,
  #superclass : #Object,
  #instVars : [
    'net',
    'incidenceMatrix'
  ],
  #category : #'PetriSimulator-Analysis'
}

InvariantAnalyzer >> on: aPetriNet
  net := aPetriNet.

InvariantAnalyzer >> computeIncidenceMatrix
  | placesList transList |
  placesList := net places asOrderedCollection.
  transList := net transitions asOrderedCollection.
  incidenceMatrix := (Array2D rows: placesList size columns: transList size) 
    collect: [ :row :col | 0 ].
  net arcs do: [ :arc | 
    | pIndex tIndex delta |
    (arc source isKindOf: Place) ifTrue: [ 
      pIndex := placesList indexOf: arc source.
      tIndex := transList indexOf: arc target.
      delta := arc weight negated ]
    ifFalse: [ 
      tIndex := transList indexOf: arc source.
      pIndex := placesList indexOf: arc target.
      delta := arc weight ].
    incidenceMatrix at: pIndex at: tIndex put: (incidenceMatrix at: pIndex at: tIndex) + delta ].
  ^ incidenceMatrix.

InvariantAnalyzer >> pInvariants
  ^ self computeIncidenceMatrix.

InvariantAnalyzer >> tInvariants
  ^ incidenceMatrix transpose.