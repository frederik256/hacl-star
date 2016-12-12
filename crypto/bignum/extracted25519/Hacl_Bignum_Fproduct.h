/* This file auto-generated by KreMLin! */
#ifndef __Hacl_Bignum_Fproduct_H
#define __Hacl_Bignum_Fproduct_H


#include "Prims.h"
#include "FStar_Mul.h"
#include "FStar_Squash.h"
#include "FStar_StrongExcludedMiddle.h"
#include "FStar_List_Tot.h"
#include "FStar_Classical.h"
#include "FStar_ListProperties.h"
#include "FStar_SeqProperties.h"
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
#include "Hacl_Bignum_Constants.h"
#include "FStar_Buffer.h"
#include "Hacl_Bignum_Parameters.h"
#include "Hacl_Bignum_Predicates.h"
#include "Hacl_Bignum_Limb.h"
#include "Hacl_Bignum_Wide.h"
#include "Hacl_Bignum_Bigint.h"
#include "Hacl_Bignum_Fsum_Spec.h"
#include "Hacl_Bignum_Fsum.h"
#include "Hacl_Bignum_Fscalar_Spec.h"
#include "Hacl_Bignum_Modulo.h"
#include "Hacl_Bignum_Fproduct_Spec.h"
#include "Hacl_Bignum_Fdifference_Spec.h"
#include "kremlib.h"
#include "testlib.h"

void
Hacl_Bignum_Fproduct_copy_from_wide_(uint64_t *output, FStar_UInt128_t *input, uint32_t ctr);

void Hacl_Bignum_Fproduct_shift_(uint64_t *output, uint32_t ctr);

void Hacl_Bignum_Fproduct_shift(uint64_t *output);

void
Hacl_Bignum_Fproduct_sum_scalar_multiplication_(
  FStar_UInt128_t *output,
  uint64_t *input,
  uint64_t s,
  uint32_t ctr
);

void Hacl_Bignum_Fproduct_shift_reduce(uint64_t *output);

void
Hacl_Bignum_Fproduct_mul_shift_reduce_(
  FStar_UInt128_t *output,
  uint64_t *input,
  uint64_t *input2,
  uint32_t ctr
);

void Hacl_Bignum_Fproduct_carry_wide_(FStar_UInt128_t *tmp, uint32_t ctr);

void Hacl_Bignum_Fproduct_carry_0_to_1(uint64_t *output);

void Hacl_Bignum_Fproduct_fmul_(uint64_t *output, uint64_t *input, uint64_t *input2);

void Hacl_Bignum_Fproduct_fmul(uint64_t *output, uint64_t *input, uint64_t *input2);

void Hacl_Bignum_Fproduct_fsquare_times_(uint64_t *tmp, uint32_t count);

void Hacl_Bignum_Fproduct_fsquare_times(uint64_t *output, uint64_t *input, uint32_t count);
#endif
