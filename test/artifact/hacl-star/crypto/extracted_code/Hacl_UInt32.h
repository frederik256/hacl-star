/* This file auto-generated by KreMLin! */
#ifndef __Hacl_UInt32_H
#define __Hacl_UInt32_H


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
#include "kremlib.h"

extern Prims_int Hacl_UInt32_n;

typedef uint32_t Hacl_UInt32_t;

Prims_int Hacl_UInt32_v(uint32_t x);

uint32_t Hacl_UInt32_add(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_add_mod(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_sub(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_sub_mod(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_mul(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_mul_mod(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_logand(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_logxor(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_logor(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_lognot(uint32_t a);

uint32_t Hacl_UInt32_shift_right(uint32_t a, uint32_t s);

uint32_t Hacl_UInt32_shift_left(uint32_t a, uint32_t s);

uint32_t Hacl_UInt32_eq_mask(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_gte_mask(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_gt_mask(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_lt_mask(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_lte_mask(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_op_Plus_Hat(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_op_Plus_Percent_Hat(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_op_Subtraction_Hat(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_op_Subtraction_Percent_Hat(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_op_Star_Hat(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_op_Star_Percent_Hat(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_op_Amp_Hat(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_op_Hat_Hat(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_op_Bar_Hat(uint32_t a, uint32_t b);

uint32_t Hacl_UInt32_op_Greater_Greater_Hat(uint32_t a, uint32_t s);

uint32_t Hacl_UInt32_op_Less_Less_Hat(uint32_t a, uint32_t s);

extern uint32_t Hacl_UInt32_of_string(Prims_string x0);
#endif
