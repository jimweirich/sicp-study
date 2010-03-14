;; SICP 2.77

;; Exercise 2.77.  Louis Reasoner tries to evaluate the expression
;; (magnitude z) where z is the object shown in figure 2.24. To his
;; surprise, instead of the answer 5 he gets an error message from
;; apply-generic, saying there is no method for the operation
;; magnitude on the types (complex). He shows this interaction to
;; Alyssa P. Hacker, who says ``The problem is that the complex-number
;; selectors were never defined for complex numbers, just for polar
;; and rectangular numbers. All you have to do to make this work is
;; add the following to the complex package:''

;; (put 'real-part '(complex) real-part)
;; (put 'imag-part '(complex) imag-part)
;; (put 'magnitude '(complex) magnitude)
;; (put 'angle '(complex) angle)

;; Describe in detail why this works. As an example, trace through all
;; the procedures called in evaluating the expression (magnitude z)
;; where z is the object shown in figure 2.24. In particular, how many
;; times is apply-generic invoked? What procedure is dispatched to in
;; each case?

;; ANSWER ------------------------------------------------------------

;; In order for (magnitude z) to work, there must [1] be a defintion
;; of magnitude that invokes apply-generic (I don't think that was
;; given in the book), and [2] the type of z in question must contain
;; a handler for 'magnitude.
;;
;; Here is the sequence.
;;
;; [1] (magnitude c)      -- Call generic magnitude on a complex/rectangular number
;; [2] (magnitude r)      -- Call generic magnitude on a rectangular number
;; [3] (magnitude raw)    -- Call rectangular specific magnitude
;;                        -- on raw rectangular implementation

;; CODE --------------------------------------------------------------

;; TABLE operators

(define *table* ())

(define (clear-table)
  (set! *table* ()) 'ok)
(clear-table)

(define (put operator type value)
  (let ((key (list operator type)))
    (set! *table* (del-assoc key *table*))
    (set! *table* (cons (cons key value) *table*))))

(define (get operator type)
  (let* ((key (list operator type))
         (pair (assoc key *table*))) 
    (if (pair? pair) (cdr pair) false)))


;; Tagged data and generic application

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))

(define (attach-tag type-tag contents)
  (if (equal? type-tag 'scheme-number)
      contents
      (cons type-tag contents)))
(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
        ((pair? datum)
         (car datum))
        (else  (error "Bad tagged datum -- TYPE-TAG" datum))))
(define (contents datum)
  (cond ((number? datum) datum))
  ((pair? datum) (cdr datum))
  (else (error "Bad tagged datum -- CONTENTS" datum)))

;; Generic functions

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(define (numer r) (apply-generic 'numer r))
(define (denom r) (apply-generic 'denom r))

;; Added for this exercise
;; (define (real-part c) (apply-generic 'real-part c))
;; (define (imag-part c) (apply-generic 'imag-part c))
;; (define (magnitude c) (apply-generic 'magnitude c))
;; (define (angle c)     (apply-generic 'angle     c))

;; Scheme number package

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))    
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(install-scheme-number-package)

;; Rational Number Package

(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add x y)
    (make (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub x y)
    (make (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul x y)
    (make (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div x y)
    (make (* (numer x) (denom y))
              (* (denom x) (numer y))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'numer '(rational)
       (lambda (x) (make-scheme-number (numer x))))
  (put 'denom '(rational)
       (lambda (x) (make-scheme-number (denom x))))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div x y))))

  (put 'make 'rational
       (lambda (n d) (tag (make n d))))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))

(install-rational-package)

;; Rectangular Complex number package

(define (install-rectangular-package)
  ;; internal procedures 
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a) 
    (cons (* r (cos a)) (* r (sin a))))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle     '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular 
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular 
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))

(install-rectangular-package)

;; Polar Complex Package

(define (install-polar-package)
  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y) 
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar 
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))

(install-polar-package)

;; Complex number package

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  (define (add z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  ;; Added for this exercise
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)
  'done)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

(install-complex-package)
