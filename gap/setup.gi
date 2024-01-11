#############################################################################
##
#W setup.gi         Alnuth - ALgebraic NUmber THeory        Andreas Distler
##

#############################################################################
##
#F SetPariStackSize( size )
##
InstallGlobalFunction( SetPariStackSize, function( size )

    # test input
# TODO: is this check still needed? the user prefs code also does checks...
    if not IsPosInt( size ) then 
        ErrorNoReturn("<size>, the amount of memory in MB, must be a positive integer");
    fi;

    # set global variable to given value
    SetUserPreference("alnuth", "AL_STACKSIZE", size);

end );

#############################################################################
##
#F SetAlnuthExternalExecutable( path )
##
InstallGlobalFunction( SetAlnuthExternalExecutable, function( path )

# TODO: this should probably be part of the userprefs `check` function?

    # tests wether there is an executable file behind <path>
    if Filename( DirectoriesSystemPrograms( ), path ) = fail and
       not IsExecutableFile( path ) then
        ErrorNoReturn( "<path> has to be an executable" );
    fi;
    
    if not IsExecutableFile( path ) then
        path := Filename( DirectoriesSystemPrograms( ), path );
        if not IsExecutableFile( path ) then
            Info( InfoWarning, 1, "No permission to execute ", path );
            return fail;
        fi;
    fi;

    if AL_SuitablePariExecutable(path) then
        SetUserPreference("alnuth", "AL_EXECUTABLE", path);
        return path;
    else
        return fail;
    fi;
end );

#############################################################################
##
#F AL_SuitablePariExecutable( path )
##
InstallGlobalFunction( AL_SuitablePariExecutable, function( path )
    local str, pos, version;

# TODO: this should probably be part of the userprefs `check` function?

    # try to find out, if it is a suitable version of PARI/GP
    str := "";
    Process( DirectoryCurrent( ), path, InputTextNone( ),
             OutputTextString( str, false ), [ "-f" ] );
    if PositionSublist( str, "PARI" ) = fail then
        Info(InfoWarning, 1, path,
             " does not seem to be an executable for PARI/GP.");
        return false;
    fi;

    pos := PositionSublist( str, "Version " );
    if pos = fail then
        Info(InfoWarning, 1, path,
             " does not seem to be an executable for PARI/GP.");
        return false;
    else
        # go to beginning of version number
        pos := pos + 8;
    fi;

    # check version number, should be 2.5.X, has to be at least 2.3.X 
    version := str{[ pos..pos+PositionProperty(str{[ pos..Length(str) ]},
                                               char-> char = ' ') - 2 ]};
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

    exe := UserPreference("alnuth", "AL_EXECUTABLE");
    if IsExecutableFile(exe) then
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
# TODO
   # SetAlnuthExternalExecutable( path );
    
    Error("TODO: explain how to use WriteGapIniFile ");
end );

#############################################################################
##
#F RestoreAlnuthExternalExecutablePermanently( )
##
InstallGlobalFunction( RestoreAlnuthExternalExecutablePermanently, function( )
# TODO
    Error("TODO: explain how to use WriteGapIniFile ");
end );

#############################################################################
##
#E