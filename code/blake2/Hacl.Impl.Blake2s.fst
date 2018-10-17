module Hacl.Impl.Blake2s

open FStar.Mul
open FStar.HyperStack
open FStar.HyperStack.ST

open Lib.IntTypes
open Lib.Buffer
open Lib.ByteBuffer
open Lib.LoopCombinators

module ST = FStar.HyperStack.ST
module Seq = Lib.Sequence
module Loops = Lib.LoopCombinators
module Spec = Spec.Blake2


#set-options "--z3rlimit 150"

(* Define algorithm parameters *)
type working_vector = lbuffer uint32 Spec.size_block_w
type message_block_w = lbuffer uint32 Spec.size_block_w
type message_block = lbuffer uint8 (Spec.size_block Spec.Blake2S)
type state = lbuffer uint32 Spec.size_hash_w
type index_t = n:size_t{size_v n < 16}

inline_for_extraction let size_word : size_t = 4ul
inline_for_extraction let size_block x : size_t = (size Spec.size_block_w) *. size_word


/// Constants

let const_iv = icreateL_global Spec.list_iv_S
let const_sigma = icreateL_global Spec.list_sigma
let rTable_S = icreateL_global Spec.rTable_list_S

/// Accessors for constants

val get_iv:
  s:size_t{size_v s < 8} ->
  Stack uint32
    (requires (fun h -> True))
    (ensures  (fun h0 z h1 -> h0 == h1 /\
      uint_v z == uint_v (Seq.index (Spec.ivTable Spec.Blake2S) (size_v s))))

[@ Substitute ]
let get_iv s =
  recall_contents const_iv (Spec.ivTable Spec.Blake2S);
  let r : size_t = iindex const_iv s in
  secret r


val set_iv:
  hash:state ->
  Stack unit
    (requires (fun h -> live h hash))
    (ensures  (fun h0 _ h1 -> modifies1 hash h0 h1
                         /\ h1.[hash] == Seq.map secret (Spec.ivTable Spec.Blake2S)))
[@ Substitute ]
let set_iv hash =
  recall_contents const_iv (Spec.ivTable Spec.Blake2S);
  admit(); // BB. we need Lib.Buffer.map to apply `secret`
  icopy hash (size (Spec.size_hash_w)) const_iv

val set_iv_sub:
  b:lbuffer uint32 16 ->
  Stack unit
    (requires (fun h -> live h b))
    (ensures  (fun h0 _ h1 -> modifies1 b h0 h1
                      /\ (let b0: Seq.lseq uint32 16 = h0.[b] in
                         let b1: Seq.lseq uint32 16 = h1.[b] in
                         let dest = Seq.sub #uint32 #16 b1 8 8 in
                         let src = Seq.map secret (Spec.ivTable Spec.Blake2S) in
                         b1 == Seq.update_sub #uint32 #16 b0 8 8 src)))
[@ Substitute ]
let set_iv_sub b =
  admit();
  let half = sub b (size 8) (size 8) in
  set_iv half


val get_sigma:
  s:size_t{size_v s < 160} ->
  Stack Spec.sigma_elt_t
    (requires (fun h -> True))
    (ensures  (fun h0 z h1 -> h0 == h1 /\ v z == v (Seq.index Spec.const_sigma (size_v s))))

[@ Substitute ]
let get_sigma s =
  recall_contents const_sigma Spec.const_sigma;
  iindex const_sigma s


#set-options "--z3rlimit 15"

val get_sigma_sub:
  start:size_t ->
  i:size_t{v i < 16 /\ v start + v i < 160} ->
  Stack Spec.sigma_elt_t
    (requires (fun h -> True))
    (ensures  (fun h0 z h1 -> h0 == h1 /\ v z == v (Seq.index Spec.const_sigma (v start + v i))))

[@ Substitute ]
let get_sigma_sub start i =
  assert(v start + v i < 160);
  assert(v (start +. i) < 160);
  let x : size_t = start +. i in
  get_sigma x


#reset-options

val get_r:
  s:size_t{size_v s < 4} ->
  Stack (rotval U32)
    (requires (fun h -> True))
    (ensures  (fun h0 z h1 -> h0 == h1 /\ v z == v (Seq.index (Spec.rTable Spec.Blake2S) (v s))))

[@ Substitute ]
let get_r s =
  recall_contents rTable_S (Spec.rTable Spec.Blake2S);
  iindex rTable_S s


/// Define algorithm functions

val g1: wv:working_vector -> a:index_t -> b:index_t -> r:rotval U32 ->
  Stack unit
    (requires (fun h -> live h wv))
    (ensures  (fun h0 _ h1 -> modifies1 wv h0 h1
                         /\ h1.[wv] == Spec.g1 Spec.Blake2S h0.[wv] (v a) (v b) r))

let g1 wv a b r =
  let wv_a = wv.(a) in
  let wv_b = wv.(b) in
  wv.(a) <- (wv_a ^. wv_b) >>>. r


val g2: wv:working_vector -> a:index_t -> b:index_t -> x:uint32 ->
  Stack unit
    (requires (fun h -> live h wv))
    (ensures  (fun h0 _ h1 -> modifies1 wv h0 h1
                         /\ h1.[wv] == Spec.g2 Spec.Blake2S h0.[wv] (v a) (v b) x))

let g2 wv a b x =
  let wv_a = wv.(a) in
  let wv_b = wv.(b) in
  wv.(a) <- add_mod #U32 (wv_a +. wv_b) x


val blake2_mixing : wv:working_vector -> a:index_t -> b:index_t -> c:index_t -> d:index_t -> x:uint32 -> y:uint32 ->
  Stack unit
    (requires (fun h -> live h wv))
    (ensures  (fun h0 _ h1 -> modifies1 wv h0 h1
                         /\ h1.[wv] == Spec.blake2_mixing Spec.Blake2S h0.[wv] (v a) (v b) (v c) (v d) x y))

let blake2_mixing wv a b c d x y =
  let r0 = get_r (size 0) in
  let r1 = get_r (size 1) in
  let r2 = get_r (size 2) in
  let r3 = get_r (size 3) in
  g2 wv a b x;
  g1 wv d a r0;
  g2 wv c d (u32 0);
  g1 wv b c r1;
  g2 wv a b y;
  g1 wv d a r2;
  g2 wv c d (u32 0);
  g1 wv b c r3


#set-options "--z3rlimit 50"

val blake2_round1 : wv:working_vector -> m:message_block_w -> i:size_t{size_v i <= 9} ->
  Stack unit
    (requires (fun h -> live h wv /\ live h m
                  /\ disjoint wv m))
    (ensures  (fun h0 _ h1 -> modifies1 wv h0 h1
                         /\ h1.[wv] == Spec.blake2_round1 Spec.Blake2S h0.[wv] h0.[m] (v i)))

[@ Substitute ]
let blake2_round1 wv m i =
  let start_idx = (i %. (size 10)) *. (size 16) in
  assert(v start_idx == ((v i) % 10) * 16);
  assert((v start_idx) + 16 <= 160);
  let s0 = get_sigma_sub start_idx (size 0) in
  let s1 = get_sigma_sub start_idx (size 1) in
  let s2 = get_sigma_sub start_idx (size 2) in
  let s3 = get_sigma_sub start_idx (size 3) in
  let s4 = get_sigma_sub start_idx (size 4) in
  let s5 = get_sigma_sub start_idx (size 5) in
  let s6 = get_sigma_sub start_idx (size 6) in
  let s7 = get_sigma_sub start_idx (size 7) in
  blake2_mixing wv (size 0) (size 4) (size  8) (size 12) m.(s0) m.(s1);
  blake2_mixing wv (size 1) (size 5) (size  9) (size 13) m.(s2) m.(s3);
  blake2_mixing wv (size 2) (size 6) (size 10) (size 14) m.(s4) m.(s5);
  blake2_mixing wv (size 3) (size 7) (size 11) (size 15) m.(s6) m.(s7)


val blake2_round2 : wv:working_vector -> m:message_block_w -> i:size_t{size_v i <= 9} ->
  Stack unit
    (requires (fun h -> live h wv /\ live h m
                  /\ disjoint wv m))
    (ensures  (fun h0 _ h1 -> modifies1 wv h0 h1
                         /\ h1.[wv] == Spec.blake2_round2 Spec.Blake2S h0.[wv] h0.[m] (v i)))

[@ Substitute ]
let blake2_round2 wv m i =
  let start_idx = (i %. (size 10)) *. (size 16) in
  assert(v start_idx == ((v i) % 10) * 16);
  assert((v start_idx) + 16 <= 160);
  let s8 = get_sigma_sub start_idx (size 8) in
  let s9 = get_sigma_sub start_idx (size 9) in
  let s10 = get_sigma_sub start_idx (size 10) in
  let s11 = get_sigma_sub start_idx (size 11) in
  let s12 = get_sigma_sub start_idx (size 12) in
  let s13 = get_sigma_sub start_idx (size 13) in
  let s14 = get_sigma_sub start_idx (size 14) in
  let s15 = get_sigma_sub start_idx (size 15) in
  blake2_mixing wv (size 0) (size 5) (size 10) (size 15) m.(s8) m.(s9);
  blake2_mixing wv (size 1) (size 6) (size 11) (size 12) m.(s10) m.(s11);
  blake2_mixing wv (size 2) (size 7) (size  8) (size 13) m.(s12) m.(s13);
  blake2_mixing wv (size 3) (size 4) (size  9) (size 14) m.(s14) m.(s15)


val blake2_round : wv:working_vector -> m:message_block_w -> i:size_t{v i <= 9} ->
  Stack unit
    (requires (fun h -> live h wv /\ live h m
                   /\ disjoint wv m))
    (ensures  (fun h0 _ h1 -> modifies1 wv h0 h1
                         /\ h1.[wv] == Spec.blake2_round Spec.Blake2S h0.[m] (v i) h0.[wv]))

let blake2_round wv m i =
  blake2_round1 wv m i;
  blake2_round2 wv m i


#reset-options "--z3rlimit 150"

val blake2_compress1:
    wv:working_vector
  -> s:state
  -> m:message_block_w
  -> offset:uint64
  -> flag:bool ->
  Stack unit
    (requires (fun h -> live h s /\ live h m /\ live h wv
                     /\ disjoint wv s /\ disjoint wv m))
    (ensures  (fun h0 _ h1 -> modifies1 wv h0 h1
                         /\ h1.[wv] == Spec.blake2_compress1 Spec.Blake2S h0.[wv] h0.[s] h0.[m] offset flag))

[@ Substitute ]
let blake2_compress1 wv s m offset flag =
  update_sub wv (size 0) (size 8) s;
  set_iv_sub wv;
  let low_offset = Spec.limb_to_word Spec.Blake2S offset in
  let high_offset = Spec.limb_to_word Spec.Blake2S (offset >>. size 32) in
  let wv_12 = logxor wv.(size 12) low_offset in
  let wv_13 = logxor wv.(size 13) high_offset in
  let wv_14 = logxor wv.(size 14) (u32 0xFFFFFFFF) in
  assume((ones (Spec.wt Spec.Blake2S) SEC) == u32 0xFFFFFFFF);
  wv.(size 12) <- wv_12;
  wv.(size 13) <- wv_13;
 (if flag then wv.(size 14) <- wv_14)


val blake2_compress2 :
  wv:working_vector -> m:message_block_w ->
  Stack unit
    (requires (fun h -> live h wv /\ live h m /\ disjoint wv m))
    (ensures  (fun h0 _ h1 -> modifies1 wv h0 h1
                         /\ h1.[wv] == Spec.blake2_compress2 Spec.Blake2S h0.[wv] h0.[m]))

[@ Substitute ]
let blake2_compress2 wv m =
  let h0 = ST.get () in
  [@inline_let]
  let spec h = Spec.blake2_round Spec.Blake2S h.[m] in
  loop1 h0 (size (Spec.rounds Spec.Blake2S)) wv spec
  (fun i ->
    Loops.unfold_repeati (Spec.rounds Spec.Blake2S) (spec h0) (as_seq h0 wv) (v i);
    blake2_round wv m i)


val blake2_compress3_inner :
  wv:working_vector -> i:size_t{size_v i < 8} -> s:state ->
  Stack unit
    (requires (fun h -> live h s /\ live h wv
                   /\ disjoint s wv /\ disjoint wv s))
    (ensures  (fun h0 _ h1 -> modifies1 s h0 h1
                         /\ h1.[s] == Spec.blake2_compress3_inner Spec.Blake2S h0.[wv] (v i) h0.[s]))

[@ Substitute ]
let blake2_compress3_inner wv i s =
  let i_plus_8 = i +. (size 8) in
  let hi_xor_wvi = s.(i) ^. wv.(i) in
  let hi = logxor #U32 hi_xor_wvi wv.(i_plus_8) in
  s.(i) <- hi


val blake2_compress3 :
  wv:working_vector -> s:state ->
  Stack unit
    (requires (fun h -> live h s /\ live h wv
                     /\ disjoint wv s /\ disjoint s wv))
    (ensures  (fun h0 _ h1 -> modifies1 s h0 h1
                         /\ h1.[s] == Spec.blake2_compress3 Spec.Blake2S h0.[wv] h0.[s]))

[@ Substitute ]
let blake2_compress3 wv s =
  [@inline_let]
  let spec h = Spec.blake2_compress3_inner Spec.Blake2S h.[wv] in
  let h0 = ST.get () in
  loop1 h0 (size 8) s
    (fun h -> spec h)
    (fun i ->
      Loops.unfold_repeati 8 (spec h0) (as_seq h0 s) (v i);
      blake2_compress3_inner wv i s)


val blake2_compress :
    s:state
  -> m:message_block_w
  -> offset:uint64
  -> flag:bool ->
  Stack unit
    (requires (fun h -> live h s /\ live h m
                     /\ disjoint s m /\ disjoint m s))
    (ensures  (fun h0 _ h1 -> modifies1 s h0 h1
                         /\ h1.[s] == Spec.blake2_compress Spec.Blake2S h0.[s] h0.[m] offset flag))

let blake2_compress s m offset flag =
  let h0 = ST.get () in
  [@inline_let]
  let spec _ h1 = h1.[s] == Spec.blake2_compress Spec.Blake2S h0.[s] h0.[m] offset flag in
  salloc1_trivial h0 (size 16) (u32 0) (Ghost.hide (LowStar.Buffer.loc_buffer s)) spec
  (fun wv ->
    blake2_compress1 wv s m offset flag;
    blake2_compress2 wv m;
    blake2_compress3 wv s)


val blake2s_update_block:
    hash:state
  -> prev:size_t{size_v prev <= Spec.max_limb Spec.Blake2S}
  -> d:message_block ->
  Stack unit
    (requires (fun h -> live h hash /\ live h d /\ disjoint hash d))
    (ensures  (fun h0 _ h1 -> modifies1 hash h0 h1
                         /\ h1.[hash] == Spec.blake2_update_block Spec.Blake2S (v prev) h0.[d] h0.[hash]))

let blake2s_update_block hash prev d =
  let h0 = ST.get () in
  [@inline_let]
  let spec _ h1 = h1.[hash] == Spec.blake2_update_block Spec.Blake2S (v prev) h0.[d] h0.[hash] in
  salloc1_trivial h0 (size 16) (u32 0) (Ghost.hide (LowStar.Buffer.loc_buffer hash)) spec
  (fun block_w ->
     uints_from_bytes_le block_w (size Spec.size_block_w) d;
     let offset = to_u64 prev in
     assume(offset == (Spec.to_limb Spec.Blake2S (v prev)));
     blake2_compress hash block_w offset false)


val blake2s_init_hash:
    hash:state
  -> kk:size_t{v kk <= 32}
  -> nn:size_t{1 <= v nn /\ v nn <= 32} ->
  Stack unit
     (requires (fun h -> live h hash))
     (ensures  (fun h0 _ h1 -> modifies1 hash h0 h1
                          /\ h1.[hash] == Spec.blake2_init_hash Spec.Blake2S (v kk) (v nn)))
[@ Substitute]
let blake2s_init_hash hash kk nn =
  set_iv hash;
  let s0 = hash.(size 0) in
  let kk_shift_8 = shift_left #U32 (size_to_uint32 kk) (size 8) in
  let s0' = s0 ^. (u32 0x01010000) ^. kk_shift_8 ^. size_to_uint32 nn in
  hash.(size 0) <- s0'

#reset-options "--z3rlimit 150"

val blake2s_init_branching:
    #vkk:size_t
  -> hash:state
  -> key_block:lbuffer uint8 64
  -> k:lbuffer uint8 (v vkk)
  -> kk:size_t{v kk <= 32 /\ kk == vkk}
  -> nn:size_t{1 <= v nn /\ v nn <= 32} ->
  Stack unit
    (requires (fun h -> live h hash /\ live h k /\ live h key_block
                   /\ disjoint hash k /\ disjoint hash key_block /\ disjoint key_block k))
    (ensures  (fun h0 _ h1 -> modifies2 hash key_block h0 h1
                    /\ (if (v kk) = 0 then h1.[hash] == h0.[hash] else
                       let key_block1 = Seq.update_sub #uint8 #64 h0.[key_block] 0 (v kk) h0.[k] in
                       h1.[hash] == Spec.blake2_update_block Spec.Blake2S (Spec.size_block Spec.Blake2S) key_block1 h0.[hash])))

[@ Substitute ]
let blake2s_init_branching #vkk hash key_block k kk nn =
  let h0 = ST.get () in
  if kk =. (size 0) then
    let h1 = ST.get () in
    assume(modifies0 h0 h1 ==> modifies2 hash key_block h0 h1)
  else begin
    update_sub key_block (size 0) kk k;
    blake2s_update_block hash (size_block Spec.Blake2S) key_block
  end


val blake2s_init:
    #vkk:size_t
  -> hash:state
  -> k:lbuffer uint8 (v vkk)
  -> kk:size_t{v kk <= 32 /\ kk == vkk}
  -> nn:size_t{1 <= v nn /\ v nn <= 32} ->
  Stack unit
    (requires (fun h -> live h hash
                   /\ live h k
                   /\ disjoint hash k /\ disjoint k hash))
    (ensures  (fun h0 _ h1 -> modifies1 hash h0 h1
                         /\ h1.[hash] == Spec.Blake2.blake2_init Spec.Blake2S (v kk) h0.[k] (v nn)))

[@ Substitute ]
let blake2s_init #vkk hash k kk nn =
  let h0 = ST.get () in
  salloc1_trivial h0 (size 64) (u8 0) (Ghost.hide (LowStar.Buffer.loc_buffer hash))
  (fun _ h1 -> h1.[hash] == Spec.blake2_init Spec.Blake2S (v kk) h0.[k] (v nn))
  (fun key_block ->
    blake2s_init_hash hash kk nn;
    blake2s_init_branching #vkk hash key_block k kk nn)


val blake2s_update_last:
    #vlen: size_t
  -> hash: state
  -> prev: size_t{v prev <= Spec.max_limb Spec.Blake2S}
  -> last: lbuffer uint8 (v vlen)
  -> len: size_t{v len <= Spec.size_block Spec.Blake2S /\ len == vlen} ->
  Stack unit
    (requires (fun h -> live h hash /\ live h last /\ disjoint hash last))
    (ensures  (fun h0 _ h1 -> modifies1 hash h0 h1
                         /\ h1.[hash] == Spec.Blake2.blake2_update_last Spec.Blake2S (v prev) (v len) h0.[last] h0.[hash]))

let blake2s_update_last #vlen hash prev last len =
  push_frame ();
  let last_block = create #uint8 64ul (u8 0) in
  let last_block_w = create #uint32 16ul (u32 0) in
  update_sub last_block (size 0) len last;
  uints_from_bytes_le last_block_w (size 16) last_block;
  let offset = to_u64 prev in
  assume(offset == (Spec.to_limb Spec.Blake2S (v prev)));
  blake2_compress hash last_block_w offset true;
  pop_frame ()


val blake2s_finish:
    #vnn: size_t
  -> output: lbuffer uint8 (v vnn)
  -> hash: state
  -> nn: size_t{1 <= v nn /\ v nn <= 32 /\ nn == vnn} ->
  Stack unit
    (requires (fun h -> live h hash
                   /\ live h output /\ disjoint output hash /\ disjoint hash output))
    (ensures  (fun h0 _ h1 -> modifies1 output h0 h1
                         /\ h1.[output] == Spec.Blake2.blake2_finish Spec.Blake2S h0.[hash] (v nn)))

let blake2s_finish #vnn output hash nn =
  let h0 = ST.get () in
  salloc1_trivial h0 (size 32) (u8 0) (Ghost.hide (LowStar.Buffer.loc_buffer output))
  (fun _ h1 -> h1.[output] == Spec.Blake2.blake2_finish Spec.Blake2S h0.[hash] (v nn))
  (fun full ->
    uints_to_bytes_le full (size 8) hash;
    let final = sub full (size 0) nn in
    copy output nn final)



val blake2s_update:
    #vll: size_nat
  -> hash: state
  -> d: lbuffer uint8 vll
  -> ll: size_t{v ll == vll}
  -> kk: size_t{v kk <= 32 /\ (if v kk = 0 then v ll < pow2 64 else v ll + 64 < pow2 64)} ->
  Stack unit
    (requires (fun h -> live h hash /\ live h d /\ disjoint hash d))
    (ensures  (fun h0 _ h1 -> modifies1 hash h0 h1
                         /\ h1.[hash] == Spec.blake2_update Spec.Blake2S h0.[hash] h0.[d] (v kk)))

let blake2s_update #vll hash d ll kk =
  let klen = if kk = size 0 then size 0 else size 1 in
  admit();
  loopi_blocks (size_block Spec.Blake2S) ll d
    (fun i -> Spec.blake2_update_block Spec.Blake2S (((v klen) + i + 1) * (Spec.size_block Spec.Blake2S)))
    (fun i -> Spec.blake2_update_last Spec.Blake2S ((v klen) * (Spec.size_block Spec.Blake2S) + (v ll)))
    (fun i block hash -> blake2s_update_block hash ((klen +. i +. 1) *. (size 64)) block)
    (fun i rem last hash -> blake2s_update_last hash (klen *. (size 64) +. ll) last rem) hash


val blake2s:
    output: buffer uint8
  -> d: buffer uint8
  -> ll: size_t{length d == v ll}
  -> k: buffer uint8
  -> kk: size_t{length k == v kk /\ v kk <= 32 /\ (if v kk = 0 then v ll < pow2 64 else v ll + 64 < pow2 64)}
  -> nn:size_t{v nn == length output /\ 1 <= v nn /\ v nn <= 32} ->
  Stack unit
    (requires (fun h -> LowStar.Buffer.live h output
                   /\ LowStar.Buffer.live h d
                   /\ LowStar.Buffer.live h k
                   /\ LowStar.Buffer.disjoint output d
                   /\ LowStar.Buffer.disjoint output k))
    (ensures  (fun h0 _ h1 -> LowStar.Buffer.modifies (LowStar.Buffer.loc_buffer output) h0 h1
                         /\ h1.[output] == Spec.Blake2.blake2s h0.[d] (v kk) h0.[k] (v nn)))

let blake2s output d ll k kk nn =
  let h0 = ST.get () in
  salloc1_trivial h0 (size 8) (u32 0) (Ghost.hide (LowStar.Buffer.loc_buffer output))
  (fun _ h1 -> h1.[output] == Spec.Blake2.blake2s h0.[d] (v kk) h0.[k] (v nn))
  (fun hash ->
    blake2s_init #kk hash k kk nn;
    blake2s_update #(v ll) hash d ll kk;
    blake2s_finish #nn output hash nn)