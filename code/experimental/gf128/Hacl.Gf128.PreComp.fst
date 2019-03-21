module Hacl.Gf128.PreComp
open FStar.HyperStack
open FStar.HyperStack.All
open Lib.IntTypes
open Lib.Buffer
open Hacl.Impl.Gf128.Fields
open Hacl.Impl.Gf128.Generic
open Lib.Vec128

module ST = FStar.HyperStack.ST


let gcm_ctx_elem = uint64
let gcm_ctx_len = 266ul
let gcm_ctx_elem_zero = u64 0
let gcm_ctx = lbuffer gcm_ctx_elem gcm_ctx_len


[@ CInline ]
val gcm_init:
    ctx: gcm_ctx
  -> key: lbuffer uint8 16ul ->
  Stack unit
  (requires (fun h -> live h ctx /\ live h key))
  (ensures (fun h0 _ h1 -> modifies (loc ctx) h0 h1))

let gcm_init ctx key = gcm_init #F32 ctx key


inline_for_extraction
val gcm_update_blocks:
    ctx: gcm_ctx
  -> len: size_t{v len % 16 == 0}
  -> text: lbuffer uint8 len ->
  Stack unit
  (requires (fun h -> live h ctx /\ live h text))
  (ensures (fun h0 _ h1 -> modifies (loc ctx) h0 h1))

let gcm_update_blocks  ctx len text = poly4_mul_add #F32 ctx len text


inline_for_extraction
val gcm_update_blocks_padded:
    ctx: gcm_ctx
  -> len: size_t
  -> text: lbuffer uint8 len ->
  Stack unit
  (requires (fun h -> live h ctx /\ live h text))
  (ensures (fun h0 _ h1 -> modifies (loc ctx) h0 h1))

let gcm_update_blocks_padded  ctx len text = poly4_mul_add #F32 ctx len text


inline_for_extraction
val gcm_update_last:
    ctx: gcm_ctx
  -> len: size_t{v len < 16}
  -> text: lbuffer uint8 len ->
  Stack unit
  (requires (fun h -> live h ctx /\ live h text))
  (ensures (fun h0 _ h1 -> modifies (loc ctx) h0 h1))

let gcm_update_last  ctx len text = poly #F32 ctx len text


inline_for_extraction
val gcm_emit:
    tag: lbuffer uint8 16ul
  -> ctx: gcm_ctx ->
  Stack unit
  (requires (fun h -> live h ctx /\ live h tag))
  (ensures (fun h0 _ h1 -> modifies (loc tag) h0 h1))

let gcm_emit tag ctx =
  let acc = get_acc ctx in
  decode tag acc


val ghash:
  tag: block
  -> len: size_t
  -> text: lbuffer uint8 len
  -> key: block ->
  Stack unit
  (requires (fun h -> live h tag /\ live h text /\ live h key))
  (ensures (fun h0 _ h1 -> modifies (loc tag) h0 h1))

let ghash tag len text key =
  ghash_mul_add #F32 tag len text key
