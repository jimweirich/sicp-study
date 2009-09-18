;; Exercise 1.8.  Newton's method for cube roots is based on the fact
;; that if y is an approximation to the cube root of x, then a better
;; approximation is given by the value (image omitted).
;;
;; Use this formula to implement a cube-root procedure analogous to
;; the square-root procedure. (In section 1.3.4 we will see how to
;; implement Newton's method in general as an abstraction of these
;; square-root and cube-root procedures.)

;; ANSWER ------------------------------------------------------------

(define (cbrt x)
  (define (square x) (* x x))

  ;; New improve formula for cube root.
  (define (improve guess x)
    (/ (+ (/ x (square guess)) (* 2 guess))
       3) )

  ;; New good enough test for cube root.  Using the relative epsilon
  ;; code from ex1.7.
  (define (good-enough? guess x)
    (< (abs (- guess (/ x (square guess))))
       (/ guess 1000000)) )
  
  (define (try guess)
    (if (good-enough? guess x)
         guess
        (try (improve guess x))))

  (try 1.0))

;;; ------------------------------------------------------------------

(let ((testing-file
       (get-environment-variable "TESTING_SCM")))
  (if testing-file
      (begin
        (load testing-file)

        (test-case "cube root"
                   (assert-in-delta 3 (cbrt 27) 0.0001))

        (tests))))
