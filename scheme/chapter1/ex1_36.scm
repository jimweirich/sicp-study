;; SICP 1.36

;; Exercise 1.36.  Modify fixed-point so that it prints the sequence
;; of approximations it generates, using the newline and display
;; primitives shown in exercise 1.22. Then find a solution to xx =
;; 1000 by finding a fixed point of x -> log(1000)/log(x). (Use
;; Scheme's primitive log procedure, which computes natural
;; logarithms.)  Compare the number of steps this takes with and
;; without average damping. (Note that you cannot start fixed-point
;; with a guess of 1, as this would cause division by log(1) = 0.)

;; ANSWER ------------------------------------------------------------

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))


(define (average a b) (/ (+ a b) 2.0))

(define (damped-fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (average guess (f guess))))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))


(fixed-point (lambda (x) (/ (log 10000) (log x))) 2.0)
;; Takes 28 steps to converge on 5.438579853089483

(damped-fixed-point (lambda (x) (/ (log 10000) (log x))) 2.0) 
;; Takes 10 steps to converge on 5.438585155442469
