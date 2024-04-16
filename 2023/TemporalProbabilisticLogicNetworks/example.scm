;; Code snippet to calculate the numerical values of the example
;; (extracted from opencog/ure and opencog/pln repositories).

;; Limit an number to be within a certain range
(define (clamp x l u)
  (max l (min u x)))

;; Consistency Conditions
(define (smallest-intersection-probability sA sB)
  (clamp (/ (+ sA sB -1) sA) 0 1))

(define (largest-intersection-probability sA sB)
  (clamp (/ sB sA) 0 1))

(define (conditional-probability-consistency sA sB sAB)
  (and (< 0 sA)
       (<= (smallest-intersection-probability sA sB) sAB)
       (<= sAB (largest-intersection-probability sA sB))))

;; Main Formula
(define (simple-deduction-strength-formula sA sB sC sAB sBC)
  (if
     (and
        (conditional-probability-consistency sA sB sAB)
        (conditional-probability-consistency sB sC sBC))
     ;; Preconditions are met
     (if (< 0.99 sB)
        ;; sB tends to 1
        sC
        ;; otherwise
        (+ (* sAB sBC) (/ (* (- 1 sAB) (- sC (* sB sBC))) (- 1 sB))))
     ;; Preconditions are not met
     0))

;; Convert Simple TV count into confidence
(define-public (count->confidence c)
  (define K 100)
  (exact->inexact (/ c (+ c K))))

;; P strength, count and confidence
(define Ps 1.0)
(define Pcnt 2)
(define Pc (count->confidence Pcnt))

;; Q strength, count and confidence
(define Qs 0.5)
(define Qcnt 2)
(define Qc (count->confidence Qcnt))

;; R strength, count and confidence & count
(define Rs 0.2)
(define Rcnt 100)
(define Rc (count->confidence Rcnt))

;; P->Q strength, count and confidence & count
(define PQs 0.5)
(define PQcnt 2)
(define PQc (count->confidence PQcnt))

;; Q->R strength, count and confidence & count
(define QRs 0.3)
(define QRcnt 10)
(define QRc (count->confidence QRcnt))

;; P->R strength, count and confidence
(define PRs (simple-deduction-strength-formula Ps Qs Rs PQs QRs))
(define PRcnt (* 0.9 (min PQcnt QRcnt)))
(define PRc (count->confidence PRcnt))

(define results (format #f "P ≞ <~a, ~a>, Q ≞ <~a, ~a>, R ≞ <~a, ~a>, PQ ≞ <~a, ~a>, QR ≞ <~a, ~a>, PR ≞ <~a, ~a>" Ps Pc Qs Qc Rs Rc PQs PQc QRs QRc PRs PRc))
