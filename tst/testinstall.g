LoadPackage("alnuth");
dirs := DirectoriesPackageLibrary( "alnuth", "tst" );
tests := [
    "version.tst",
    "ALNUTH.tst",
];
tests := List(tests, f -> Filename(dirs,f));
TestDirectory(tests, rec(exitGAP := true));
