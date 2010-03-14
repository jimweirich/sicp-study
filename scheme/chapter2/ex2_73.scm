;; SICP 2.73

;; Exercise 2.73.  Section 2.3.2 described a program that performs
;; symbolic differentiation:

;; (define (deriv exp var)
;;   (cond ((number? exp) 0)
;;         ((variable? exp) (if (same-variable? exp var) 1 0))
;;         ((sum? exp)
;;          (make-sum (deriv (addend exp) var)
;;                    (deriv (augend exp) var)))
;;         ((product? exp)
;;          (make-sum
;;            (make-product (multiplier exp)
;;                          (deriv (multiplicand exp) var))
;;            (make-product (deriv (multiplier exp) var)
;;                          (multiplicand exp))))
;;         <more rules can be added here>
;;         (else (error "unknown expression type -- DERIV" exp))))

;; We can regard this program as performing a dispatch on the type of
;; the expression to be differentiated. In this situation the ``type
;; tag'' of the datum is the algebraic operator symbol (such as +) and
;; the operation being performed is deriv. We can transform this
;; program into data-directed style by rewriting the basic derivative
;; procedure as

;; (define (deriv exp var)
;;    (cond ((number? exp) 0)
;;          ((variable? exp) (if (same-variable? exp var) 1 0))
;;          (else ((get 'deriv (operator exp)) (operands exp)
;;                                             var))))
;; (define (operator exp) (car exp))
;; (define (operands exp) (cdr exp))

;; a.  Explain what was done above. Why can't we assimilate the
;; predicates number? and same-variable? into the data-directed
;; dispatch?

;; b.  Write the procedures for derivatives of sums and products, and
;; the auxiliary code required to install them in the table used by
;; the program above.

;; c.  Choose any additional differentiation rule that you like, such
;; as the one for exponents (exercise 2.56), and install it in this
;; data-directed system.

;; d.  In this simple algebraic manipulator the type of an expression
;; is the algebraic operator that binds it together. Suppose, however,
;; we indexed the procedures in the opposite way, so that the dispatch
;; line in deriv looked like

;;   ((get (operator exp) 'deriv) (operands exp) var)

;; What corresponding changes to the derivative system are required? 

;; ANSWER ------------------------------------------------------------

;; A: We are using the operator as the discriminator for the data driven
;; approach.  Neither numbers nor variables have a operator involved.

;; B:

(define (install-deriv-sum)
  ;; Internal procedures
  (define (deriv-sum operands var)
    (let ((addend (car operands))
          (augend (cadr operands)))
      (make-sum (deriv addend  var)
                (deriv augend var))))

  ;; Interface to rest of system
  (put 'deriv '+ deriv-sum)
  'done)

(define (install-deriv-product)
  ;; Internal procedures
  (define (deriv-product operands var)
    (let ((multiplier (car operands))
          (multiplicand (cadr operands)))
      (make-sum
       (make-product multiplier 
                     (deriv multiplicand var))
       (make-product (deriv multiplier var)
                     multiplicand))))

  ;; Interface to rest of system
  (put 'deriv '* deriv-product)
  'done)

;; c.  Choose any additional differentiation rule that you like, such
;; as the one for exponents (exercise 2.56), and install it in this
;; data-directed system.

(define (install-deriv-product)
  ;; Internal procedures
  (define (deriv-product operands var)
    (let ((base (car operands))
          (exp (cadr operands)))
      (make-product
       (make-product
        exponent 
        (make-exponentiation base (make-sum exponent -1)))
       (deriv base var))))

  ;; Interface to rest of system
  (put 'deriv '** deriv-exponentiation)
  'done)

;; D: Just change the put definitions to ...

;;  (put '+ 'deriv deriv-sum)
;;  (put '* 'deriv deriv-product)
;;  (put '** 'deriv deriv-exponentiation)

