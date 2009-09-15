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

(define (is expected actual)
  (if (not (equal expected actual))
      (error "Ooops")) )

(and  (equal? 41 (sum-of-two-largest-squares 3 4 5))
      (equal? 41 (sum-of-two-largest-squares 4 3 5))
      (equal? 41 (sum-of-two-largest-squares 4 5 3)))
