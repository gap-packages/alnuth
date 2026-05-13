#############################################################################
##
#W userpref.gi         Alnuth - ALgebraic NUmber THeory
##

BindGlobal("AL_DefaultPariGpPath", function()
    local f;

    f := Filename(DirectoriesSystemPrograms(), "gp");
    if f = fail then
        return "";
    fi;

    return f;
end);

BindGlobal("AL_ResolvePariGpPath", function(path)
    local resolved;

    if not IsString(path) or path = "" then
        return fail;
    fi;

    resolved := Filename(DirectoriesSystemPrograms(), path);
    if resolved <> fail and IsExecutableFile(resolved) then
        return resolved;
    fi;

    if IsExecutableFile(path) then
        return path;
    fi;

    return fail;
end);

BindGlobal("AL_SuitablePariGpPath", function(path)
    local resolved, str, version;

    if path = "" then
        return true;
    fi;

    resolved := AL_ResolvePariGpPath(path);
    if resolved = fail then
        return false;
    fi;

    str := "";
    Process(DirectoryCurrent(), resolved, InputTextNone(),
            OutputTextString(str, false), [ "--version-short" ]);
    if str = "" then
        return false;
    fi;
    version := Chomp(str);
    return CompareVersionNumbers(version, "2.5");
end);

BindGlobal("AL_WarnAboutObsoleteGlobals", function()
    local obsolete, names, name;

    names := [ "AL_EXECUTABLE", "AL_PATH", "AL_OPTIONS",
               "AL_STACKSIZE", "PRIM_TEST" ];
    obsolete := [];

    for name in names do
        if IsBoundGlobal(name) then
            Add(obsolete, name);
        fi;
    od;

    if Length(obsolete) > 0 then
        Info(InfoWarning, 1,
             "Alnuth no longer supports the global variables ",
             JoinStringsWithSeparator(obsolete, ", "),
             ". Use SetUserPreference(\"alnuth\", ...) instead; see the manual ",
             "for the new preference names.");
    fi;

    return obsolete;
end);

BindGlobal("AL_CurrentPariGpPath", function()
    local path;

    path := AL_ResolvePariGpPath(UserPreference("alnuth", "PariGpPath"));
    if path <> fail then
        return path;
    fi;

    if IsBoundGlobal("AL_EXECUTABLE")
       and AL_SuitablePariGpPath(VALUE_GLOBAL("AL_EXECUTABLE")) then
        return AL_ResolvePariGpPath(VALUE_GLOBAL("AL_EXECUTABLE"));
    fi;

    return fail;
end);

BindGlobal("AL_CurrentPariGpOptions", function()
    local options;

    options := UserPreference("alnuth", "PariGpOptions");
    if IsList(options) and ForAll(options, IsString) then
        return options;
    fi;

    if IsBoundGlobal("AL_OPTIONS")
       and IsList(VALUE_GLOBAL("AL_OPTIONS"))
       and ForAll(VALUE_GLOBAL("AL_OPTIONS"), IsString) then
        return VALUE_GLOBAL("AL_OPTIONS");
    fi;

    return [ "-f", "-q" ];
end);

BindGlobal("AL_LegacyStackSize", function()
    local val, digits;

    if not IsBoundGlobal("AL_STACKSIZE") then
        return fail;
    fi;

    val := VALUE_GLOBAL("AL_STACKSIZE");
    if IsPosInt(val) then
        return val;
    fi;

    if IsString(val) and Length(val) >= 4 and val[1] = '-' and val[2] = 's'
       and val[Length(val)] = 'M' then
        digits := val{[3 .. Length(val) - 1]};
        if ForAll(digits, ch -> ch in "0123456789") then
            return Int(digits);
        fi;
    fi;

    return fail;
end);

BindGlobal("AL_CurrentPariStackSize", function()
    local size;

    size := UserPreference("alnuth", "PariStackSize");
    if IsPosInt(size) then
        return size;
    fi;

    size := AL_LegacyStackSize();
    if size <> fail then
        return size;
    fi;

    return 128;
end);

BindGlobal("AL_CurrentPrimitiveElementTrials", function()
    local trials;

    trials := UserPreference("alnuth", "PrimitiveElementTrials");
    if IsPosInt(trials) then
        return trials;
    fi;

    if IsBoundGlobal("PRIM_TEST") and IsPosInt(VALUE_GLOBAL("PRIM_TEST")) then
        return VALUE_GLOBAL("PRIM_TEST");
    fi;

    return 20;
end);

DeclareUserPreference(rec(
  package := "alnuth",
  name := "PariGpPath",
  description := [
"""is the command or path for the PARI/GP executable used by Alnuth.

The default searches for a program named <C>gp</C> in
<C>DirectoriesSystemPrograms()</C>. Set this preference if PARI/GP is
installed elsewhere or should be invoked with a different executable name.
An empty string disables the PARI/GP backend until a usable executable is
configured.
"""],
  default := AL_DefaultPariGpPath,
  check := x -> IsString(x) and AL_SuitablePariGpPath(x)
));

DeclareUserPreference(rec(
  package := "alnuth",
  name := "PariGpOptions",
  description := [
"""are the command line options passed to PARI/GP for every Alnuth call.

The default disables user startup files and the interactive prompt. In normal
use there is no need to change this preference.
"""],
  default := ["-f", "-q"],
  check := x -> IsList(x) and ForAll(x, IsString)
));

DeclareUserPreference(rec(
  package := "alnuth",
  name := "PariStackSize",
  description := [
"""is the stack size in megabytes requested from PARI/GP.

The value is translated into a <C>-s...</C> command line argument when
Alnuth starts PARI/GP. It must be a positive integer.
"""],
  default := 128,
  check := IsPosInt
));

DeclareUserPreference(rec(
  package := "alnuth",
  name := "PrimitiveElementTrials",
  description := [
"""is the number of random trials used when Alnuth searches for a primitive
element with a small defining polynomial.

Larger values may produce nicer defining polynomials at the cost of more work.
"""],
  default := 20,
  check := IsPosInt
));
