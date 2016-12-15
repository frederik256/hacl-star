/* This file auto-generated by KreMLin! */
#ifndef __Hacl_UInt64_H
#define __Hacl_UInt64_H


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
#include "kremlib.h"

extern Prims_int Hacl_UInt64_n;

typedef uint64_t Hacl_UInt64_t;

Prims_int Hacl_UInt64_v(uint64_t x);

uint64_t Hacl_UInt64_add(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_add_mod(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_sub(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_sub_mod(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_mul(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_mul_mod(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_logand(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_logxor(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_logor(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_lognot(uint64_t a);

uint64_t Hacl_UInt64_shift_right(uint64_t a, uint32_t s);

uint64_t Hacl_UInt64_shift_left(uint64_t a, uint32_t s);

uint64_t Hacl_UInt64_eq_mask(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_gte_mask(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_gt_mask(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_lt_mask(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_lte_mask(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_op_Plus_Hat(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_op_Plus_Percent_Hat(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_op_Subtraction_Hat(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_op_Subtraction_Percent_Hat(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_op_Star_Hat(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_op_Star_Percent_Hat(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_op_Amp_Hat(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_op_Hat_Hat(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_op_Bar_Hat(uint64_t a, uint64_t b);

uint64_t Hacl_UInt64_op_Greater_Greater_Hat(uint64_t a, uint32_t s);

uint64_t Hacl_UInt64_op_Less_Less_Hat(uint64_t a, uint32_t s);

extern uint64_t Hacl_UInt64_of_string(Prims_string x0);
#endif
