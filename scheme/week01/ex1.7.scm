(define (sqrt x)
  (define (average x y)
    (/ (+ x y) 2))

  (define (improve guess x)
    (average guess (/ x guess)))

  ;; New version of good-enough? that is relative to the size of the
  ;; guess.
  (define (good-enough? guess x)
    (< (abs (- guess (/ x guess)))
       (/ guess 1000000)) )

  (define (try guess)
    (if (good-enough? guess x)
        guess
        (try (improve guess x))))

  (try 1.0))

;; The fixed epsilon meands that the square root of small number will
;; not be very accurate, and that the square root of large numbers my
;; be overly precise (and therefore take extra, unneeded iterations to
;; compute).
;;
;; Making the epsilon relative to the guess corrects both of these
;; issues.
