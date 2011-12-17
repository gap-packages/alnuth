#############################################################################
##
#W  polfield.gi        Alnuth -  Kant interface                  Bettina Eick
#W                                                             Bjoern Assmann
##

#############################################################################
##
#F FieldOfPolynomial(f)
##
FieldOfPolynomial := function(f)
    local c;
    c := CoefficientsOfUnivariatePolynomial(f);
    return Field(c);
end;

#############################################################################
##
#F FieldByPolynomial( f )
##
InstallGlobalFunction( FieldByPolynomialNC, function( f )
    local F; 
    if not ForAll( CoefficientsOfUnivariatePolynomial(f), IsInt ) then
        Error("kant only accepts polynomials with integral coefficients");
        return fail;
    fi;
    F := FieldExtension( Rationals, f );
    SetIsNumberFieldByPolynomial( F, true );
    return F;
end );

InstallGlobalFunction( FieldByPolynomial, function( f )
    if DegreeOfUnivariateLaurentPolynomial(f) <= 0 then 
        Print("polynomial must have degree at least 1\n");
        return fail;
    fi;
    if Length(Factors(f)) > 1 then 
        Print("polynomial must be irreducible\n");
        return fail; 
    fi;
    if FieldOfPolynomial(f) <> Rationals then 
        Print("polynomial must be defined over Q \n");
        return fail; 
    fi;
    return FieldByPolynomialNC(f);
end );

#############################################################################
##
#F EquationOrderBasisOfFieldByPolynomial( F )
#M EquationOrderBasis( F )
##
EquationOrderBasisOfFieldByPolynomial := function( F )
    local k, d;
    k := RootOfDefiningPolynomial(F);  
    d := DegreeOverPrimeField( F );
    return List( [1..d], x -> k^(x-1) );
end; 

InstallMethod( EquationOrderBasis, "for polynomial field", true,
[IsNumberFieldByPolynomial], 0, 
function( F )     
    local B, b,c,T;
    c := CanonicalBasis(F);
    b := EquationOrderBasisOfFieldByPolynomial( F );
    T := List( b, x->Coefficients( c, x));  
    B := Objectify(NewType(FamilyObj(F), IsBasisOfFieldByPolynomial), rec());
    SetUnderlyingLeftModule( B, F );
    SetBasisVectors( B, b );
    SetUnderlyingBasis( B, c );
    SetTranslationMat( B, T^-1);
    return B;
end );


#############################################################################
##
#M Coefficients( B, a )
##
InstallMethod( Coefficients, "for basis of matrix field", true,
[IsBasisOfNumberField and HasTranslationMat, IsVector ], 0,
function( B, a )
    local b, T, c;
    b := UnderlyingBasis( B );
    T := TranslationMat( B ); 
    c := Coefficients( b, a );
    return c * T;
end );


 











