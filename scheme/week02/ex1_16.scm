;; SICP 1.16

;; Exercise 1.16.  Design a procedure that evolves an iterative
;; exponentiation process that uses successive squaring and uses a
;; logarithmic number of steps, as does fast-expt. (Hint: Using the
;; observation that (bn/2)2 = (b2)n/2, keep, along with the exponent n
;; and the base b, an additional state variable a, and define the
;; state transformation in such a way that the product a bn is
;; unchanged from state to state. At the beginning of the process a is
;; taken to be 1, and the answer is given by the value of a at the end
;; of the process. In general, the technique of defining an invariant
;; quantity that remains unchanged from state to state is a powerful
;; way to think about the design of iterative algorithms.)

;; ANSWER ------------------------------------------------------------

(define (linear-exp b n)
  (cond ((zero? n) 1)
        (else (* b (linear-exp b (- n 1))))))

(define (fast-exp b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (square n) (* n n))

(define (fexp b n)
  (define (loop b n a)
    (cond ((zero? n) a)
          ((even? n) (fexp-loop (square b) (/ n 2) a))
          (else (fexp-loop b (- n 1) (* b a)))))
  (loop b n 1))

