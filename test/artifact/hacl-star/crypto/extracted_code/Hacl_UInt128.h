/* This file auto-generated by KreMLin! */
#ifndef __Hacl_UInt128_H
#define __Hacl_UInt128_H


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
#include "kremlib.h"

extern Prims_int Hacl_UInt128_n;

typedef FStar_UInt128_t Hacl_UInt128_t;

Prims_int Hacl_UInt128_v(FStar_UInt128_t x);

FStar_UInt128_t Hacl_UInt128_add(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_add_mod(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_sub(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_sub_mod(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_logand(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_logxor(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_logor(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_lognot(FStar_UInt128_t a);

FStar_UInt128_t Hacl_UInt128_shift_right(FStar_UInt128_t a, uint32_t s);

FStar_UInt128_t Hacl_UInt128_shift_left(FStar_UInt128_t a, uint32_t s);

FStar_UInt128_t Hacl_UInt128_eq_mask(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_gte_mask(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_gt_mask(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_lt_mask(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_lte_mask(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_op_Plus_Hat(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_op_Plus_Percent_Hat(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_op_Subtraction_Hat(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_op_Subtraction_Percent_Hat(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_op_Amp_Hat(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_op_Hat_Hat(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_op_Bar_Hat(FStar_UInt128_t a, FStar_UInt128_t b);

FStar_UInt128_t Hacl_UInt128_op_Greater_Greater_Hat(FStar_UInt128_t a, uint32_t s);

FStar_UInt128_t Hacl_UInt128_op_Less_Less_Hat(FStar_UInt128_t a, uint32_t s);

FStar_UInt128_t Hacl_UInt128_mul_wide(uint64_t a, uint64_t b);

FStar_UInt128_t Hacl_UInt128_op_Star_Hat(uint64_t a, uint64_t b);

extern FStar_UInt128_t Hacl_UInt128_of_string(Prims_string x0);
#endif
