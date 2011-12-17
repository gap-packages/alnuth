#############################################################################
##
#W kantin.gi            Alnuth -  Kant interface                 Bettina Eick
#W                                                             Bjoern Assmann
#W                                                            Andreas Distler
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
#F TestKantExecutable( path )
##
InstallGlobalFunction( TestKantExecutable, function( path )
    local str, pos;

    # tests wether there is an executable file behind <path>
    while Filename( DirectoriesSystemPrograms( ), path ) = fail and
       not IsExecutableFile( path ) do
        Error( "<path> has to be an executable" );
    od;
    
    if not IsExecutableFile( path ) then
        path := Filename( DirectoriesSystemPrograms( ), path );
    fi;

    # try to find out, if it's a proper KANT-version
    str := "";
    Process( DirectoryCurrent( ), path, InputTextNone( ),
             OutputTextString( str, false ), [ ] );
    if PositionSublist( str, "KANT" ) = fail then
        Error( "<path> has to be an executable for KASH" );
    fi; 

    # check version number, must be higher than 2.4
    pos := PositionSublist( str, "Version " );
    if pos = fail then
        Error( "<path> has to be an executable for KASH" );
    fi;

    if str[ pos+8 ] < '2' then
        Error("<path> has to be an executable for KASH Version 2.4. or higher");
    elif str[ pos+8 ] = '2' then
        if str[ pos+10 ] < '4' then
            Error("<path> has to be an executable for KASH Version 2.4. or higher");
        fi;
    fi;

    return path;
end );

#############################################################################
##
#F SetKantExecutable( path )
##
InstallGlobalFunction( SetKantExecutable, function( path )

    path := TestKantExecutable( path );
    MakeReadWriteGlobal( "KANTEXEC" );
    KANTEXEC := path;
    MakeReadOnlyGlobal( "KANTEXEC" );
end );

#############################################################################
##
#F SetKantExecutablePermanently( path )
##
InstallGlobalFunction( SetKantExecutablePermanently, function( path )

    SetKantExecutable( path );
    PrintTo( Concatenation( PackageInfo("alnuth")[1].InstallationPath,
                            "/defs.g" ),
             "###########################################################",
             "##################\n##\n##  KANTEXEC\n##\n## Set 'KANTEXEC'",
             " to the name of the executable of KANT\n##  the default",
             " is fail, if for any reason there is no KANT available\n##\n",
             "if not IsBound( KANTEXEC ) then\n",
             "    BindGlobal( \"KANTEXEC\", \"", KANTEXEC,"\" );\n",
             "fi;");
end );

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

    # test, wether KANTEXEC is set
    if KANTEXEC = fail then
        Error( "KANTEXEC, the executable for Kant, have to be set" );
    fi; 

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
    
    # test, wether KANTEXEC is set
    if KANTEXEC = fail then
        Error( "KANTEXEC, the executable for Kant, have to be set" );
    fi; 

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
    Info( InfoAlnuth, 1, "reading Kant-results into Gap");
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

    # test, wether KANTEXEC is set
    if KANTEXEC = fail then
        Error( "KANTEXEC, the executable for Kant, have to be set" );
    fi; 

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
    Info( InfoAlnuth, 1, "reading Kant-results into Gap");
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

    # test, wether KANTEXEC is set
    if KANTEXEC = fail then
        Error( "KANTEXEC, the executable for Kant, have to be set" );
    fi; 

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
    Info( InfoAlnuth, 1, "reading Kant-results into Gap");
    Read(outt);
    Info( InfoAlnuth, 3, "KANTVars");
    Info( InfoAlnuth, 3, KANTVars);
    Info( InfoAlnuth, 3, "KANTVart");
    Info( InfoAlnuth, 3, KANTVars);


    # delete junk
    if InfoLevel( InfoAlnuth ) < 3 then
        Exec(Concatenation("rm ",inpt," ",outt," ",file," ",trsh));
    fi;

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

    # test, wether KANTEXEC is set
    if KANTEXEC = fail then
        Error( "KANTEXEC, the executable for Kant, have to be set" );
    fi; 

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
    Info( InfoAlnuth, 1, "reading Kant-results into Gap ");
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

    # test, wether KANTEXEC is set
    if KANTEXEC = fail then
        Error( "KANTEXEC, the executable for Kant, have to be set" );
    fi; 

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
    Info( InfoAlnuth, 1, "reading Kant-results into Gap");
    Read(outt);

    # delete junk
    Exec(Concatenation("rm ",inpt," ",outt," ",file," ",trsh));

    # return unit group and exponents
    return rec( units := KANTVars, creps := KANTVart );
end;


#############################################################################
##
#F PrintPolynomialWithNameToFile( file, f, str )
##
PrintPolynomialWithNameToFile := function( file, f, name )
    local c, i;
    AppendTo( file, name, " := ");
    c := CoefficientsOfUnivariatePolynomial( f );
    for i in [1..Length(c)] do
        if c[i] >= 0 and i > 1 then AppendTo( file, "+"); fi;
        AppendTo( file, c[i],"*x^",i-1," ");
    od;
    AppendTo( file,"; \n \n");
end;
                                                                               

#############################################################################
##
#F  PolynomialFactorsDescriptionKant, function( <poly>, <f>)
##
##  Factorizes the polynomial <poly> in the field generated by <f>
##  with KANT
##
InstallGlobalFunction( PolynomialFactorsDescriptionKant, function( poly, f )
    local file, inpt, outt, trsh, tmpdir;
                                                                               
    # test, wether KANTEXEC is set
    if KANTEXEC = fail then
        Error( "KANTEXEC, the executable for Kant, have to be set" );
    fi; 

    # get the path to the kant directory
    tmpdir := DirectoryTemporary( );
    file := Filename( tmpdir, "kant.tmp" );
    inpt := Filename( tmpdir, "kant.input" );
    outt := Filename( tmpdir, "kant.output");
    trsh := Filename( tmpdir, "kant.trash");
                                                                               
    # print the polynomials
    PrintPolynomialWithNameToFile( file, f, "f" );
    PrintPolynomialWithNameToFile( file, poly, "poly" );
    AppendTo( file, "outt := \"", outt,"\"; \n \n");

    # execute kant
    Info( InfoAlnuth, 1, "executing Kant");
    Exec(Concatenation( "cat ",file," ",ALNUTHPATH,"polyfactors.kt > ", inpt));
    Exec(Concatenation(KANTEXEC, " < ",inpt," > ", trsh));
                                                                               
    # read results
    Info( InfoAlnuth, 1, "reading Kant-results into Gap");
    Read(outt);
    Info( InfoAlnuth, 1, "Runtime: ", KANTVars[ Length( KANTVars ) ] );
    Unbind( KANTVars[ Length( KANTVars ) ] ); 
                                                                               
    # delete junk
    Exec( "rm -r ", Filename( tmpdir, "" ));

    # return info
    return KANTVars;
end );


#############################################################################
##
#F  FactorsPolynomialKant, function( <poly>, <H> )
##
##  Factorizes the rational polynomial <poly> in the field <H>, a proper
##  algebraic extension of the rationals, with KANT
##
InstallGlobalFunction( FactorsPolynomialKant, function( poly, H )
    local faktoren, fak, coeff, c, lcoeff;
                                                                               
    if H = Rationals then return Factors( poly ); fi;

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

    return faktoren;
end );
                                                                       
#############################################################################
##
#E
                                                                               


