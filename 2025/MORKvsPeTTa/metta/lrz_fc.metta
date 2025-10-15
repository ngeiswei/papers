;; Define Nat
(: Nat Type)
(: Z Nat)
(: S (-> Nat Nat))

;; Cast Number into Nat
(: fromNumber (-> Number Nat))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))

;; lrz forward chainer
(: lrz_fc (-> Nat $a $a))
(= (lrz_fc $_ (: $x T)) (: $x T))
(= (lrz_fc (S $k) (: $x T)) (lrz_fc $k (: (l $x) T)))
(= (lrz_fc (S $k) (: $x T)) (lrz_fc $k (: (r $x) T)))

;; Test
!(lrz_fc (fromNumber 16) (: z T)) ; 4.639s, vs 0.833s with MORK
