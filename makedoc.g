##  this creates the documentation, needs: GAPDoc and AutoDoc packages, pdflatex
##
##  Call this with GAP from within the package directory.
##

if fail = LoadPackage("AutoDoc", ">= 2022.07.10") then
    Error("AutoDoc 2022.07.10 or newer is required");
fi;

AutoDoc(rec(
    autodoc := true,
    extract_examples := true,
    scaffold := rec(
        TitlePage := false,
        includes := [
            "intro.xml",
            "fields.xml",
            "example.xml",
            "install.xml",
        ],
        bib := "manual.bib",
    ),
));
