(define (square x) (* x x))

(define (sum-of-squares a b)
  (+ (square a) (square b)) )

(define (sum-of-two-largest-squares a b c)
  (cond ((and (< a b) (< a c))
         (sum-of-squares b c))
        ((and (< b a) (< b c))
         (sum-of-squares a c))
        (else
         (sum-of-squares a b)) ))

;;; ------------------------------------------------------------------

(let ((testing-file
       (get-environment-variable "TESTING_SCM")))
  (if testing-file
      (begin
        (load testing-file)
        
        (test-case "square tests"
                   (assert-equal 1 (square 1))
                   (assert-equal 4 (square 2))
                   (assert-equal 9 (square 3))
                   (assert-equal 256 (square 16)))
        
        (test-case "sum-of-squares test"
                   (assert-equal 25 (sum-of-squares 3 4)))
        
        (test-case "sum-of-two-largest-squares test" 
                   (assert-equal 41 (sum-of-two-largest-squares 3 4 5))
                   (assert-equal 41 (sum-of-two-largest-squares 4 3 5))
                   (assert-equal 41 (sum-of-two-largest-squares 4 5 3)))
        
        (tests))))
