#############################################################################
##
#W  init.g          Alnuth - ALgebraic NUmber THeory           Bettina Eick
#W                                                          Andreas Distler
##

#############################################################################
##
#R  read .gd files
##
ReadPackage("alnuth", "gap/setup.gd");
ReadPackage("alnuth", "gap/factors.gd");
ReadPackage("alnuth", "gap/field.gd");
if not IsPackageMarkedForLoading("OscarInterface", "") then
    ReadPackage("alnuth", "gap/pari.gd");
fi;

#############################################################################
##
#E
