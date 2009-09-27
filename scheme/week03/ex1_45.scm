;; SICP 1.45

;; Exercise 1.45.  We saw in section 1.3.3 that attempting to compute
;; square roots by naively finding a fixed point of y x/y does not
;; converge, and that this can be fixed by average damping. The same
;; method works for finding cube roots as fixed points of the
;; average-damped y x/y^2. Unfortunately, the process does not work
;; for fourth roots -- a single average damp is not enough to make a
;; fixed-point search for y x/y^3 converge. On the other hand, if we
;; average damp twice (i.e., use the average damp of the average damp
;; of y x/y^3) the fixed-point search does converge. Do some
;; experiments to determine how many average damps are required to
;; compute nth roots as a fixed-point search based upon repeated
;; average damping of y x/y^(n-1). Use this to implement a simple
;; procedure for computing nth roots using fixed-point, average-damp,
;; and the repeated procedure of exercise 1.43. Assume that any
;; arithmetic operations you need are available as primitives.


;; ANSWER ------------------------------------------------------------

;; This is a long solution.  We will take it bit by bit.  First some
;; simple functions from previous solutions.

(define (average a b) (/ (+ a b) 2.0))

(define (even? n) (zero? (remainder n 2)))

;; Raise x to the n power. (aka exp)
(define (power x n)
  (cond ((zero? n) 1)
        ((even? n) (power (square x) (/ n 2)))
        (else (* x (power x (- n 1))))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (cond ((zero? n) (lambda (x) x))
        (else (compose f (repeated f (- n 1))))))

(define (average-damp f)
  (lambda (x) (average x (f x))))

;; Tolerance for the fixed point function.
(define tolerance 0.00001)

;; Here is the fixed point functions.  We have modified fixed-point to
;; call an abort function if the number of iterations exceeds 100.
;; This allows us to detect non-converging solutions.  The error
;; function is a good choice to pass in for the abort function, i.e.
;;
;;    (fixed-point f guess error)
;;
;; Note: The limit of 100 iterations is rather arbitrary.  Large
;; values of n may require more than 100 iterations before converging,
;; so this may give false readings in that case.
;;
(define (fixed-point f first-guess abort)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess n)
    (if (zero? n)
        (abort "fixed-point didn't converge")
        (let ((next (f guess)))
          (if (close-enough? guess next)
              next
              (try next (- n 1))))))
  (try first-guess 100))

;; Generate the fixed-point function to solve for nth-root of x.
(define (root-fp x n)
  (lambda (y) (/ x (power y (- n 1)))))

;; Try calculating the nth-root of x, using d levels of average
;; damping.  If the solution converges, return the solution.  If the
;; solutions does not converge, then return 'failed.
;;
;; There is a bit of advanced scheme programming going on here.  First
;; we use call-with-current-continuation to create a continuation
;; function cc.  Then we create an abort function that calls (cc
;; 'failed).  If the abort fuction is ever called,
;; call-with-current-continuation will return the value 'failed.  If
;; the abort function is never called, the
;; call-with-current-continuation function returns normally with the
;; actual solution.
;;
;; Since abort is only called if fixed-point determines that the
;; function does not converge, this function returns the solution on
;; converging solutions and 'failed on non-converging solutions.
;;
;; Try calculating the nth root of x using d levels of damping.
;; Return 'failed if the solution doesn't converge.
(define (try-root x n d)
  (call-with-current-continuation
   (lambda (cc)
     (let ((abort (lambda (msg) (cc 'failed))))
       (fixed-point ((repeated average-damp d) (root-fp x n)) 1 abort)))))

;; Determine the amound of damping that is required to for the
;; fixed-point solution for x^n to converge.
(define (determine-damping n)
  (define (loop d)
    (if (equal? 'failed (try-root 10 n d))
        (loop (+ d 1))
        d))
  (loop 1))

;; Generate a list of integers from 1 to n.
(define (integers n)
  (define (loop i)
    (if (> i n)
        ()
        (cons i (loop (+ i 1)))))
  (loop 1))

;; Determine the amount of damping required for n from 1 to 10.
(map determine-damping (integers 10))

;; Determine the nth root of x.  If the solution does not converge,
;; keep adding additional levels of damping until it does.
(define (nth-root x n)
  (define (loop d)
    (let ((result (try-root x n d)))
      (if (equal? 'failed result)
          (loop (+ d 1))
          result)))
  (loop 1))
