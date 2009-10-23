;; Interval Math Functionality

;; Constructors

(define (make-interval lower-bound upper-bound) (cons lower-bound upper-bound))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (make-center-percent c p)
  (define (percent-of n p) (* n (/ p 100.0)))
  (let ((w (percent-of c p)))
    (make-center-width c w)))

;; Accessors

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percent i)
  (* 100.0 (/ (width i) (center i))))

;; Operations

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval a b)
  (make-interval
   (- (lower-bound a) (upper-bound b))
   (- (upper-bound a) (lower-bound b))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (span-zero-interval? interval)
  (and (<= (lower-bound interval) 0) (>= (upper-bound interval) 0)))

(define (div-interval x y)
  (if (span-zero-interval? y)
      (error "cannot divide by zero spanning interval" y)
      (mul-interval x 
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

;; Display

(define (inspect i)
  (list
   (list 'center (center i))
   (list 'width (width i))
   (list 'upper (upper-bound i))
   (list 'lower (lower-bound i))
   (list 'percent (percent i))))
