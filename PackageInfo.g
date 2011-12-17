#############################################################################
##
##  PackageInfo.g        GAP4 Package `Alnuth'                 Bjoern Assmann
##                                                            Andreas Distler
##  

SetPackageInfo( rec(

PackageName := "Alnuth",
Subtitle := "Algebraic number theory and an interface to KANT",
Version := "2.3.1",
Date := "31/05/2011",

PackageWWWHome := "http://www.icm.tu-bs.de/ag_algebra/software/Alnuth/",


ArchiveURL := Concatenation([ ~.PackageWWWHome, "Alnuth-", ~.Version]),
ArchiveFormats := ".tar.gz",


Persons := [

  rec(
      LastName      := "Assmann",
      FirstNames    := "Bjoern",
      IsAuthor      := true,
      WWWHome       := "http://www.dcs.st-and.ac.uk/~bjoern"
  ),
  rec(
      LastName      := "Distler",
      FirstNames    := "Andreas",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "a.distler@tu-bs.de",
      PostalAddress := Concatenation( [
            "CAUL (Centro de Álgebra da Universidade de Lisboa)\n",
            "Av. Prof. Gama Pinto, 2\n",
            "1649-003 Lisboa\n",
            "Portugal" ] ),
      Place         := "Lisboa",
      Institution   := "Centro de Álgebra da Universidade de Lisboa"
 ),
 rec(
      LastName      := "Eick",
      FirstNames    := "Bettina",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "b.eick@tu-bs.de",
      WWWHome       := "http://www-public.tu-bs.de:8080/~beick",
      PostalAddress := Concatenation( [
            "Institut Computational Mathematics\n",
            "TU Braunschweig\n",
            "Pockelsstr. 14\n D-38106 Braunschweig\n Germany" ] ),
      Place         := "Braunschweig",
      Institution   := "TU Braunschweig"
 ),
],

Status := "accepted",
CommunicatedBy := "Charles Wright (Eugene)",
AcceptDate := "01/2004",

README_URL := Concatenation( ~.PackageWWWHome, "README" ), 
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ), 

AbstractHTML := 
"The <span class=\"pkgname\">Alnuth</span> package provides various methods to compute with number fields which are given by a defining polynomial or by generators. Some of the methods provided in this package are written in <span class=\"pkgname\">GAP</span> code. The other part of the methods is imported from the Computer Algebra System KANT. Hence this package contains some Gap functions and an interface to some functions in the computer algebra system KANT. The main methods included in this package are: creating a number field, computing its maximal order (using KANT), computing its unit group (using KANT) and a presentation of this unit group, computing the elements of a given norm of the number field (using KANT) and determining a presentation for a finitely generated multiplicative subgroup (using KANT).",

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
  ExternalConditions := 
[["needs KANT/KASH Computer Algebra System Version 2.4 or 2.5",
"http://www.math.tu-berlin.de/~kant/" ] ]
),

AvailabilityTest := ReturnTrue,
BannerString := Concatenation([ 
"Loading Alnuth ",
~.Version,
" ... \n" ]),     
Autoload := false,
TestFile := "tst/testall.g",
Keywords := ["algebraic number theory", "number field" , "maximal order", "interface to KANT", "unit group", "elements of given norm" ]

));














