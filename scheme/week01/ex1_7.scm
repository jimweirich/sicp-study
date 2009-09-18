;; SICP 1.7

;; Exercise 1.7.  The good-enough? test used in computing square roots
;; will not be very effective for finding the square roots of very
;; small numbers. Also, in real computers, arithmetic operations are
;; almost always performed with limited precision. This makes our test
;; inadequate for very large numbers. Explain these statements, with
;; examples showing how the test fails for small and large numbers. An
;; alternative strategy for implementing good-enough? is to watch how
;; guess changes from one iteration to the next and to stop when the
;; change is a very small fraction of the guess. Design a square-root
;; procedure that uses this kind of end test. Does this work better
;; for small and large numbers?

;; ANSWER ------------------------------------------------------------

;; The fixed epsilon means that the square root of a small number will
;; not be very accurate.  In the extreme, numbers smaller than epsilon
;; could be their own square roots (as far as the algorithm is
;; concerned).
;;
;; The problem with a fixed size epsilon and large numbers is a bit
;; different.  The small epsilon may cause the algorithm to iterate
;; more often than would be strictly necessary.  In the extreme case
;; where the magnitude of n is greater than the precision of the float
;; point number representations, it is entire possible that the
;; algorithm will never converge on an answer that is smaller than
;; delta. 
;;
;; Making the epsilon relative to the guess corrects both of these
;; issues.

(define (sqrt x)
  (define (average x y)
    (/ (+ x y) 2))

  (define (improve guess x)
    (average guess (/ x guess)))

  ;; New version of good-enough? that is relative to the size of the
  ;; guess.
  (define (good-enough? guess x)
    (< (abs (- guess (/ x guess)))
       (/ guess 1000000)) )

  (define (try guess)
    (if (good-enough? guess x)
        guess
        (try (improve guess x))))

  (try 1.0))

