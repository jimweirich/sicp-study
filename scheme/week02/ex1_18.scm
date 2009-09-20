;; SICP 1.18

;; Exercise 1.18.  Using the results of exercises 1.16 and 1.17,
;; devise a procedure that generates an iterative process for
;; multiplying two integers in terms of adding, doubling, and halving
;; and uses a logarithmic number of steps.40

(define (double n) (+ n n))

(define (iterative-mult a b)
   (define (loop a b x)
    (cond ((zero? a) x)
          ((even? a) (loop (/ a 2) (double b) x))
          (else (loop (- a 1) b (+ b x)))))
   (loop a b 0))
