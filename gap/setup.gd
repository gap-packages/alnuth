#############################################################################
##
#W setup.gd         Alnuth - ALgebraic NUmber THeory        Andreas Distler
##

#############################################################################
##
#F SetPariStackSize(size)
##
DeclareGlobalFunction("SetPariStackSize");

#############################################################################
##
#F SetAlnuthExternalExecutable(path)
##
DeclareGlobalFunction("SetAlnuthExternalExecutable");

#############################################################################
##
#F AL_SuitablePariExecutable(path)
##
DeclareGlobalFunction("AL_SuitablePariExecutable");

#############################################################################
##
#F PariVersion(path)
##
DeclareGlobalFunction("PariVersion");

#############################################################################
##
#F SetAlnuthExternalExecutablePermanently(path)
##
## Deprecated wrapper around setting the persistent executable preference.
##
DeclareGlobalFunction("SetAlnuthExternalExecutablePermanently");

#############################################################################
##
#F RestoreAlnuthExternalExecutablePermanently()
##
## Deprecated wrapper around restoring the default executable preference.
##
DeclareGlobalFunction("RestoreAlnuthExternalExecutablePermanently");

#############################################################################
##
#E
