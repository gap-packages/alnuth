#############################################################################
##
#W    init.g       Alnuth -  Kant interface                      Bettina Eick
##

DeclarePackage( "alnuth", "1.0", function() return true; end );
DeclarePackageDocumentation( "alnuth", "doc" );

#############################################################################
##
#R  read .gd files
##
ReadPkg("alnuth/gap/field.gd");
ReadPkg("alnuth/gap/kantin.gd");

#############################################################################
##
#R  read other packages
##
RequirePackage("polycyclic");

