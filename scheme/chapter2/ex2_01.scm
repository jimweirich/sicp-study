;; SICP 2.1

;; Exercise 2.1.  Define a better version of make-rat that handles
;; both positive and negative arguments. Make-rat should normalize the
;; sign so that if the rational number is positive, both the numerator
;; and denominator are positive, and if the rational number is
;; negative, only the numerator is negative.

;; ANSWER ------------------------------------------------------------

(define (make-rat n d)
  (define (build n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (if (< d 0)
      (build (- n) (- d))
      (build n d)))

