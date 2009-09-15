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

(load "../testing.scm")

(define (test-square)
  (assert-equal 1 (square 1))
  (assert-equal 4 (square 2))
  (assert-equal 9 (square 3))
  (assert-equal 256 (square 16)))

(define (test-sum-of-squares)
  (assert-equal 25 (sum-of-squares 3 4)))

(define (test-sum-of-two-largest-squares)
  (assert-equal 41 (sum-of-two-largest-squares 3 4 5))
  (assert-equal 41 (sum-of-two-largest-squares 4 3 5))
  (assert-equal 41 (sum-of-two-largest-squares 4 5 3)))

(define (test)
  (test-square)
  (test-sum-of-squares)
  (test-sum-of-two-largest-squares))
