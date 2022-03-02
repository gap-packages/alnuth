bnf = bnfinit(f,1);
n = poldegree(f);
un = lift(concat([bnf.tu[2]],bnf.fu));
nr = bnfisintnorm( bnf, nrm);

p2v(n,b) = vector(n,j,polcoeff(b,j-1));

\\ print units
print("[[ ");
for(i=1,#un, print(p2v(n,un[i]),","));
print("],\n");

\\ print norm elements
print(" [ ");
for (i=1, #nr, print(p2v(n,nr[i]),",\n"));
print("]];");

