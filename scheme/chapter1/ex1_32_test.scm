;; SICP 1.32 Tests

(define (identity x) x)
(define (inc n) (+ 1 n))

(define (factorial n)
  (product identity 2 inc n))

(define (sum-integers a b)
  (sum identity a inc b))

(test-case "Ex 1.32 Sum of integers"
            (assert-equal 55 (sum-integers 1 10)))

(test-case "Ex 1.32 Factorial"
           (assert-equal 120 (factorial 5)))
