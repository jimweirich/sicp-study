;; SICP 1.29

;; Exercise 1.29.  Simpson's Rule is a more accurate method of
;; numerical integration than the method illustrated above. Using
;; Simpson's Rule, the integral of a function f between a and b is
;; approximated as

;;  (h / 3) * (y0 + 4*y1 + 2*y2 + 4*y3 + 2*y4 + ... + 2*yn_2 + 4*yn_1 + y_n)

;; where h = (b - a)/n, for some even integer n, and yk = f(a +
;; kh). (Increasing n increases the accuracy of the approximation.)
;; Define a procedure that takes as arguments f, a, b, and n and
;; returns the value of the integral, computed using Simpson's
;; Rule. Use your procedure to integrate cube between 0 and 1 (with n
;; = 100 and n = 1000), and compare the results to those of the
;; integral procedure shown above.

;; ANSWER ------------------------------------------------------------

(define (cube n) (* n n n))

(define (simpson f a b n)
  (if (even? n)
      (simpson-even f a b n)
      (simpson-even f a b (+ 1 n))))

(define (simpson-even f a b n)
  (let ((h (/ (- b a) n)))
    (define (y k)
      (f (+ a (* k h))))
    (define (iter i m sum)
      (if (= i n)
          (+ sum (y n))
          (iter (+ i 1)
                (- 6 m)
                (+ sum (* m (y i))))))
    (/ (* h (iter 1 4 (y 0))) 3.0) ))

;; integral from the book ...

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(integral cube 0 1 0.001) ;; => 0.249999875000001
(simpson cube 0 1 2) ;; => 0.25 exactly

;; The simpson algorithm nails the answer in as little n=2.  The
;; general integral algorithm is still only approximate with as many
;; as 1000 steps.
