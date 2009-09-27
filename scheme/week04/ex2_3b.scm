;; SICP 2.3

;; Exercise 2.3.  Implement a representation for rectangles in a
;; plane. (Hint: You may want to make use of exercise 2.2.) In terms
;; of your constructors and selectors, create procedures that compute
;; the perimeter and the area of a given rectangle. Now implement a
;; different representation for rectangles. Can you design your system
;; with suitable abstraction barriers, so that the same perimeter and
;; area procedures will work using either representation?

;; ANSWER ------------------------------------------------------------

(define (make-point x y)
  (cons x y))
(define (x-point point)
  (car point))
(define (y-point point)
  (cdr point))
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;; Version B: Storing top bottom left right

(define (make-rect origin width height)
  (list (+ (y-point origin) height)
        (y-point origin)
        (x-point origin)
        (+ (x-point origin) width)))
(define (top-rect rect) (car rect))
(define (bottom-rect rect) (cadr rect))
(define (left-rect rect) (caddr rect))
(define (right-rect rect) (cadddr rect))

;; Implementation independent functions

(define (origin-rect rect)
  (make-point (left-rect rect) (bottom-rect rect)))
(define (width-rect rect)
  (- (right-rect rect) (left-rect rect)))
(define (height-rect rect)
  (- (top-rect rect) (bottom-rect rect)))

(define (perimeter-rect rect)
  (+ (* 2 (width-rect rect))
     (* 2 (height-rect rect))))

(define (area-rect rect)
  (* (width-rect rect)
     (height-rect rect)))
