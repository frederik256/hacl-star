/* This file auto-generated by KreMLin! */
#ifndef __Hacl_Symmetric_Salsa20_H
#define __Hacl_Symmetric_Salsa20_H


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
#include "Hacl_EC_Curve25519_Bignum_Modulo.h"
#include "Hacl_EC_Curve25519_Bignum.h"
#include "Hacl_EC_Curve25519_PPoint.h"
#include "Hacl_EC_Curve25519_AddAndDouble.h"
#include "Hacl_UInt16.h"
#include "Hacl_Types.h"
#include "Hacl_Symmetric_Poly1305_64_Parameters.h"
#include "Hacl_Symmetric_Poly1305_64_Bigint.h"
#include "Hacl_Symmetric_HSalsa20.h"
#include "Hacl_Symmetric_Poly1305_64.h"
#include "kremlib.h"

typedef uint32_t Hacl_Symmetric_Salsa20_h32;

typedef uint32_t Hacl_Symmetric_Salsa20_u32;

typedef uint8_t *Hacl_Symmetric_Salsa20_uint8_p;

uint32_t Hacl_Symmetric_Salsa20_rotate(uint32_t a, uint32_t s);

uint32_t Hacl_Symmetric_Salsa20_load32_le(uint8_t *k);

void Hacl_Symmetric_Salsa20_store32_le(uint8_t *k, uint32_t x);

void Hacl_Symmetric_Salsa20_crypto_core_salsa20(uint8_t *output, uint8_t *input, uint8_t *key);

void Hacl_Symmetric_Salsa20_xor_(uint8_t *c, uint8_t *m, uint8_t *block);

void
Hacl_Symmetric_Salsa20_lemma_modifies_3(
  uint8_t *c,
  uint8_t *input,
  uint8_t *block,
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2
);

void
Hacl_Symmetric_Salsa20_lemma_modifies_3_(
  uint8_t *c,
  uint8_t *input,
  uint8_t *block,
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2
);

uint64_t
Hacl_Symmetric_Salsa20_crypto_stream_salsa20_xor_ic_loop(
  uint8_t *c,
  uint8_t *m,
  uint8_t *block,
  uint8_t *input,
  uint8_t *kcopy,
  uint64_t mlen
);

void Hacl_Symmetric_Salsa20_xor_bytes(uint8_t *x, uint8_t *y, uint8_t *z, uint32_t len);

uint32_t Hacl_Symmetric_Salsa20_mod_64(uint64_t mlen);

void
Hacl_Symmetric_Salsa20_lemma_modifies_3_1(
  uint8_t *c,
  uint8_t *input,
  uint8_t *block,
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2,
  FStar_HyperStack_mem h3
);

void
Hacl_Symmetric_Salsa20_crypto_stream_salsa20_xor_ic__(
  uint8_t *n,
  uint64_t ic,
  uint8_t *k,
  uint8_t *local_state
);

void
Hacl_Symmetric_Salsa20_crypto_stream_salsa20_xor_ic_(
  uint8_t *c,
  uint8_t *m,
  uint64_t mlen,
  uint8_t *n,
  uint64_t ic,
  uint8_t *k
);

void
Hacl_Symmetric_Salsa20_crypto_stream_salsa20_xor_ic(
  uint8_t *c,
  uint8_t *m,
  uint64_t mlen,
  uint8_t *n,
  uint64_t ic,
  uint8_t *k
);

uint64_t
Hacl_Symmetric_Salsa20_crypto_stream_salsa20_loop(
  uint8_t *c,
  uint64_t clen,
  uint8_t *n,
  uint8_t *k,
  uint8_t *input
);

void
Hacl_Symmetric_Salsa20_lemma_modifies_4(
  uint8_t *c,
  uint8_t *input,
  uint8_t *block,
  FStar_HyperStack_mem h0,
  FStar_HyperStack_mem h1,
  FStar_HyperStack_mem h2,
  FStar_HyperStack_mem h3
);

void
Hacl_Symmetric_Salsa20_crypto_stream_salsa20_(uint8_t *n, uint8_t *k, uint8_t *local_state);

void
Hacl_Symmetric_Salsa20_crypto_stream_salsa20(uint8_t *c, uint64_t clen, uint8_t *n, uint8_t *k);

void
Hacl_Symmetric_Salsa20_crypto_stream_salsa20_xor(
  uint8_t *c,
  uint8_t *m,
  uint64_t mlen,
  uint8_t *n,
  uint8_t *k
);
#endif
