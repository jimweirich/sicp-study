;; SICP 1.31

;; Exercise 1.31.

;; a.  The sum procedure is only the simplest of a vast number of
;; similar abstractions that can be captured as higher-order
;; procedures.51 Write an analogous procedure called product that
;; returns the product of the values of a function at points over a
;; given range. Show how to define factorial in terms of product. Also
;; use product to compute approximations to PI using the formula

;;         2 * 4 * 4 * 6 * 6 * 8 ...
;; PI/4 =  ------------------------
;;         3 * 3 * 5 * 5 * 7 * 7 ...

;; b.  If your product procedure generates a recursive process, write
;; one that generates an iterative process. If it generates an
;; iterative process, write one that generates a recursive process.

;; ANSWER ------------------------------------------------------------

;; First, an iterative version

(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

;; Here are factorial and the pi-series functions written using
;; product.

(define (identity x) x)
(define (inc n) (+ 1 n))

(define (factorial n)
  (product identity 2 inc n))

(define (pi-series n)
  (define (term n)
    (* (/ (- n 1.0) n) (/ (+ n 1.0) n)))
  (define (by-two n) (+ n 2))
  (* 4.0 (product term 3 by-two n)))


;; Now a recursive version.

(define (product-r term a next b)
  (cond ((> a b) 1)
        (else (* (term a) (product term (next a) next b)))))

;; And factorial and pi-series functions using the recursive version

(define (factorial-r n)
  (product-r identity 2 inc n))

(define (pi-series-r n)
  (define (term n)
    (* (/ (- n 1.0) n) (/ (+ n 1.0) n)))
  (define (by-two n) (+ n 2))
  (* 4.0 (product-r term 3 by-two n)))
