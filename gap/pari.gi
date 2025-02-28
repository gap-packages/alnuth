#############################################################################
##
#W pari.gi          Alnuth - ALgebraic NUmber THeory           Bettina Eick
#W                                                           Bjoern Assmann
#W                                                          Andreas Distler
##

#############################################################################
##
#F PolynomialWithNameToStringList( f[, name] )
##
BindGlobal("PolynomialWithNameToStringList", function( arg )
    local c, f, stringlist, i;

    # get input
    f := arg[1];

    # print identifier of polynomial, default 'f', or given as second argument
    if Length( arg ) = 1 then
        stringlist := ["f = "];
    else
        stringlist := Concatenation(arg[2], " = ");
    fi;

    # print polynomial using 'x' as variable
    c := CoefficientsOfUnivariatePolynomial( f );
    for i in [1..Length(c)] do
        if c[i] >= 0 and i > 1 then 
            Add(stringlist, "+"); 
        fi;
        Add(stringlist, Concatenation(String(c[i]), "*x^", String(i-1)));
    od;
    Add(stringlist,";\n");

    return stringlist; 
end);

#############################################################################
##
#F CoefficientsToStringList(name, coeffs)
##
BindGlobal("CoefficientsToStringList", function(name, coeffs)
    local stringlist, c;

    stringlist := ["{"];
    Add(stringlist, name);
    Add(stringlist, "= [ \n");
    for c in coeffs do
        Add(stringlist, String(c));
        Add(stringlist, ", \n");
    od;
    Add(stringlist, "0]; }\n");

    return stringlist;
end);

#############################################################################
##
#F ProcessPariGP(input, codefile)
##
BindGlobal("ProcessPariGP", function(input, codefile)
    local output, paricode;

    # test, wether AL_EXECUTABLE is set
    if AL_EXECUTABLE = fail then
        Error( "AL_EXECUTABLE, the executable for PARI/GP, has to be set" );
    fi;

    # add the prepared code fragments for the calculations in PARI/GP
    paricode := InputTextFile(Filename(AL_PATH, codefile));

    # execute PARI/GP
    Info(InfoAlnuth, 1, "executing PARI/GP with ", codefile);
    output := "";
    Process(DirectoryCurrent(), AL_EXECUTABLE, 
            InputTextString(Concatenation(input, ReadAll(paricode))),
            OutputTextString(output,false), 
            Concatenation(AL_OPTIONS, [AL_STACKSIZE])
           );

    # close open input stream from file with GP code
    CloseStream(paricode);

    return EvalString(output);
end);

#############################################################################
##
#F MaximalOrderDescriptionPari( F )
##
BindGlobal("MaximalOrderDescriptionPari", function( F )
    local input, result;
 
    if IsPrimeField(F) then return [1]; fi;

    # initialize list of input strings with the defining polynomial
    input := PolynomialWithNameToStringList(IntegerDefiningPolynomial(F));

    # execute PARI/GP
    result := ProcessPariGP(Concatenation(input), "maxord.gp");

    # return result
    return result;
end);

#############################################################################
##
#F UnitGroupDescriptionPari( F )
##
BindGlobal("UnitGroupDescriptionPari", function( F )
    local input, result;

    if IsPrimeField( F ) then return [-1]; fi;
    
    # initialize list of input strings with the defining polynomial
    input := PolynomialWithNameToStringList(IntegerDefiningPolynomial(F));

    # execute PARI/GP
    result := ProcessPariGP(Concatenation(input), "units.gp");

    # return result
    return result;
end);

#############################################################################
##
#F ExponentsOfUnitsDescriptionWithRankPari( F, elms )
##
BindGlobal("ExponentsOfUnitsDescriptionWithRankPari",
function( F, elms )
    local input, e, result;

    if IsPrimeField( F ) then return fail; fi;

    # initialize list of input strings with the defining polynomial
    input := PolynomialWithNameToStringList(IntegerDefiningPolynomial(F));

    # add coefficients of <elms>
    input := Concatenation(input, CoefficientsToStringList("elms", elms));

    # execute PARI/GP
    result := ProcessPariGP(Concatenation(input), "decompra.gp");

    # return result
    return rec(units := result[1], expns := result[2], rank := result[3]);
end);

#############################################################################
##
#F ExponentsOfFractionalIdealDescriptionPari( F, elms )
##
## <elms> are arbitrary elements of F (or rather their coefficients).
## Returns the exponents vectors of the fractional ideals
## generated by elms corresponding to the underlying prime ideals.
##
BindGlobal( "ExponentsOfFractionalIdealDescriptionPari", 
function( F, elms )
    local input, e, result;

    if IsPrimeField( F ) then return fail; fi;

    # initialize list of input strings with the defining polynomial
    input := PolynomialWithNameToStringList(IntegerDefiningPolynomial(F));

    # add coefficients of <elms>
    input := Concatenation(input, CoefficientsToStringList("elms", elms));
 
    # execute PARI/GP
    result := ProcessPariGP(Concatenation(input), "fracidea.gp");

    # return result
    return result;
end);

#############################################################################
##
#F NormCosetsDescriptionPari( F, norm )
##
BindGlobal( "NormCosetsDescriptionPari", function( F, norm )
    local input, result;

    if IsPrimeField(F) then return fail; fi;

    # initialize list of input strings with the defining polynomial
    input := PolynomialWithNameToStringList(IntegerDefiningPolynomial(F));

    # add norm information
    Add(input, "nrm = ");
    Add(input, String(norm));
    Add(input, "; \n");

    # execute PARI/GP
    result := ProcessPariGP(Concatenation(input), "norm.gp");

    # return result
    return rec(units := result[1], creps := result[2]);
end);

#############################################################################
##
#F  PolynomialFactorsDescriptionPari, function( <F>, <coeffs> )
##
##  Factorizes the polynomial defined by <coeffs> over the field <F>
##  using PARI/GP
##
BindGlobal( "PolynomialFactorsDescriptionPari", function( F, coeffs )
    local input, c, result, runtime;
                                                                               
    # initialize list of input strings with the defining polynomial
    input := PolynomialWithNameToStringList(IntegerDefiningPolynomial(F));

    # add the coefficients of the polynomial to be factorised
    input := Concatenation(input, CoefficientsToStringList("coeffs", coeffs));
 
    # execute PARI/GP
    result := ProcessPariGP(Concatenation(input), "polyfactors.gp");

    # print runtime
    runtime := Remove(result);
    Info(InfoAlnuth, 1, "Runtime: ", runtime);

    # return result
    return result;
end );

BindGlobal("PARI_AL_FUNCS", rec(
    MaximalOrderDescription := MaximalOrderDescriptionPari,
    UnitGroupDescription := UnitGroupDescriptionPari,
    ExponentsOfUnitsDescriptionWithRank := ExponentsOfUnitsDescriptionWithRankPari,
    ExponentsOfFractionalIdealDescription := ExponentsOfFractionalIdealDescriptionPari,
    NormCosetsDescription := NormCosetsDescriptionPari,
    PolynomialFactorsDescription := PolynomialFactorsDescriptionPari,
));

AL_FUNCS := PARI_AL_FUNCS;
