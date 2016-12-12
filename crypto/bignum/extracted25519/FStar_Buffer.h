/* This file auto-generated by KreMLin! */
#ifndef __FStar_Buffer_H
#define __FStar_Buffer_H


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
#include "kremlib.h"
#include "testlib.h"

void FStar_Buffer_lemma_size(Prims_int x);

typedef struct {
  uint32_t x00;
  void *x01;
  uint32_t x02;
  uint32_t x03;
}
FStar_Buffer__buffer__0;

typedef struct {
  void *x00;
  void **x01;
}
FStar_Buffer_abuffer;

void **FStar_Buffer___proj__Buff__item__b(FStar_Buffer_abuffer projectee);

extern Prims_prop
FStar_Buffer_arefs(Prims_prop (*x0)(FStar_Buffer_abuffer x0), FStar_Heap_aref x1);

void FStar_Buffer_lemma_arefs_1(Prims_prop (*s)(FStar_Buffer_abuffer x0));

void
FStar_Buffer_lemma_arefs_2(
  Prims_prop (*s1)(FStar_Buffer_abuffer x0),
  Prims_prop (*s2)(FStar_Buffer_abuffer x0)
);

void
FStar_Buffer_lemma_arefs_3(
  Prims_prop (*s1)(FStar_Buffer_abuffer x0),
  Prims_prop (*s2)(FStar_Buffer_abuffer x0)
);

void
FStar_Buffer_lemma_modifies_bufs_trans(
  FStar_HyperHeap_rid rid,
  Prims_prop (*bufs)(FStar_Buffer_abuffer x0),
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2
);

void
FStar_Buffer_lemma_modifies_bufs_sub(
  FStar_HyperHeap_rid rid,
  Prims_prop (*bufs)(FStar_Buffer_abuffer x0),
  Prims_prop (*subbufs)(FStar_Buffer_abuffer x0),
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1
);

void
FStar_Buffer_modifies_trans_0_0(
  FStar_HyperHeap_rid rid,
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2
);

void FStar_Buffer_lemma_intro_modifies_0(FStar_HyperStack_mem h0, FStar_HyperStack_mem h1);

void
FStar_Buffer_lemma_intro_modifies_region(
  FStar_HyperHeap_rid rid,
  Prims_prop (*bufs)(FStar_Buffer_abuffer x0),
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1
);

void FStar_Buffer_lemma_reveal_modifies_0(FStar_HyperStack_mem h0, FStar_HyperStack_mem h1);

void
FStar_Buffer_lemma_reveal_modifies_region(
  FStar_HyperHeap_rid rid,
  Prims_prop (*bufs)(FStar_Buffer_abuffer x0),
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1
);

void
FStar_Buffer_lemma_modifies_0_trans(
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2
);

void
FStar_Buffer_lemma_modifies_0_0(
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2
);

void FStar_Buffer_lemma_modifies_sub_0(FStar_HyperStack_mem h0, FStar_HyperStack_mem h1);

void
FStar_Buffer_modifies_popped_0(
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2,
  FStar_HyperStack_mem h3
);

void
FStar_Buffer_lemma_modifies_none_push_pop(
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2
);

void
FStar_Buffer_lemma_modifies_0_push_pop(
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2,
  FStar_HyperStack_mem h3
);

void FStar_Buffer_modifies_poppable_0(FStar_HyperStack_mem h0, FStar_HyperStack_mem h1);

void FStar_Buffer_lemma_fresh_poppable(FStar_HyperStack_mem h0, FStar_HyperStack_mem h1);

void
FStar_Buffer_lemma_equal_domains_popped(
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2,
  FStar_HyperStack_mem h3
);

void
FStar_Buffer_lemma_equal_domains(
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2,
  FStar_HyperStack_mem h3
);

void
FStar_Buffer_lemma_equal_domains_2(
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2,
  FStar_HyperStack_mem h3,
  FStar_HyperStack_mem h4
);
#endif
