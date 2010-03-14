;; SICP 2.6

;; Exercise 2.6.  In case representing pairs as procedures wasn't
;; mind-boggling enough, consider that, in a language that can
;; manipulate procedures, we can get by without numbers (at least
;; insofar as nonnegative integers are concerned) by implementing 0
;; and the operation of adding 1 as

;; (define zero (lambda (f) (lambda (x) x)))

;; (define (add-1 n)
;;  (lambda (f) (lambda (x) (f ((n f) x)))))

;; This representation is known as Church numerals, after its
;; inventor, Alonzo Church, the logician who invented the calculus.

;; Define one and two directly (not in terms of zero and
;; add-1). (Hint: Use substitution to evaluate (add-1 zero)). Give a
;; direct definition of the addition procedure + (not in terms of
;; repeated application of add-1).

;; ANSWER ------------------------------------------------------------

(define zero
  (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;; Expand one
;; (add-1 zero)
;; (add-1 (lambda (f) (lambda (x) x)))
;; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))

;; I think that's all the farther we can reduce one according to the
;; expansion rules (since the lambda body is not evaluated until the
;; function is called).  But some of the function applications inside
;; the outer lambda don't depend on the data and we can perform some
;; additional simplifications.

;; (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
;; (lambda (f) (lambda (x) (f x)))

;; So here's the simplified definition of one.  One is a function that
;; takes a function argument f and returns a function that applies f
;; to its argument once.

(define one
  (lambda (f) (lambda (x) (f x))))

;; Expand two, using the simplified version of one:
;; (add-1 one)
;; (add-1 (lambda (f) (lambda (x) (f x))))
;; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
;;
;; Again, here we perform some internal optimizations.
;;
;; (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
;; (lambda (f) (lambda (x) (f (f x))))

;; And here's the definition of two.  It is a function that takes a
;; function f and returns a function that applies f twice.

(define two
  (lambda (f) (lambda (x) (f (f x)))))

;; Now to define add directly.  

(define (add a b)
  (lambda (f)
    (lambda (x) ((a f) ((b f) x)))))
