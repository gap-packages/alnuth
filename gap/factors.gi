############################################################################
##
#W  factors.gi            Alnuth - Kant interface            Andreas Distler
##


#############################################################################
##
#M  IrrFacsAlgExtPol(<f>) . . . . . lists of irreducible factors of rational 
##                  polynomial over algebraic extensions, initialize default
##
InstallOtherMethod(IrrFacsAlgExtPol,true,[IsPolynomial],0,f -> []);
                                                                               

#############################################################################
##
#F  StoreFactorsAlgExtPol( <pring>, <upol>, <factlist> ) . store factors list
##
InstallGlobalFunction(StoreFactorsAlgExtPol,function(R,f,fact)
local irf;
  irf:=IrrFacsAlgExtPol(f);
  if not ForAny(irf,i->i[1]=R) then
    Add(irf,[R,fact]);
  fi;
end);
                                                                               
#############################################################################
##
#F  FactorsPolynomialKant, function( <H>, <poly> )
##
##  Factorizes the rational polynomial <poly> over the field <H>, a proper
##  algebraic extension of the rationals, with KANT
##
InstallGlobalFunction( FactorsPolynomialKant, function( H, poly )
    local faktoren, fak, coeff, c, lcoeff, irf, i;

    if FieldOfPolynomial( poly ) <> Rationals then
        Error( "polynomial has to be defined over the Rationals" );
    fi;
                          
    if H = Rationals then 
        return Factors( poly );
    fi;

    irf := IrrFacsAlgExtPol( poly );
    i := PositionProperty( irf, k -> k[1] = H );
    if i <> fail  then
        return irf[i][2];
    fi;
  
    faktoren := [ ];
    lcoeff := LeadingCoefficient( poly );
    poly := poly / lcoeff;
    for fak in PolynomialFactorsDescriptionKant(poly,DefiningPolynomial(H)) do
        coeff := [ ];
        for c in Reversed( fak ) do
            if ( c in Rationals ) then
                Add( coeff, c );
            else
                Add( coeff, LinearCombination( Basis(H), c ) );
            fi;
        od;
        Add( faktoren, UnivariatePolynomial( H, One(H)*coeff ) );
    od;
    faktoren[1] := lcoeff * faktoren[1];
    StoreFactorsAlgExtPol( H, poly, faktoren );

    return faktoren;
end );
                                                                       
#############################################################################
##
#E
