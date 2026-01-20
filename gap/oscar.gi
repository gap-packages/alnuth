#############################################################################
##
#W oscar.gi          Alnuth - ALgebraic NUmber THeory                Max Horn
#W                                                               Claus Fieker
##
##
##  This file is a drop-in replacement for pari.gi, thus alls functions are
##  also made available with "Pari" in their name.

# store isomorphism between GAP and OSCAR univariate polynomial ring over the
# rationals as we need it a lot
BindGlobal("_PolyRingIso", Oscar.iso_gap_oscar(PolynomialRing(Rationals)));

# given a GAP number field, compute an isomorphic Oscar number field f
# TODO: also store the isomorphism
# TODO: turn this into an attribute resp. a method for JuliaWrapper / JuliaData ???
BindGlobal("_OscarField", function(F)
  local f;
  if not IsBound(F!.oscarField) then
    f := _PolyRingIso(IntegerDefiningPolynomial(F));
    F!.oscarField := Oscar.number_field(f)[1];
  fi;
  return F!.oscarField;
end);

BindGlobal("MaximalOrderDescriptionOscar", function(F)
  local K, O, basis, T, eqn, b;

  K := _OscarField(F);
  O := Oscar.maximal_order(K);
  basis := Julia.map(Oscar.coordinates,Oscar.basis(O,K));

  T := JuliaToGAP(IsList, basis, true);

  # convert to GAP
  eqn := EquationOrderBasis(F);
  b := List( T, x -> LinearCombination( eqn, x ) );

  # return result
  return [T, b];
end);

BindGlobal("UnitGroupDescriptionOscar", function(F)
  local K, O, U_m, U, m, basis, result, eqn;

  K := _OscarField(F);
  O := Oscar.maximal_order(K);
  U_m := Oscar.unit_group(O);
  U := U_m[1];
  m := U_m[2];

  basis := Julia.map(Oscar.coordinates, Julia.map(K, Julia.map(m, Oscar.gens(U))));

  result := JuliaToGAP(IsList, basis, true);

  # convert to GAP
  eqn := EquationOrderBasis(F);
  if result = [-1] then
      result := [-1*eqn[1]];
  else
      result := List( result, x -> LinearCombination( eqn, x ) );
  fi;

  # return result
  return result;
end);

BindGlobal("ExponentsOfUnitsDescriptionWithRankOscar", function(F, elms)
  local K, O, U_m, U, m, basis, units, rank, expns, x;

  K := _OscarField(F);
  O := Oscar.maximal_order(K);
  U_m := Oscar.unit_group(O);
  U := U_m[1];
  m := U_m[2];

  basis := Julia.map(Oscar.coordinates, Julia.map(K, Julia.map(m, Oscar.gens(U))));
  units := JuliaToGAP(IsList, basis, true);

  # the order of the torsion part of the full unit group
  rank := Oscar.GAP.julia_to_gap(Oscar.order(U_m[1][1]));

  expns := [];
  for x in elms do
     # map GAP int vector to Oscar element
     Add(expns, Oscar.GAP.julia_to_gap(Oscar.preimage(m, K(GAPToJulia(x))).coeff)[1]);
  od;

  # return result
  return rec(units := units, expns := expns, rank := rank);

end);

BindGlobal("ExponentsOfFractionalIdealDescriptionOscar", function(F, elms)
  local K, O, tmp, ideals, result, blah, vec, I;

  K := _OscarField(F);
  O := Oscar.maximal_order(K);

  tmp := Julia.map(x -> Oscar.factor(K(GAPToJulia(x)) * O), elms);
  # take the union of the keys
  ideals := Julia.collect(Julia.reduce(Oscar.union, Julia.map(Oscar.Set, Julia.map(Oscar.keys, tmp))));
  if Julia.isempty(ideals) then
    return [];
  fi;

  result := [];
  for blah in JuliaToGAP(IsList, tmp) do
    vec := [];
    for I in JuliaToGAP(IsList, ideals) do
      Add(vec, Julia.get(blah, I, 0));
    od;
    Add(result, vec);
  od;

  return result;
end);

BindGlobal("NormCosetsDescriptionOscar", function(F, norm)
  local K, O, U_m, U, m, basis, units, eqn, creps;

  K := _OscarField(F);
  O := Oscar.maximal_order(K);
  U_m := Oscar.unit_group(O);
  U := U_m[1];
  m := U_m[2];

  basis := Julia.map(Oscar.coordinates, Julia.map(K, Julia.map(m, Oscar.gens(U))));
  units := JuliaToGAP(IsList, basis, true);

  eqn := Oscar.norm_equation(O, norm);

  creps := JuliaToGAP(IsList, Julia.map(Oscar.coordinates, Julia.map(K, eqn)), true);

  # return result
  return rec(units := units, creps := creps);
end);



BindGlobal("PolynomialFactorsDescriptionOscar", function(F, coeffs)
  local K, cf, poly, facs, result, f, g, i;

  K := _OscarField(F);

  cf := JuliaEvalString( "Vector{nf_elem}")(Reversed(List(coeffs, x -> K(GAPToJulia(x)))));
  poly := Oscar.polynomial(K, cf);
  facs := Oscar.factor(poly);
  Assert(0, Oscar.is_one(facs.unit));

  result := [];
  for f in JuliaToGAP(IsList, Oscar.collect(facs.fac)) do
    # Convert factor to GAP
    g := Julia.map(Oscar.coordinates, f[1].coeffs);
    g := JuliaToGAP(IsList, g, true);
    g := Reversed(g);

    # add as many copies as necessary
    for i in [1..f[2]] do
      Add(result, g);
    od;
  od;

  # Sort result by ascending degrees
  SortBy(result, Length);

  return result;
end);

BindGlobal("OSCAR_AL_FUNCS", rec(
    MaximalOrderDescription := MaximalOrderDescriptionOscar,
    UnitGroupDescription := UnitGroupDescriptionOscar,
    ExponentsOfUnitsDescriptionWithRank := ExponentsOfUnitsDescriptionWithRankOscar,
    ExponentsOfFractionalIdealDescription := ExponentsOfFractionalIdealDescriptionOscar,
    NormCosetsDescription := NormCosetsDescriptionOscar,
    PolynomialFactorsDescription := PolynomialFactorsDescriptionOscar,
));

AL_FUNCS := OSCAR_AL_FUNCS;
