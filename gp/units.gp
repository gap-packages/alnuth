bnf = bnfinit(f,1);
n = poldegree(f);
un = lift(concat([bnf.tu[2]],bnf.fu));

p2v(n,b) = vector(n,j,polcoeff(b,j-1));

\\ print units
print("[ ");
for(i=1,#un, print(p2v(n,un[i]),","));
print("];\n");
