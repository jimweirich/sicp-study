;; SICP 2.57

;; Exercise 2.57.  Extend the differentiation program to handle sums
;; and products of arbitrary numbers of (two or more) terms. Then the
;; last example above could be expressed as

;;   (deriv '(* x y (+ x 3)) 'x)

;; Try to do this by changing only the representation for sums and
;; products, without changing the deriv procedure at all. For example,
;; the addend of a sum would be the first term, and the augend would
;; be the sum of the rest of the terms.

;; ANSWER ------------------------------------------------------------

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        ((sum? a1) (make-sum (addend a1) (make-sum (augend a1) a2)))
        ((sum? a2) (append (list '+ a1) (cdr a2)))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        ((product? m1) (make-product (multiplier m1) (make-product (multiplicand m1) m2)))
        ((product? m2) (append (list '* m1) (cdr m2)))
        (else (list '* m1 m2))))

(define (make-exponentiation base exp)
  (cond ((and (number? exp) (=number? exp 0)) 1)
        ((and (number? exp) (=number? exp 1)) base)
        ((and (number? base) (=number? base 1)) 1)
        ((and (number? base) (number? exp)) (** base exp))
        (else (list '** base exp))))

(define (** base exp)
  (if (= exp 0) 1
      (* base (** base (- exp 1)))))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s)
  (cond ((null? (cdddr s));
         (caddr s))
        (else (cons '+ (cddr s)))))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p)
  (cond ((null? (cdddr p)) (caddr p))
        (else (cons '* (cddr p)))))

(define (exponentiation? x)
  (and (pair? x) (eq? '** (car x))))

(define (base x) (cadr x))

(define (exponent x) (caddr x))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product
          (make-product
           (exponent exp)
           (make-exponentiation (base exp) (make-sum (exponent exp) -1)))
          (deriv (base exp) var)))
        (else
         (error "unknown expression type -- DERIV" exp))))
