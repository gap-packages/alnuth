#############################################################################
##
#W oscar.gi          Alnuth - ALgebraic NUmber THeory                Max Horn
#W                                                               Claus Fieker
##
##
##  This file is a drop-in replacement for pari.gi, thus alls functions are
##  also made available with "Pari" in their name.

BindGlobal("OSCAR_AL_FUNCS", rec());

# store isomorphism between GAP and OSCAR univariate polynomial ring over the
# rationals as we need it again and again, for each new number field
OSCAR_AL_FUNCS.PolyRingIso := Oscar_jl.iso_gap_oscar(PolynomialRing(Rationals));

# Given a GAP number field, return an isomorphic Oscar number field.
# This field is also cached
OSCAR_AL_FUNCS.OscarField := function(F)
  local f;
  if not IsBound(F!.oscarField) then
    f := OSCAR_AL_FUNCS.PolyRingIso(IntegerDefiningPolynomial(F));
    F!.oscarField := Oscar_jl.number_field(f)[1];
  fi;
  return F!.oscarField;
end;

OSCAR_AL_FUNCS.MaximalOrderDescription := function(F)
  local K, O, basis;

  K := OSCAR_AL_FUNCS.OscarField(F);
  O := Oscar_jl.maximal_order(K);
  basis := Julia.map(Oscar_jl.coordinates,Oscar_jl.basis(O,K));

  return JuliaToGAP(IsList, basis, true);
end;

OSCAR_AL_FUNCS.UnitGroupDescription := function(F)
  local K, O, U_m, U, m, basis;

  K := OSCAR_AL_FUNCS.OscarField(F);
  O := Oscar_jl.maximal_order(K);
  U_m := Oscar_jl.unit_group(O);
  U := U_m[1];
  m := U_m[2];

  basis := Julia.map(Oscar_jl.coordinates, Julia.map(K, Julia.map(m, Oscar_jl.gens(U))));

  return JuliaToGAP(IsList, basis, true);
end;

OSCAR_AL_FUNCS.ExponentsOfUnitsDescriptionWithRank := function(F, elms)
  local K, O, U_m, U, m, basis, units, rank, expns, x;

  K := OSCAR_AL_FUNCS.OscarField(F);
  O := Oscar_jl.maximal_order(K);
  U_m := Oscar_jl.unit_group(O);
  U := U_m[1];
  m := U_m[2];

  basis := Julia.map(Oscar_jl.coordinates, Julia.map(K, Julia.map(m, Oscar_jl.gens(U))));
  units := JuliaToGAP(IsList, basis, true);

  # the order of the torsion part of the full unit group
  rank := Oscar_jl.GAP.julia_to_gap(Oscar_jl.order(U_m[1][1]));

  expns := [];
  for x in elms do
     # map GAP int vector to Oscar element
     Add(expns, Oscar_jl.GAP.julia_to_gap(Oscar_jl.preimage(m, K(GAPToJulia(x))).coeff)[1]);
  od;

  # return result
  return rec(units := units, expns := expns, rank := rank);

end;

OSCAR_AL_FUNCS.ExponentsOfFractionalIdealDescription := function(F, elms)
  local K, O, tmp, ideals, result, blah, vec, I;

  K := OSCAR_AL_FUNCS.OscarField(F);
  O := Oscar_jl.maximal_order(K);

  tmp := Julia.map(x -> Oscar_jl.factor(K(GAPToJulia(x)) * O), elms);
  # take the union of the keys
  ideals := Julia.collect(Julia.reduce(Oscar_jl.union, Julia.map(Oscar_jl.Set, Julia.map(Oscar_jl.keys, tmp))));
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
end;

OSCAR_AL_FUNCS.NormCosetsDescription := function(F, norm)
  local K, O, U_m, U, m, basis, units, eqn, creps;

  K := OSCAR_AL_FUNCS.OscarField(F);
  O := Oscar_jl.maximal_order(K);
  U_m := Oscar_jl.unit_group(O);
  U := U_m[1];
  m := U_m[2];

  basis := Julia.map(Oscar_jl.coordinates, Julia.map(K, Julia.map(m, Oscar_jl.gens(U))));
  units := JuliaToGAP(IsList, basis, true);

  eqn := Oscar_jl.norm_equation(O, norm);

  creps := JuliaToGAP(IsList, Julia.map(Oscar_jl.coordinates, Julia.map(K, eqn)), true);

  # return result
  return rec(units := units, creps := creps);
end;

OSCAR_AL_FUNCS.Vector_AbsSimpleNumFieldElem := JuliaType( Julia.Vector, [ Oscar_jl.AbsSimpleNumFieldElem ] );

OSCAR_AL_FUNCS.PolynomialFactorsDescription := function(F, coeffs)
  local K, cf, poly, facs, result, f, g, i;

  K := OSCAR_AL_FUNCS.OscarField(F);

  cf := OSCAR_AL_FUNCS.Vector_AbsSimpleNumFieldElem(Reversed(List(coeffs, x -> K(GAPToJulia(x)))));
  poly := Oscar_jl.polynomial(K, cf);
  facs := Oscar_jl.factor(poly);
  Assert(0, Oscar_jl.is_one(facs.unit));

  result := [];
  for f in JuliaToGAP(IsList, Oscar_jl.collect(facs.fac)) do
    # Convert factor to GAP
    g := Julia.map(Oscar_jl.coordinates, f[1].coeffs);
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
end;

AL_FUNCS := OSCAR_AL_FUNCS;
