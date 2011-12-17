#############################################################################
##
#W kantin.gi            Alnuth -  Kant interface                 Bettina Eick
#W                                                             Bjoern Assmann
##

#############################################################################
##
#V Global variables
##
if not IsBound( KANTVars )    then KANTVars   := false; fi;
if not IsBound( KANTVart )    then KANTVart   := false; fi;
if not IsBound( KANTVaru )    then KANTVaru   := false; fi;

#############################################################################
##
#F PrintPolynomialToFile( file, f )
##
PrintPolynomialToFile := function( file, f )
    local c, i;
    PrintTo( file, "f := ");
    c := CoefficientsOfUnivariatePolynomial( f );
    for i in [1..Length(c)] do
        if c[i] >= 0 and i > 1 then AppendTo( file, "+"); fi;
        AppendTo( file, c[i],"*x^",i-1," ");
    od; 
    AppendTo( file,"; \n \n"); 
end;

#############################################################################
##
#F MaximalOrderDescriptionKant( F )
##
MaximalOrderDescriptionKant := function( F )
    local file, inpt, outt, trsh, f;
 
    if IsPrimeField(F) then return [1]; fi;

    # get the path to the kant directory
    file := Concatenation( KANTOUTPUT, "kant.tmp" );
    inpt := Concatenation( KANTOUTPUT, "kant.input" );
    outt := Concatenation( KANTOUTPUT, "kant.output");
    trsh := Concatenation( KANTOUTPUT, "kant.trash");

    # compute generating polynomial and print it
    f := DefiningPolynomial(F);
    PrintPolynomialToFile( file, f );
    AppendTo( file, "outt := \"", outt,"\"; \n \n");

    # execute kant
    Info( InfoAlnuth, 1, "executing Kant");
    Exec(Concatenation( "cat ",file," ",ALNUTHPATH,"maxord.kt > ", inpt ));
    Exec(Concatenation(KANTEXEC, " < ",inpt," > ", trsh));

    # read results
    Info( InfoAlnuth, 1, "reading Kant-results into Gap \n");
    Read(outt);

    # delete junk
    Exec(Concatenation("rm ",inpt," ",outt," ",file," ",trsh));

    # return info
    return KANTVars;
end;

#############################################################################
##
#F UnitGroupDescriptionKant( F )
##
UnitGroupDescriptionKant := function( F )
    local file, inpt, outt, exec, trsh, f;

    if IsPrimeField( F ) then return [-1]; fi;
    
    # get the path to the kant directory
    file := Concatenation( KANTOUTPUT, "kant.tmp" );
    inpt := Concatenation( KANTOUTPUT, "kant.input" );
    outt := Concatenation( KANTOUTPUT, "kant.output");
    trsh := Concatenation( KANTOUTPUT, "kant.trash");

    # compute generating polynomial and print it
    f := DefiningPolynomial( F );
    PrintPolynomialToFile( file, f );
    AppendTo( file, "outt := \"", outt,"\"; \n \n");

    # execute kant
    Info( InfoAlnuth, 1, "executing Kant");
    Exec(Concatenation( "cat ",file," ",ALNUTHPATH,"units.kt > ", inpt ));
    Exec(Concatenation(KANTEXEC, " < ",inpt," > ", trsh));

    # read results
    Info( InfoAlnuth, 1, "reading Kant-results into Gap \n");
    Read(outt);

    # delete junk
    Exec(Concatenation("rm ",inpt," ",outt," ",file," ",trsh));

    # return
    return KANTVars;
end;


#############################################################################
##
#F ExponentsOfUnitsDescriptionKant( F, elms )
##
ExponentsOfUnitsDescriptionKant := function( F, elms )
    local file, inpt, outt, trsh, f, e;

    if IsPrimeField( F ) then return fail; fi;

    # get the path to the kant directory
    file := Concatenation( KANTOUTPUT, "kant.tmp" );
    inpt := Concatenation( KANTOUTPUT, "kant.input" );
    outt := Concatenation( KANTOUTPUT, "kant.output");
    trsh := Concatenation( KANTOUTPUT, "kant.trash");
    
    # compute generating polynomial
    f := DefiningPolynomial( F );
    PrintPolynomialToFile( file, f );

    # print elms to file
    AppendTo( file, "elms := [ \n");
    for e in elms do AppendTo( file, e,", \n"); od;
    AppendTo( file, "]; \n \n");
    AppendTo( file, "outt := \"", outt,"\"; \n \n");

    # execute kant
    Info( InfoAlnuth, 1, "executing Kant");
    Exec(Concatenation( "cat ",file," ",ALNUTHPATH,"decomp.kt > ", inpt ));
    Exec(Concatenation(KANTEXEC, " < ",inpt," > ", trsh));

    # read results
    Info( InfoAlnuth, 1, "reading Kant-results into Gap \n");
    Read(outt);
    Info( InfoAlnuth, 3, "KANTVars");
    Info( InfoAlnuth, 3, KANTVars);
    Info( InfoAlnuth, 3, "KANTVart");
    Info( InfoAlnuth, 3, KANTVars);


    # delete junk
    Exec(Concatenation("rm ",inpt," ",outt," ",file," ",trsh));

    # return unit group and exponents
    return rec( units := KANTVars, expns := KANTVart );
end;

#############################################################################
##
#F ExponentsOfUnitsDescriptionWithRankKant( F, elms )
##
ExponentsOfUnitsDescriptionWithRankKant := function( F, elms )
    local file, inpt, outt, trsh, f, e;

    if IsPrimeField( F ) then return fail; fi;

    # get the path to the kant directory
    file := Concatenation( KANTOUTPUT, "kant.tmp" );
    inpt := Concatenation( KANTOUTPUT, "kant.input" );
    outt := Concatenation( KANTOUTPUT, "kant.output");
    trsh := Concatenation( KANTOUTPUT, "kant.trash");
    
    # compute generating polynomial
    f := DefiningPolynomial( F );
    PrintPolynomialToFile( file, f );

    # print elms to file
    AppendTo( file, "elms := [ \n");
    for e in elms do AppendTo( file, e,", \n"); od;
    AppendTo( file, "]; \n \n");
    AppendTo( file, "outt := \"", outt,"\"; \n \n");

    # execute kant
    Info( InfoAlnuth, 1, "executing Kant");
    Exec(Concatenation( "cat ",file," ",ALNUTHPATH,"decompra.kt > ", inpt ));
    Exec(Concatenation(KANTEXEC, " < ",inpt," > ", trsh));

    # read results
    Info( InfoAlnuth, 1, "reading Kant-results into Gap \n");
    Read(outt);
    Info( InfoAlnuth, 3, "KANTVars");
    Info( InfoAlnuth, 3, KANTVars);
    Info( InfoAlnuth, 3, "KANTVart");
    Info( InfoAlnuth, 3, KANTVars);


    # delete junk
    Exec(Concatenation("rm ",inpt," ",outt," ",file," ",trsh));

    # return unit group and exponents
    return rec( units := KANTVars, expns := KANTVart, rank:=KANTVaru);
end;

#############################################################################
##
#F ExponentsOfFractionalIdealDescriptionKant( F, elms )
##
## <elms> are arbitrary elements of F.
## Returns the exponents vectors of the fractional ideals
## generated by elms corresponding to the underlying prime ideals.
##
ExponentsOfFractionalIdealDescriptionKant := function( F, elms )
    local file, inpt, outt, trsh, f, e;

    if IsPrimeField( F ) then return fail; fi;

    # get the path to the kant directory
    file := Concatenation( KANTOUTPUT, "kant.tmp" );
    inpt := Concatenation( KANTOUTPUT, "kant.input" );
    outt := Concatenation( KANTOUTPUT, "kant.output");
    trsh := Concatenation( KANTOUTPUT, "kant.trash");
    
    # compute generating polynomial
    f := DefiningPolynomial( F );
    PrintPolynomialToFile( file, f );

    # print elms to file
    AppendTo( file, "elms := [ \n");
    for e in elms do AppendTo( file, e,", \n"); od;
    AppendTo( file, "]; \n \n");
    AppendTo( file, "outt := \"", outt,"\"; \n \n");

    # execute kant
    Info( InfoAlnuth, 1, "executing Kant");
    Exec(Concatenation( "cat ",file," ",ALNUTHPATH,"fracidea.kt > ", inpt ));
    Exec(Concatenation(KANTEXEC, " < ",inpt," > ", trsh));

    # read results
    Info( InfoAlnuth, 1, "reading Kant-results into Gap \n");
    Read(outt);

    # delete junk
    Exec(Concatenation("rm ",inpt," ",outt," ",file," ",trsh));

    # return unit group and exponents
    return KANTVars;
end;

#############################################################################
##
#F NormCosetsDescriptionKant( F, norm )
##
NormCosetsDescriptionKant := function( F, norm )
    local file, inpt, outt, trsh, f;

    if IsPrimeField(F) then return fail; fi;

    # get the path to the kant directory
    file := Concatenation( KANTOUTPUT, "kant.tmp" );
    inpt := Concatenation( KANTOUTPUT, "kant.input" );
    outt := Concatenation( KANTOUTPUT, "kant.output");
    trsh := Concatenation( KANTOUTPUT, "kant.trash");

    # compute generating polynomial and print it
    f := DefiningPolynomial( F );
    PrintPolynomialToFile( file, f );
    AppendTo( file, "norm := ",norm,"; \n");
    AppendTo( file, "outt := \"", outt,"\"; \n \n");

    # execute kant
    Info( InfoAlnuth, 1, "executing Kant");
    Exec(Concatenation( "cat ",file," ",ALNUTHPATH,"norm.kt > ", inpt ));
    Exec(Concatenation(KANTEXEC, " < ",inpt," > ", trsh));

    # read results
    Info( InfoAlnuth, 1, "reading Kant-results into Gap \n");
    Read(outt);

    # delete junk
    Exec(Concatenation("rm ",inpt," ",outt," ",file," ",trsh));

    # return unit group and exponents
    return rec( units := KANTVars, creps := KANTVart );
end;









