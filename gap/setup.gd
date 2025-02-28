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
## Changes the file defs.g to set a new default value for AL_EXECUTABLE
##
DeclareGlobalFunction("SetAlnuthExternalExecutablePermanently");

#############################################################################
##
#F RestoreAlnuthExternalExecutablePermanently(path)
##
## restores the original content of the file defs.g
##
DeclareGlobalFunction("RestoreAlnuthExternalExecutablePermanently");

#############################################################################
##
#E