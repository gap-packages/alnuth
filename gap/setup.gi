#############################################################################
##
#W setup.gi         Alnuth - ALgebraic NUmber THeory        Andreas Distler
##

BindGlobal("AL_InfoDeprecatedWrapper", function(name, replacement)
    Info(InfoObsolete, 1,
         "The function `", name, "` is deprecated. Use ", replacement,
         " instead.");
end);

#############################################################################
##
#F SetPariStackSize( size )
##
InstallGlobalFunction( SetPariStackSize, function( size )

    if not IsPosInt( size ) then 
        ErrorNoReturn("<size>, the amount of memory in MB, must be a positive integer");
    fi;

    SetUserPreference("alnuth", "PariStackSize", size);

end );

#############################################################################
##
#F SetAlnuthExternalExecutable( path )
##
InstallGlobalFunction( SetAlnuthExternalExecutable, function( path )
    AL_InfoDeprecatedWrapper(
        "SetAlnuthExternalExecutable",
        "SetUserPreference(\"alnuth\", \"PariGpPath\", path)"
    );

    if not AL_SuitablePariExecutable(path) then
        ErrorNoReturn(
            "<path> must name a usable PARI/GP executable in version 2.5 or higher"
        );
    fi;

    SetUserPreference("alnuth", "PariGpPath", path);
    return UserPreference("alnuth", "PariGpPath");
end );

#############################################################################
##
#F AL_SuitablePariExecutable( path )
##
InstallGlobalFunction( AL_SuitablePariExecutable, function( path )
    local resolved, version;

    if path = "" then
        return true;
    fi;

    resolved := AL_ResolvePariGpPath(path);
    if resolved = fail then
        Info(InfoWarning, 1, path, " is not an executable file.");
        return false;
    fi;

    version := "";
    Process(DirectoryCurrent(), resolved, InputTextNone(),
            OutputTextString(version, false), [ "--version-short" ]);
    version := Chomp(version);

    if version = "" then
        Info(InfoWarning, 1, path,
             " does not seem to be an executable for PARI/GP.");
        return false;
    fi;
    if not CompareVersionNumbers(version, "2.5") then
        Info( InfoWarning, 1, path,
             " seems to be an executable for PARI/GP Version ",
             version, ", but Alnuth needs PARI/GP Version 2.5 or higher." );
        return false;
    fi;

    return true;
end );


#############################################################################
##
#F PariVersion( )
##
InstallGlobalFunction( PariVersion, function( )
    local exe, str;

    exe := AL_CurrentPariGpPath();
    if exe <> fail then
        # use the command line option to obtain version number of PARI/GP
        str := "";
        Process( DirectoryCurrent( ), exe, InputTextNone( ),
                 OutputTextString( str, false ), [ "--version-short" ] );
        Print( str );
    fi;
end );

#############################################################################
##
#F SetAlnuthExternalExecutablePermanently( path )
##
InstallGlobalFunction( SetAlnuthExternalExecutablePermanently, function( path )
    AL_InfoDeprecatedWrapper(
        "SetAlnuthExternalExecutablePermanently",
        "SetUserPreference(\"alnuth\", \"PariGpPath\", path); WriteGapIniFile()"
    );

    if not AL_SuitablePariExecutable(path) then
        ErrorNoReturn(
            "<path> must name a usable PARI/GP executable in version 2.5 or higher"
        );
    fi;

    SetUserPreference("alnuth", "PariGpPath", path);
    WriteGapIniFile();
    return UserPreference("alnuth", "PariGpPath");
end );

#############################################################################
##
#F RestoreAlnuthExternalExecutablePermanently( )
##
InstallGlobalFunction( RestoreAlnuthExternalExecutablePermanently, function( )
    AL_InfoDeprecatedWrapper(
        "RestoreAlnuthExternalExecutablePermanently",
        "SetUserPreference(\"alnuth\", \"PariGpPath\", AL_DefaultPariGpPath()); WriteGapIniFile()"
    );

    SetUserPreference("alnuth", "PariGpPath", AL_DefaultPariGpPath());
    WriteGapIniFile();
    return UserPreference("alnuth", "PariGpPath");
end );

#############################################################################
##
#E
