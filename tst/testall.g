LoadPackage("alnuth");
LoadPackage("radiroot");
dirs := DirectoriesPackageLibrary( "alnuth", "tst" );
TestDirectory(dirs, rec(exitGAP := true,
    testOptions:=rec(compareFunction := "uptowhitespace")));
