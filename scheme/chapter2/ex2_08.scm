;; SICP 2.8

;; Exercise 2.8.  Using reasoning analogous to Alyssa's, describe how
;; the difference of two intervals may be computed. Define a
;; corresponding subtraction procedure, called sub-interval.

;; ANSWER ------------------------------------------------------------

(define (sub-interval a b)
  (make-interval
   (- (lower-bound a) (upper-bound b))
   (- (upper-bound a) (lower-bound b))))
