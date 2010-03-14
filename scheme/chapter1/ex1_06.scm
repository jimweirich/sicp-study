;; SICP 1.6

;; Exercise 1.6.  Alyssa P. Hacker doesn't see why if needs to be
;; provided as a special form. ``Why can't I just define it as an
;; ordinary procedure in terms of cond?'' she asks. Alyssa's friend
;; Eva Lu Ator claims this can indeed be done, and she defines a new
;; version of if:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;; Eva demonstrates the program for Alyssa:

(new-if (= 2 3) 0 5)
5

(new-if (= 1 1) 0 5)
0

;; Delighted, Alyssa uses new-if to rewrite the square-root program:

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

;; What happens when Alyssa attempts to use this to compute square roots? Explain. 

;; ANSWER ------------------------------------------------------------
;;
;; "if" is a special form in Scheme, meaning that the interpreter
;; treats it special.  It is not a function, so applicative order
;; evaluation does not apply in its case.
;;
;; Unfortunately, Alyssa's new-if is a function, and the applicative
;; order rules say that the sqrt-iter recursion happens before the
;; new-if has a chance to choose between the true/false branches.
