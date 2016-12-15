/* This file auto-generated by KreMLin! */
#ifndef __Hacl_EC_Curve25519_Bignum_Modulo_H
#define __Hacl_EC_Curve25519_Bignum_Modulo_H


#include "Prims.h"
#include "FStar_Mul.h"
#include "FStar_Squash.h"
#include "FStar_StrongExcludedMiddle.h"
#include "FStar_List_Tot.h"
#include "FStar_Classical.h"
#include "FStar_ListProperties.h"
#include "FStar_Seq_Properties.h"
#include "FStar_Math_Lemmas.h"
#include "FStar_BitVector.h"
#include "FStar_UInt.h"
#include "FStar_Int.h"
#include "FStar_FunctionalExtensionality.h"
#include "FStar_PropositionalExtensionality.h"
#include "FStar_PredicateExtensionality.h"
#include "FStar_TSet.h"
#include "FStar_Set.h"
#include "FStar_Map.h"
#include "FStar_Ghost.h"
#include "FStar_All.h"
#include "Hacl_UInt64.h"
#include "Hacl_UInt128.h"
#include "Hacl_UInt32.h"
#include "Hacl_UInt8.h"
#include "Hacl_Cast.h"
#include "FStar_Buffer.h"
#include "FStar_Buffer_Quantifiers.h"
#include "Hacl_EC_Curve25519_Parameters.h"
#include "Hacl_EC_Curve25519_Bigint.h"
#include "Hacl_EC_Curve25519_Utils.h"
#include "Hacl_EC_Curve25519_Bignum_Fproduct.h"
#include "Hacl_EC_Curve25519_Bignum_Fscalar.h"
#include "Hacl_EC_Curve25519_Bignum_Fdifference.h"
#include "Hacl_EC_Curve25519_Bignum_Fsum.h"
#include "kremlib.h"

FStar_UInt128_t Hacl_EC_Curve25519_Bignum_Modulo_times_wide_19(FStar_UInt128_t x);

void Hacl_EC_Curve25519_Bignum_Modulo_freduce_degree_(FStar_UInt128_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_freduce_degree(FStar_UInt128_t *b);

FStar_UInt128_t Hacl_EC_Curve25519_Bignum_Modulo_mod_wide_2_51(FStar_UInt128_t a);

void
Hacl_EC_Curve25519_Bignum_Modulo_carry_wide_1_0(
  FStar_UInt128_t *b,
  FStar_UInt128_t b0,
  FStar_UInt128_t b1,
  FStar_UInt128_t b2,
  FStar_UInt128_t b3,
  FStar_UInt128_t b4
);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_wide_1_(FStar_UInt128_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_wide_1(FStar_UInt128_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_wide_2_(FStar_UInt128_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_wide_2(FStar_UInt128_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_wide_top_(FStar_UInt128_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_wide_top_1(FStar_UInt128_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_wide_top_2(FStar_UInt128_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_wide_0_to_1_(FStar_UInt128_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_wide_0_to_1(FStar_UInt128_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_freduce_coefficients_wide(FStar_UInt128_t *b);

uint64_t Hacl_EC_Curve25519_Bignum_Modulo_times_19(uint64_t x);

uint64_t Hacl_EC_Curve25519_Bignum_Modulo_mod_2_51(uint64_t a);

void
Hacl_EC_Curve25519_Bignum_Modulo_carry_1_0_(
  uint64_t *b,
  uint64_t b0,
  uint64_t b1,
  uint64_t b2,
  uint64_t b3,
  uint64_t b4
);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_1__(uint64_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_1_(uint64_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_2__(uint64_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_2_(uint64_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_top__(uint64_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_top_1_(uint64_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_top_2_(uint64_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_0_to_1__(uint64_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_carry_0_to_1_(uint64_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_freduce_coefficients(uint64_t *b);

void Hacl_EC_Curve25519_Bignum_Modulo_normalize(uint64_t *b);
#endif
