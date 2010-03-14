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

;; Version A: Storing width and height

(define (make-rect origin width height)
  (list origin width height))
(define (top-rect rect) (+ (y-point (car rect)) (caddr rect)))
(define (bottom-rect rect) (y-point (car rect)))
(define (left-rect rect) (x-point (car rect)))
(define (right-rect rect) (+ (x-point (car rect)) (cadr rect)))

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
