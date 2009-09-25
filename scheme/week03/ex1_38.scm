;; SICP 1.38

;; Exercise 1.38.  In 1737, the Swiss mathematician Leonhard Euler
;; published a memoir De Fractionibus Continuis, which included a
;; continued fraction expansion for e - 2, where e is the base of the
;; natural logarithms. In this fraction, the Ni are all 1, and the Di
;; are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, .... Write a
;; program that uses your cont-frac procedure from exercise 1.37 to
;; approximate e, based on Euler's expansion.

;; ANSWER ------------------------------------------------------------

(define (cont-frac n d k)
  (define (iter i result)
    (if (zero? i)
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter (- k 1) (/ (n k) (d k))))

(define (e)
  (define (one n) 1)
  (define (d n)
    (cond ((= (remainder n 3) 2)
           (+ 2 (* 2 (quotient n 3))))
          (else 1)))
  (+ 2.0 (cont-frac one d 10)))
