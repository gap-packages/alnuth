# compute factors of poly over Q_f
o := Order( f );
zeit := time;
oe := OrderEquationOrder( o );
zeit := zeit + time;
pol := PolyMove( poly, oe );
zeit := zeit + time;
faktoren := PolyFactor( pol );
zeit := zeit + time;

# print it to file
PrintTo(outt," KANTVars := [ \n");
for i in [1..Length(faktoren)] do
    for j in [1..faktoren[i][2]] do
        AppendTo(outt,PolyToList( faktoren[i][1] ),",\n");
    od;
od;
AppendTo(outt,zeit);
AppendTo(outt,"];");
