;; SICP 2.5

;; Exercise 2.5.  Show that we can represent pairs of nonnegative
;; integers using only numbers and arithmetic operations if we
;; represent the pair a and b as the integer that is the product 2a
;; 3b. Give the corresponding definitions of the procedures cons, car,
;; and cdr.

;; ANSWER ------------------------------------------------------------

;; Raise x to the n power. (aka exp)
(define (power x n)
  (cond ((zero? n) 1)
        ((even? n) (power (square x) (/ n 2)))
        (else (* x (power x (- n 1))))))

;; Number of times a is a factor of n
(define (factors n a)
  (define (loop i result)
    (if (= 0 (remainder i a))
        (loop (/ i a) (+ 1 result))
        result))
  (loop n 0))

(define (icons a b)
  (* (power 2 a) (power 3 b)))

(define (icar pair)
  (factors pair 2))

(define (icdr pair)
  (factors pair 3))
