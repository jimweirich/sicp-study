;; SICP 1.46

;; Exercise 1.46.  Several of the numerical methods described in this
;; chapter are instances of an extremely general computational
;; strategy known as iterative improvement. Iterative improvement says
;; that, to compute something, we start with an initial guess for the
;; answer, test if the guess is good enough, and otherwise improve the
;; guess and continue the process using the improved guess as the new
;; guess. Write a procedure iterative-improve that takes two
;; procedures as arguments: a method for telling whether a guess is
;; good enough and a method for improving a guess. Iterative-improve
;; should return as its value a procedure that takes a guess as
;; argument and keeps improving the guess until it is good
;; enough. Rewrite the sqrt procedure of section 1.1.7 and the
;; fixed-point procedure of section 1.3.3 in terms of
;; iterative-improve.

;; ANSWER ------------------------------------------------------------

;; Here is the iterative-improve function.
(define (iterative-improve close-enough? f)
  (lambda (first-guess)
    (define (try guess)
      (let ((next (f guess)))
        (if (close-enough? guess next)
            next
            (try next))))
    (try first-guess)))

;; new-sqrt written with iterative-improve

(define tolerance 0.0001)

(define (average a b) (/ (+ a b) 2.0))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (new-sqrt n)
  ((iterative-improve
    (lambda (guess next) (< (abs (- guess next)) tolerance))
    (average-damp (lambda (y) (/ n y))))
   1.0))


;; fixed-point written with iterative-improve

(define (fixed-point f first-guess)
  ((iterative-improve
    (lambda (guess next) (< (abs (- guess next)) tolerance))
    f)
   first-guess))
