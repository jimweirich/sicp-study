;; SICP 1.25

;; Exercise 1.25.  Alyssa P. Hacker complains that we went to a lot of
;; extra work in writing expmod. After all, she says, since we already
;; know how to compute exponentials, we could have simply written

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

;; Is she correct? Would this procedure serve as well for our fast prime tester? Explain.

;; ANSWER ------------------------------------------------------------

;; The Fermat fast prime testing works by taking a raising a number to
;; the power of the number being tested.  So, in general, the
;; magnitude of the return value of fast-exp would be around n^n.
;;
;; The original expmod function does not ever explicitly calculate the
;; exponentiated value.  At each stage the return value is taken mod n
;; (where n is the number being tested).  So the largest value expmod
;; would deal with would be around the magnitude of n^2.
;;
;; Using Alyssa's version of expmod would make it quite difficult to
;; test larger numbers.
