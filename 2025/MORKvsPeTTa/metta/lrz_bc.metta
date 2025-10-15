;; Experiment with hybrid PeTTa-MORK backward chaining using MORK to
;; store the knowledge base.

;;;;;;;;;
;; Nat ;;
;;;;;;;;;

;; ;; Define Nat
;; (: Nat Type)
;; (: Z Nat)
;; (: S (-> Nat Nat))

;; Define cast functions between Nat and Number
;; (: fromNumber (-> Number Nat))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))

;;;;;;;;;;;;;;;;;;;;;;
;; Backward chainer ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Base case: match the knowledge base
(= (bc $kb $_ (: $x $a)) (match $kb (: $x $a) (: $x $a)))

;; Recursive step: unary application
(= (bc $kb (S $k) (: ($f $x) $b))
   (let* (;; Recurse on abstraction
          ((: $f (-> $a $b)) (bc $kb $k (: $f (-> $a $b))))
          ;; Recurse on premise
          ((: $x $a) (bc $kb $k (: $x $a))))
     ;; Output query results
     (: ($f $x) $b)))

;;;;;;;;;;;;;;;;;;;;
;; Knowledge base ;;
;;;;;;;;;;;;;;;;;;;;

;; ;; Knowledge base lives inside MORK
;; !(add-atom &mork (: z T))
;; !(add-atom &mork (: l (-> T T)))
;; !(add-atom &mork (: r (-> T T)))

;; Knowledge base lives inside PeTTa
!(bind! &petta (new-space))
!(add-atom &petta (: z T))
!(add-atom &petta (: l (-> T T)))
!(add-atom &petta (: r (-> T T)))

;;;;;;;;;;;
;; Tests ;;
;;;;;;;;;;;

;; !(bc &mork (fromNumber 16) (: $x T))    ; 27.800s
!(bc &petta (fromNumber 16) (: $x T))   ; 5.192s vs 1.098s
