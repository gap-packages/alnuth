LoadPackage("alnuth");

# ensure name of indeterminate matches the manual
x := Indeterminate(Rationals, "x");

dirs := DirectoriesPackageLibrary( "alnuth", "tst" );
tests := [
    "version.tst",
    "ALNUTH.tst",
];
tests := List(tests, f -> Filename(dirs,f));
TestDirectory(tests, rec(exitGAP := true));
