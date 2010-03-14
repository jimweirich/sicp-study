;; SICP 1.39

;; Exercise 1.39.  A continued fraction representation of the tangent
;; function was published in 1770 by the German mathematician
;; J.H. Lambert:

;;             r
;; tan r = ---------------
;;                  r^2
;;         1 - -----------
;;                    r^2
;;             3 - -------
;;                 5 - ...

;; where x is in radians. Define a procedure (tan-cf x k) that
;; computes an approximation to the tangent function based on
;; Lambert's formula. K specifies the number of terms to compute, as
;; in exercise 1.37.


;; ANSWER ------------------------------------------------------------

(define (cont-frac n d k)
  (define (iter i result)
    (if (zero? i)
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter (- k 1) (/ (n k) (d k))))

(define (square n) (* n n))

(define (tan-cf x k)
  (define (numerator k)
    (if (= k 1) x (- (square x))))
  (define (denominator k)
    (- (* k 2) 1))
  (cont-frac numerator denominator k))
