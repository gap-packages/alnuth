LoadPackage("alnuth");
LoadPackage("radiroot");

# ensure name of indeterminate matches the manual
x := Indeterminate(Rationals, "x");

dirs := DirectoriesPackageLibrary( "alnuth", "tst" );
TestDirectory(dirs, rec(exitGAP := true,
    testOptions:=rec(compareFunction := "uptowhitespace")));
