;; SICP 1.33

;; Exercise 1.33.  You can obtain an even more general version of
;; accumulate (exercise 1.32) by introducing the notion of a filter on
;; the terms to be combined. That is, combine only those terms derived
;; from values in the range that satisfy a specified condition. The
;; resulting filtered-accumulate abstraction takes the same arguments
;; as accumulate, together with an additional predicate of one
;; argument that specifies the filter. Write filtered-accumulate as a
;; procedure. Show how to express the following using
;; filtered-accumulate:

;; a. the sum of the squares of the prime numbers in the interval a to
;; b (assuming that you have a prime? predicate already written)

;; b. the product of all the positive integers less than n that are
;; relatively prime to n (i.e., all positive integers i < n such that
;; GCD(i,n) = 1).

;; ANSWER ------------------------------------------------------------

(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (cond ((> a b) result)
          ((filter a) (iter (next a) (combiner (term a) result)))
          (else (iter (next a) result))))
  (iter a null-value))


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

(define (sum-square-primes a b)
  (filtered-accumulate prime? + 0 square a inc b))


(define (product-relatively-prime n)
  (define (identity x) x)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  (define (relatively-prime? i)
    (= 1 (gcd i n)))
  (filtered-accumulate relatively-prime? * 1 identity 1 inc (- n 1)))
