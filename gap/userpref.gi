#############################################################################
##
#W userpref.gi         Alnuth - ALgebraic NUmber THeory
##

DeclareUserPreference(rec(
  package := "alnuth",
  name := "AL_EXECUTABLE",
  description := [
"""the path to the executable of PARI/GP

TODO
"""],
  default := function()
      local f;
      f := Filename(DirectoriesSystemPrograms(), "gp");
      if f = fail then f:=""; fi;
      return f;
    end,
  check := IsString
));

DeclareUserPreference(rec(
  package := "alnuth",
  name := "AL_PATH",
  description := [
"""the directory path to the code files for the external program

TODO
"""],
  default := function()
      local f;
      f := DirectoriesPackageLibrary("alnuth", "gp");
      if f = fail then f:=""; fi;
      return f;
    end,
  check := IsString
));

DeclareUserPreference(rec(
  package := "alnuth",
  name := "AL_OPTIONS",
  description := [
"""options for execution of the external program

TODO
"""],
  default := ["-f", "-q"],
  check := x -> IsList(x) and ForAll(x, IsString)
));

DeclareUserPreference(rec(
  package := "alnuth",
  name := "AL_STACKSIZE",
  description := [
"""extra option to specify stack size for execution of PARI/GP

the amount of memory in MB, must be a positive integer

TODO
"""],
  default := 128,
  check := IsPosInt));

DeclareUserPreference(rec(
  package := "alnuth",
  name := "PRIM_TEST",
  description := [
"""number of trials to find a primitve element with small minimal polynomial

TODO
"""],
  default := 20,
  check := IsPosInt
));
