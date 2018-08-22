module MPFR.Mul_1

open FStar.HyperStack.All
open FStar.HyperStack
open FStar.HyperStack.ST
open FStar.Buffer
open FStar.UInt64
open FStar.Int.Cast
open MPFR.Dyadic
open MPFR.Lib.Spec
open MPFR.Mul.Spec
open MPFR.Round.Spec
open MPFR.Maths

open MPFR.Umul_ppmm
open MPFR.Lib
open MPFR.Exceptions

open MPFR.Exceptions.Lemma
//open MPFR.Add1sp1.Lemma

module ST = FStar.HyperStack.ST
module I64 = FStar.Int64
module I32 = FStar.Int32
module U32 = FStar.UInt32

#set-options "--z3refresh --z3rlimit 100 --max_fuel 1 --initial_fuel 0 --max_ifuel 1 --initial_ifuel 0"

open FStar.Mul

private type mpfr_tmp_exp_t = x:mpfr_exp_t{I32.(x >=^ mpfr_EMIN -^ 1l /\ x <=^ mpfr_EMAX)}

inline_for_extraction val mpfr_add_one_ulp: a:mpfr_ptr -> rnd_mode:mpfr_rnd_t -> sh:mpfr_prec_t -> ax:mpfr_tmp_exp_t ->
    Stack i32
    (requires (fun h ->
        mpfr_live h a /\ length (as_struct h a).mpfr_d = 1 /\
	U32.v sh + U32.v (as_struct h a).mpfr_prec = 64 /\
	normal_cond h a))
    (ensures  (fun h0 t h1 ->
        mpfr_live h1 a /\ mpfr_modifies a h0 h1))

let mpfr_add_one_ulp a rnd_mode sh ax =
    let h0 = ST.get() in
    let ap = mpfr_MANT a in
    ap.(0ul) <- ap.(0ul) +%^ (mpfr_LIMB_ONE <<^ sh);
    let h1 = ST.get() in
    lemma_reveal_modifies_1 ap h0 h1;
    lemma_intro_modifies_2 a ap h0 h1;
    if ap.(0ul) =^ 0uL then begin
        ap.(0ul) <- mpfr_LIMB_HIGHBIT;
	if I32.(ax +^ 1l >^ mpfr_EMAX) then mpfr_overflow a rnd_mode (mpfr_SIGN a)
	else (mpfr_SET_EXP a I32.(ax +^ 1l); mpfr_RET (mpfr_SIGN a))
    end else mpfr_RET (mpfr_SIGN a)

inline_for_extraction val mpfr_mul_1_rounding: a:mpfr_ptr -> sh:mpfr_prec_t -> ax:mpfr_tmp_exp_t -> 
    rb:mp_limb_t -> sb:mp_limb_t -> rnd_mode:mpfr_rnd_t -> Stack i32
    (requires (fun h ->
        mpfr_live h a /\ length (as_struct h a).mpfr_d = 1 /\
	U32.v sh + U32.v (as_struct h a).mpfr_prec = 64 /\
	normal_cond_ h ({as_struct h a with mpfr_exp = ax})))
    (ensures  (fun h0 t h1 ->
        mpfr_live h1 a /\ mpfr_modifies a h0 h1))

let mpfr_mul_1_rounding a sh ax rb sb rnd_mode =
    let ap = mpfr_MANT a in
    let a0 = ap.(0ul) in
    let h0 = ST.get() in
    mpfr_SET_EXP a ax;
    let h1 = ST.get() in
    if rb =^ 0uL && sb =^ 0uL then mpfr_RET 0l
    else if MPFR_RNDN? rnd_mode then
        if (rb =^ 0uL || (sb =^ 0uL && ((a0 &^ (mpfr_LIMB_ONE <<^ sh)) =^ 0uL))) then
	    mpfr_RET (mpfr_NEG_SIGN (mpfr_SIGN a))
	else mpfr_add_one_ulp a rnd_mode sh ax
    else if mpfr_IS_LIKE_RNDZ rnd_mode (mpfr_IS_NEG a) then 
        mpfr_RET (mpfr_NEG_SIGN (mpfr_SIGN a))
    else mpfr_add_one_ulp a rnd_mode sh ax

inline_for_extraction val mpfr_mul_1_round: a:mpfr_ptr -> sh:mpfr_prec_t -> ax:mpfr_exp_t ->
    rb:mp_limb_t -> sb:mp_limb_t -> mask:mp_limb_t -> rnd_mode:mpfr_rnd_t -> Stack i32
    (requires (fun h ->
        mpfr_live h a /\ length (as_struct h a).mpfr_d = 1 /\
	U32.v sh + U32.v (as_struct h a).mpfr_prec = 64 /\
	normal_cond_ h ({as_struct h a with mpfr_exp = ax})))
    (ensures  (fun h0 t h1 ->
        mpfr_live h1 a /\ mpfr_modifies a h0 h1))

let mpfr_mul_1_round a sh ax rb sb mask rnd_mode =
    let ap = mpfr_MANT a in
    let a0 = ap.(0ul) in
    if I32.(ax >^ mpfr_EMAX) then mpfr_overflow a rnd_mode (mpfr_SIGN a)
    else if I32.(ax <^ mpfr_EMIN) then begin
        let aneg = mpfr_IS_NEG a in
        if I32.(ax =^ mpfr_EMIN -^ 1l) && a0 =^ lognot mask &&
	   ((MPFR_RNDN? rnd_mode && rb >^ 0uL) ||
	    (((rb |^ sb) >^ 0uL) && mpfr_IS_LIKE_RNDA rnd_mode aneg)) 
	then mpfr_mul_1_rounding a sh ax rb sb rnd_mode
        else if MPFR_RNDN? rnd_mode &&
	        (I32.(ax <^ mpfr_EMIN -^ 1l) ||
		 (a0 =^ mpfr_LIMB_HIGHBIT && ((rb |^ sb) =^ 0uL)))
        then mpfr_underflow a MPFR_RNDZ (mpfr_SIGN a)
        else mpfr_underflow a rnd_mode (mpfr_SIGN a)
    end else mpfr_mul_1_rounding a sh ax rb sb rnd_mode

val mpfr_mul_1: a:mpfr_ptr -> b:mpfr_ptr -> c:mpfr_ptr ->
                rnd_mode:mpfr_rnd_t -> p:mpfr_prec_t -> Stack i32
    (requires (fun h ->
        (* Memory safety *)
        mpfr_live h a /\ mpfr_live h b /\ mpfr_live h c /\
        mpfr_disjoint_or_equal h a b /\ mpfr_disjoint_or_equal h a c /\
        mpfr_disjoint_or_equal h b c /\
        length (as_struct h a).mpfr_d = 1 /\
        length (as_struct h b).mpfr_d = 1 /\ length (as_struct h c).mpfr_d = 1 /\
        (* Functional correctness *)
        U32.v p > 0 /\ U32.v p < 64 /\ p = (as_struct h a).mpfr_prec /\
        U32.v (as_struct h b).mpfr_prec <= 64 /\ U32.v (as_struct h c).mpfr_prec <= 64 /\
        mpfr_valid_cond h a /\ mpfr_reg_cond h b /\ mpfr_reg_cond h c))
    (ensures  (fun h0 t h1 -> 
        let exact = mul_exact (as_fp h0 b) (as_fp h0 c) in
        (* Memory safety *)
        mpfr_live h1 a /\ mpfr_live h1 b /\ mpfr_live h1 c /\
        mpfr_disjoint_or_equal h1 a b /\ mpfr_disjoint_or_equal h1 a c /\
        mpfr_disjoint_or_equal h1 b c /\ mpfr_modifies a h0 h1 (*/\
        (* Functional correctness *)
        mpfr_valid_cond h1 a /\ 
        mpfr_round_cond exact (U32.v p) rnd_mode (as_fp h1 a) /\
        mpfr_ternary_cond (I32.v t) exact (as_fp h1 a)*)))

let mpfr_mul_1 a b c rnd_mode p =
    let ap = mpfr_MANT a in
    let bp = mpfr_MANT b in
    let cp = mpfr_MANT c in
    let b0 = bp.(0ul) in
    let c0 = cp.(0ul) in
    let sh = U32.(gmp_NUMB_BITS -^ p) in
    let mask = mpfr_LIMB_MASK sh in
    let ax = I32.(mpfr_EXP b +^ mpfr_EXP c) in
    let a0, sb = umul_ppmm b0 c0 in
    let ax, a0, sb =
        if a0 <^ mpfr_LIMB_HIGHBIT then
	    I32.(ax -^ 1l), (a0 <<^ 1ul) |^ (sb >>^ U32.(gmp_NUMB_BITS -^ 1ul)), sb <<^ 1ul
	else ax, a0, sb in
    let rb = a0 &^ (mpfr_LIMB_ONE <<^ U32.(sh -^ 1ul)) in
    let sb = sb |^ ((a0 &^ mask) ^^ rb) in
    ap.(0ul) <- a0 &^ (lognot mask);
    mpfr_SET_SIGN a (mpfr_MULT_SIGN (mpfr_SIGN b) (mpfr_SIGN c));
    let h = ST.get() in
    assume(normal_cond_ h ({as_struct h a with mpfr_exp = ax}));
    mpfr_mul_1_round a sh ax rb sb mask rnd_mode