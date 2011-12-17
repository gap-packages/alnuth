#############################################################################
##
##  PackageInfo.g        GAP4 Package `Alnuth'                 Bjoern Assmann
##  

SetPackageInfo( rec(

PackageName := "Alnuth",
Subtitle := "Algebraic number theory and an interface to KANT",
Version := "2.1.2",
Date := "04/08/2005",

ArchiveURL := "http://www.icm.tu-bs.de/ag_algebra/software/assmann/Alnuth/Alnuth-2.1.2",
ArchiveFormats := ".tar.gz",


Persons := [

  rec(
      LastName      := "Assmann",
      FirstNames    := "Bjoern",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "BjoernAssmann@gmx.net",
      #WWWHome       := "http://www.tu-bs.de/~beick",
      PostalAddress := Concatenation( [
            "Mathematical Institute\n",
            "University of St. Andrews\n",
            "North Haugh\n St. Andrews, Fife, KY16 9SS\n Scotland, UK" ] ),
      Place         := "St. Andrews",
      Institution   := "University of St. Andrews"),

 rec(
      LastName      := "Eick",
      FirstNames    := "Bettina",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "b.eick@tu-bs.de",
      WWWHome       := "http://www.tu-bs.de/~beick",
      PostalAddress := Concatenation( [
            "Institut Computational Mathematics\n",
            "TU Braunschweig\n",
            "Pockelsstr. 14\n D-38106 Braunschweig\n Germany" ] ),
      Place         := "Braunschweig",
      Institution   := "TU Braunschweig"),

  rec(
      LastName      := "Distler",
      FirstNames    := "Andreas",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "a.distler@tu-bs.de",
      #WWWHome       := "http://www.tu-bs.de/~beick",
      PostalAddress := Concatenation( [
            "Institut Computational Mathematics\n",
            "TU Braunschweig\n",
            "Pockelsstr. 14\n D-38106 Braunschweig\n Germany" ] ),
      Place         := "Braunschweig",
      Institution   := "TU Braunschweig"),

],

Status := "accepted",
CommunicatedBy := "Charles Wright (Eugene)",
AcceptDate := "01/2004",

README_URL := "http://www.icm.tu-bs.de/ag_algebra/software/assmann/Alnuth/README",
PackageInfoURL := "http://www.icm.tu-bs.de/ag_algebra/software/assmann/Alnuth/PackageInfo.g",

AbstractHTML := 
"The <span class=\"pkgname\">Alnuth</span> package provides various methods to compute with number fields which are given by a defining polynomial or by generators. Some of the methods provided in this package are written in <span class=\"pkgname\">GAP</span> code. The other part of the methods is imported from the Computer Algebra System KANT. Hence this package contains some Gap functions and an interface to some functions in the computer algebra system KANT. The main methods included in this package are: creating a number field, computing its maximal order (using KANT), computing its unit group (using KANT) and a presentation of this unit group, computing the elements of a given norm of the number field (using KANT) and determining a presentation for a finitely generated multiplicative subgroup (using KANT).",

PackageWWWHome := "http://www.icm.tu-bs.de/ag_algebra/software/assmann/Alnuth",

PackageDoc := rec(
  BookName  := "Alnuth",
  ArchiveURLSubset := ["doc", "htm"],
  HTMLStart := "htm/chapters.htm",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Algebraic number theory and an interface to KANT",
  Autoload  := true),

Dependencies := rec(
  GAP := ">= 4.3fix4",
  NeededOtherPackages := [[ "polycyclic", ">=1.1" ]],
  SuggestedOtherPackages := [], 
  ExternalConditions := ["needs KANT/KASH Computer Algebra System \
  Version 2.4"] ),

AvailabilityTest := ReturnTrue,
BannerString := "Loading Alnuth 2.1.2 ... \n",
Autoload := true,
TestFile := "tst/testall.g",
Keywords := ["algebraic number theory", "number field" , "maximal order", "interface to KANT", "unit group", "elements of given norm" ]

));














