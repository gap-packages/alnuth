#############################################################################
##
#W   field.gd           Alnuth - Kant interface                  Bettina Eick
#W                                                             Bjoern Assmann
##

DeclareInfoClass( "InfoAlnuth" );

DeclareRepresentation( "IsBasisOfNumberField", 
                        IsBasis and IsAttributeStoringRep, [] );
DeclareRepresentation( "IsBasisOfMatrixField", IsBasisOfNumberField, [] );
DeclareRepresentation( "IsBasisOfFieldByPolynomial", IsBasisOfNumberField, [] );

DeclareOperation( "ExponentsOfUnits", [IsNumberField, IsCollection] );
DeclareOperation( "RelationLattice", [IsNumberField, IsCollection] );

DeclareAttribute( "EquationOrderBasis", IsNumberField );
DeclareAttribute( "MaximalOrderBasis", IsNumberField );
DeclareAttribute( "UnitGroup", IsNumberField );
DeclareAttribute( "DefiningPolynomial", IsNumberField );
DeclareAttribute( "FieldOfUnitGroup", IsGroup );
DeclareAttribute( "TranslationMat", IsBasisOfNumberField );
DeclareAttribute( "UnderlyingBasis", IsBasisOfNumberField );

DeclareProperty( "IsUnitGroup", IsGroup );
DeclareProperty( "IsUnitGroupIsomorphism", IsMapping);
DeclareProperty( "IsNumberFieldByMatrices", IsNumberField );
DeclareProperty( "IsNumberFieldByPolynomial", IsNumberField );
DeclareProperty( "IsMultGroupByFieldElemsIsomorphism", IsMapping);

DeclareGlobalFunction( "FieldByMatricesNC" );
DeclareGlobalFunction( "FieldByMatrixBasisNC" );
DeclareGlobalFunction( "FieldByPolynomialNC" );
DeclareGlobalFunction( "FieldByMatrices" );
DeclareGlobalFunction( "FieldByMatrixBasis" );
DeclareGlobalFunction( "FieldByPolynomial" );
DeclareGlobalFunction( "IntersectionOfUnitSubgroups" );
DeclareGlobalFunction( "IntersectionOfTFUnitsByCosets" );
DeclareGlobalFunction( "NormCosetsOfNumberField" );
DeclareGlobalFunction( "IsUnitOfNumberField" );
DeclareGlobalFunction( "RelationLatticeOfTFUnits");
DeclareGlobalFunction( "RelationLatticeModUnits");
DeclareGlobalFunction( "RelationLatticeTF");
DeclareGlobalFunction( "RelationLatticeOfUnits");
DeclareGlobalFunction( "PcpPresentationMultGroupByFieldEl");
DeclareGlobalFunction( "PcpPresentationOfMultiplicativeSubgroup");
