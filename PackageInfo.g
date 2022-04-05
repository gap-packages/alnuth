#############################################################################
##
##  PackageInfo.g        GAP4 Package "Alnuth"               Bjoern Assmann
##                                                          Andreas Distler
##  

SetPackageInfo( rec(

PackageName := "Alnuth",
Subtitle := "Algebraic number theory and an interface to PARI/GP",
Version := "3.2.1",
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
"The <span class=\"pkgname\">Alnuth</span> package provides various methods to compute with number fields which are given by a defining polynomial or by generators. Some of the methods provided in this package are written in <span class=\"pkgname\">GAP</span> code. The other part of the methods is imported from the computer algebra system PARI/GP. Hence this package contains some <span class=\"pkgname\">GAP</span> functions and an interface to some functions in the computer algebra system PARI/GP. The main methods included in <span class=\"pkgname\">Alnuth</span> are: creating a number field, computing its maximal order (using PARI/GP), computing its unit group (using PARI/GP) and a presentation of this unit group, computing the elements of a given norm of the number field (using PARI/GP), determining a presentation for a finitely generated multiplicative subgroup (using PARI/GP), and factoring polynomials defined over number fields (using PARI/GP).",

PackageDoc := rec(
  BookName  := "Alnuth",
  ArchiveURLSubset := ["doc", "htm"],
  HTMLStart := "htm/chapters.htm",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Algebraic number theory and an interface to PARI/GP",
  Autoload  := true),

Dependencies := rec(
  GAP := ">= 4.8",
  NeededOtherPackages := [[ "polycyclic", ">=1.1" ]],
  SuggestedOtherPackages := [], 
  ExternalConditions := 
[["needs the PARI/GP computer algebra system Version 2.5 or higher",
"https://pari.math.u-bordeaux.fr/" ] ]
),

AvailabilityTest := ReturnTrue,
TestFile := "tst/testall.g",
Keywords := ["algebraic number theory", "number field" , "maximal order",
"interface to PARI/GP", "unit group", "elements of given norm" ]
));
