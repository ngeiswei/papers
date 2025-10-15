;; ;; Define Nat
;; (: Nat Type)
;; (: Z Nat)
;; (: S (-> Nat Nat))

;; Cast Number into Nat
(: fromNumber (-> Number Nat))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))

;; lz forward chainer
;; (: lz_fc (-> Nat $a $a))
(= (lz_fc $_ (: $x T)) (: $x T))
(= (lz_fc (S $k) (: $x T)) (lz_fc $k (: (l $x) T)))

;; Test
!(lz_fc (fromNumber 5000) (: z T)) ; 4.639s, vs 0.833s with MORK
