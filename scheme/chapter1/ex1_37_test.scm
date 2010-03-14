;; SICP 1.37 Tests

(define (one x) 1)

(define (r-cf) (r-cont-frac one one 11))
(test-case "Ex 1.37 Continued Fraction Recursive version" 
           (assert-in-delta 0.6180 (r-cf) 0.0001))

(define (i-cf) (i-cont-frac one one 11))
(test-case "Ex 1.37 Continued Fraction Iterative version" 
           (assert-in-delta 0.6180 (i-cf) 0.0001))
