;; SICP 1.21

;; Exercise 1.21.  Use the smallest-divisor procedure to find the
;; smallest divisor of each of the following numbers: 199, 1999,
;; 19999.

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n)
  (find-divisor n 2))

;; ANSWER ------------------------------------------------------------

(smallest-divisor 199)
;Value: 199

(smallest-divisor 1999)
;Value: 1999

(smallest-divisor 19999)
;Value: 7
