;; SICP 2.2

;; Exercise 2.2.  Consider the problem of representing line segments
;; in a plane. Each segment is represented as a pair of points: a
;; starting point and an ending point. Define a constructor
;; make-segment and selectors start-segment and end-segment that
;; define the representation of segments in terms of
;; points. Furthermore, a point can be represented as a pair of
;; numbers: the x coordinate and the y coordinate. Accordingly,
;; specify a constructor make-point and selectors x-point and y-point
;; that define this representation. Finally, using your selectors and
;; constructors, define a procedure midpoint-segment that takes a line
;; segment as argument and returns its midpoint (the point whose
;; coordinates are the average of the coordinates of the
;; endpoints). To try your procedures, you'll need a way to print
;; points:

;; (define (print-point p)
;;   (newline)
;;   (display "(")
;;   (display (x-point p))
;;   (display ",")
;;   (display (y-point p))
;;   (display ")"))

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

(define (point-add a b)
  (make-point
   (+ (x-point a) (x-point b))
   (+ (y-point a) (y-point b))))
(define (point-scale x point)
  (make-point
   (* x (x-point point))
   (* x (y-point point))))

(define (make-segment start end)
  (cons start end))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))

(define (midpoint segment)
  (let ((start (start-segment segment))
        (end (end-segment segment)))
    (point-scale 0.5 (point-add start end))))


