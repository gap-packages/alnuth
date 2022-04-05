This file describes changes between different versions of Alnuth
================================================================

## 3.2.1 (2022-04-05)

  - set the GAP Team as maintainer of this package
  - various janitorial changes

## 3.2.0 (2022-03-02)

  - upgraded to support PARI 2.13 (thanks to Bill Allombert for the patch)

## 3.1.2 (2020-01-28)

  - updated authors contact data

## 3.1.1 (2019-06-04)

  - added implications IsUnitGroup => IsGroup and IsNumberFieldByMatrices
    => IsNumberField for improved compatibility with future GAP releases
  - fixed a link in the README
  - removed outdated author contact information

## 3.1.0 (2017-12-01)

  - upgraded to support PARI 2.9.0 (this required to remove support for
    PARI < 2.4.3)
  - migrated the package to GitHub

## 3.0.0 (2011-10-26)

  - added this file to document the changes between different versions
  - adjusted documentation to GAP 4.5
  - switched interface from KANT/KASH to PARI/GP
  - replaced all Unix specific code to allow running Alnuth under Windows
  - removed some errorneous `Set<Property/Attribute>` calls
  - replaced some calls to `PrimeField` by `Rationals`
  - removed functions in `unithom.gi` covered by Polycyclic
  - replaced (possibly expensive) call to `FieldOfPolynomial`
  - added `SubsetMaintencance` for `IsNumberFieldByMatrices`
  - renamed `IsPrimitiveElement` to `IsPrimitiveElementOfNumberField`
  - renamed `IsFieldByMatrices` to `AL_MatricesGeneratingNumberField`

## 2.3.1 (2011-05-31)

## 2.2.5 (2007-07-10)

## 2.2.4 (2007-06-17)

## 2.2.3 (2007-06-11)

## 2.2.2 (2006-11-24)

## 2.2.1 (2006-11-21)

## 2.2.0 (2006-09-02)

## 2.1.3 (2005-08-09)

## 2.1.2 (2005-08-04)

## 2.1.1 (2005-03-10)

## 2.1 (2004-12-20)

## 1.0 (2003-10-09)

  - initial release
