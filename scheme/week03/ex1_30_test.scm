;; Define some functions using sum

(define (inc n) (+ n 1))

(define (cube n) (* n n n))

(define (sum-cubes a b)
  (sum cube a inc b))

(test-case "Ex 1.30"
           (assert-equal 3025 (sum-cubes 1 10))
            )
