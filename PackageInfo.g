#############################################################################
##
##  PackageInfo.g        GAP4 Package "Alnuth"               Bjoern Assmann
##                                                          Andreas Distler
##  

SetPackageInfo( rec(

PackageName := "Alnuth",
Subtitle := "ALgebraic NUmber THeory and an interface to PARI/GP and OSCAR",
Version := "4.0.0dev",
Date := "05/04/2022", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/gap-packages/", LowercaseString(~.PackageName) ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := Concatenation( "https://gap-packages.github.io/", LowercaseString(~.PackageName) ),
README_URL      := Concatenation( ~.PackageWWWHome, "/README.md" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", LowercaseString(~.PackageName), "-", ~.Version ),

ArchiveFormats := ".tar.gz",
 
Persons := [

  rec(
      LastName      := "Assmann",
      FirstNames    := "Björn",
      IsAuthor      := true,
      IsMaintainer  := false,
  ),
  rec(
      LastName      := "Distler",
      FirstNames    := "Andreas",
      IsAuthor      := true,
      IsMaintainer  := false,
      Email         := "a.distler@tu-bs.de",
  ),
  rec(
      LastName      := "Eick",
      FirstNames    := "Bettina",
      IsAuthor      := true,
      IsMaintainer  := false,
      Email         := "beick@tu-bs.de",
      WWWHome       := "http://www.iaa.tu-bs.de/beick",
      GitHubUsername:= "beick",
      PostalAddress := Concatenation(
               "Institut Analysis und Algebra\n",
               "TU Braunschweig\n",
               "Universitätsplatz 2\n",
               "D-38106 Braunschweig\n",
               "Germany" ),
      Place         := "Braunschweig",
      Institution   := "TU Braunschweig"
  ),
  rec(
      LastName      := "Horn",
      FirstNames    := "Max",
      IsAuthor      := false,
      IsMaintainer  := true,
      Email         := "mhorn@rptu.de",
      WWWHome       := "https://www.quendi.de/math",
      GitHubUsername:= "fingolfin",
      PostalAddress := Concatenation(
                         "Fachbereich Mathematik\n",
                         "RPTU Kaiserslautern-Landau\n",
                         "Gottlieb-Daimler-Straße 48\n",
                         "67663 Kaiserslautern\n",
                         "Germany" ),
      Place         := "Kaiserslautern, Germany",
      Institution   := "RPTU Kaiserslautern-Landau"
  ),
  rec(
      LastName      := "GAP Team",
      FirstNames    := "The",
      IsAuthor      := false,
      IsMaintainer  := true,
      Email         := "support@gap-system.org",
  ),
],

Status := "accepted",
CommunicatedBy := "Charles Wright (Eugene)",
AcceptDate := "01/2004",

AbstractHTML := 
"The <span class=\"pkgname\">Alnuth</span> package provides various methods to compute with number fields which are given by a defining polynomial or by generators. Some of the methods provided in this package are written in <span class=\"pkgname\">GAP</span> code. The other part of the methods is imported from an another computer algebra system, currently either PARI/GP or OSCAR. Hence this package contains some <span class=\"pkgname\">GAP</span> functions and an interface to some functions in the computer algebra systems PARI/GP and OSCAR. The main methods included in <span class=\"pkgname\">Alnuth</span> are: creating a number field, computing its maximal order (using the external CAS), computing its unit group (using the external CAS) and a presentation of this unit group, computing the elements of a given norm of the number field (using the external CAS), determining a presentation for a finitely generated multiplicative subgroup (using the external CAS), and factoring polynomials defined over number fields (using the external CAS).",

PackageDoc := rec(
  BookName  := "Alnuth",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "ALgebraic NUmber THeory and an interface to PARI/GP and OSCAR",
),

Dependencies := rec(
  GAP := ">= 4.8",
  NeededOtherPackages := [[ "polycyclic", ">=1.1" ]],
  SuggestedOtherPackages := [], 
  ExternalConditions := 
[["needs the PARI/GP computer algebra system Version 2.5 or higher",
"https://pari.math.u-bordeaux.fr/" ] ]
),

Extensions := [
    rec( needed := [ [ "OscarInterface", ">= 1.0.0" ] ],
         filename := "gap/oscar.gi" ),
],

AvailabilityTest := ReturnTrue,
TestFile := "tst/testall.g",
Keywords := ["algebraic number theory", "number field" , "maximal order",
"interface to PARI/GP",
"interface to number theory in OSCAR",
"unit group", "elements of given norm" ],

AutoDoc := rec(
    entities := rec(
        VERSION := ~.Version,
        RELEASEYEAR := ~.Date{[7..10]},
        RELEASEDATE := function(date)
          local day, month, year, allMonths;
          day := Int(date{[1,2]});
          month := Int(date{[4,5]});
          year := Int(date{[7..10]});
          allMonths := [ "January", "February", "March", "April", "May", "June", "July",
                         "August", "September", "October", "November", "December"];
          return Concatenation(String(day)," ", allMonths[month], " ", String(year));
        end(~.Date),
        Polycyclic := "<Package>Polycyclic</Package>",
    ),
),

));
