;; SICP 2.10

;; Exercise 2.10.  Ben Bitdiddle, an expert systems programmer, looks
;; over Alyssa's shoulder and comments that it is not clear what it
;; means to divide by an interval that spans zero. Modify Alyssa's
;; code to check for this condition and to signal an error if it
;; occurs.

;; ANSWER ------------------------------------------------------------

(define (make-interval lower-bound upper-bound) (cons lower-bound upper-bound))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

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
