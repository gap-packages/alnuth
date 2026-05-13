gap> START_TEST("userprefs.tst");
gap> pari_path:=UserPreference("alnuth", "PariGpPath");;
gap> IsString(pari_path);
true
gap> UserPreference("alnuth", "PariGpOptions");
[ "-f", "-q" ]
gap> UserPreference("alnuth", "PariStackSize");
128
gap> UserPreference("alnuth", "PrimitiveElementTrials");
20
gap> tmpdir := DirectoryTemporary();;
gap> oldroot := GAPInfo.UserGapRoot;;
gap> oldobsolete := InfoLevel(InfoObsolete);;
gap> oldinfo := InfoLevel(InfoWarning);;
gap> GAPInfo.UserGapRoot := tmpdir![1];;
gap> SetInfoLevel(InfoObsolete, 1);;
gap> SetInfoLevel(InfoWarning, 0);;
gap> path := SetAlnuthExternalExecutable("gp");;
#I  The function `SetAlnuthExternalExecutable` is deprecated. Use SetUserPreference("alnuth", "PariGpPath", path) instead.
gap> IsString(path);
true
gap> path := SetAlnuthExternalExecutablePermanently("gp");;
#I  The function `SetAlnuthExternalExecutablePermanently` is deprecated. Use SetUserPreference("alnuth", "PariGpPath", path); WriteGapIniFile() instead.
gap> IsString(path);
true
gap> IsExistingFile(Filename(tmpdir, "gap.ini"));
true
gap> oldparipath := UserPreference("alnuth", "PariGpPath");;
gap> oldpariopts := UserPreference("alnuth", "PariGpOptions");;
gap> oldparistack := UserPreference("alnuth", "PariStackSize");;
gap> oldprimtrials := UserPreference("alnuth", "PrimitiveElementTrials");;
gap> SetUserPreference("alnuth", "PariGpPath", "");;
gap> AL_EXECUTABLE := "gp";;
gap> IsString(AL_CurrentPariGpPath());
true
gap> SetUserPreference("alnuth", "PariGpOptions", 1);;
gap> AL_OPTIONS := [ "-f" ];;
gap> AL_CurrentPariGpOptions();
[ "-f" ]
gap> SetUserPreference("alnuth", "PariStackSize", 0);;
gap> AL_STACKSIZE := "-s256M";;
gap> AL_CurrentPariStackSize();
256
gap> SetUserPreference("alnuth", "PrimitiveElementTrials", 0);;
gap> PRIM_TEST := 7;;
gap> AL_CurrentPrimitiveElementTrials();
7
gap> AL_OPTIONS := [ "-f" ];;
gap> AL_STACKSIZE := "-s128M";;
gap> AL_WarnAboutObsoleteGlobals();
[ "AL_EXECUTABLE", "AL_OPTIONS", "AL_STACKSIZE", "PRIM_TEST" ]
gap> SetUserPreference("alnuth", "PariGpPath", oldparipath);;
gap> SetUserPreference("alnuth", "PariGpOptions", oldpariopts);;
gap> SetUserPreference("alnuth", "PariStackSize", oldparistack);;
gap> SetUserPreference("alnuth", "PrimitiveElementTrials", oldprimtrials);;
gap> SetInfoLevel(InfoObsolete, oldobsolete);;
gap> SetInfoLevel(InfoWarning, oldinfo);;
gap> GAPInfo.UserGapRoot := oldroot;;
gap> Unbind(AL_EXECUTABLE); Unbind(AL_OPTIONS); Unbind(AL_STACKSIZE); Unbind(PRIM_TEST);
gap> STOP_TEST("userprefs.tst", 1);
