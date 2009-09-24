;; SICP 1.27

;; Exercise 1.27.  Demonstrate that the Carmichael numbers listed in
;; footnote 47 really do fool the Fermat test. That is, write a
;; procedure that takes an integer n and tests whether an is congruent
;; to a modulo n for every a<n, and try your procedure on the given
;; Carmichael numbers.

;; ANSWER ------------------------------------------------------------

;; Carmichael Numbers as defined in footnote 46.
(define carmichael-numbers
  '(561 1105 1729 2465 2821 6601))

;; The Fermat prime test code, rewritten to comprehensively test all
;; the numbers.

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))        

(define (try-it n a)
  (= (expmod a n n) a)  )

(define (fermat-prime? n)
  (define (loop a)
    (cond ((>= a n) true)
          ((try-it n a) (loop (+ a 1)))
          (else false)))
  (loop 1))

;; The standard prime test code.

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n) (and (> n 1) (= n (smallest-divisor n))))

;; And some predicate testing helper functions.

(define (all? pred items)
  (cond ((null? items) true)
        ((pred (car items)) (all? pred (cdr items)))
        (else false)))

(define (none? pred items)
  (cond ((null? items) true)
        ((pred (car items)) false)
        (else (none? pred (cdr items)))))

;; The following expression is true.  All the Carmichael numbers are
;; non-primes and yet they pass the comprehensive fermat prime test.

(and
 (all? fermat-prime? carmichael-numbers)
 (none? prime? carmichael-numbers))
