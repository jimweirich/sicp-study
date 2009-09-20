;; SICP 1.19

;; Exercise 1.19.  There is a clever algorithm for computing the
;; Fibonacci numbers in a logarithmic number of steps. Recall the
;; transformation of the state variables a and b in the fib-iter
;; process of section 1.2.2: a <- a + b and b <- a. Call this
;; transformation T, and observe that applying T over and over again n
;; times, starting with 1 and 0, produces the pair Fib(n + 1) and
;; Fib(n). In other words, the Fibonacci numbers are produced by
;; applying Tn, the nth power of the transformation T^n, starting with
;; the pair (1,0).  Now consider T to be the special case of p = 0 and
;; q = 1 in a family of transformations Tpq, where Tpq transforms the
;; pair (a,b) according to a <- bq + aq + ap and b <- bp + aq. Show
;; that if we apply such a transformation Tpq twice, the effect is the
;; same as using a single transformation Tp'q' of the same form, and
;; compute p' and q' in terms of p and q. This gives us an explicit
;; way to square these transformations, and thus we can compute Tn
;; using successive squaring, as in the fast-expt procedure. Put this
;; all together to complete the following procedure, which runs in a
;; logarithmic number of steps:

;; ANSWER ------------------------------------------------------------

;; Ok, this one involves some algebra.  And ASCII math notation is a
;; pain, so bear with me.
;;
;; Given:
;;
;;    T(p,q) = (b*q + a*q + a*p, b*p + a*q)
;;
;; So we need to calculate T(T(p, q)).  First, for a
;;
;;      b          *q + a                *q + a                *p
;;      (b*p + a*q)*q + (b*q + a*q + a*p)*q + (b*q + a*q + a*p)*p      [substitute]
;;      b*p*q + a*q^2 + b*q^2 + a*q^2 + a*p*q + b*q*p + a*q*p + a*p^2  [distribute]
;;      b*p*q + b*q^2 + b*q*p + a*q^2 + a*q^2 + a*p*q + a*q*p + a*p^2  [commute]
;;      b*q^2 + 2*b*p*q + a*q^2 + 2*a*p*q + a*q^2 + a*p^2              [combine]
;;      b*(q^2 + 2*p*q) + a*(q^2 + 2*p*q) + a*(q^2 + p^2)              [un-distribute]
;;
;; This implies
;;
;;      newp(p,q) = q^2 + p^2
;;      newq(p,q) = q^2 + 2*q*p
;;
;; We can check that by doing the same thing with the b formula.
;;
;;      b          *p + a                *q
;;      (b*p + a*q)*p + (b*q + a*q + a*p)*q        [substitute]
;;      b*p^2 + a*q*p + b*q^2 + a*q^2 + a*p*q      [distribute]
;;      b*q^2 + b*p^2 + a*q^2 + a*p*q + a*p*q      [commute]
;;      b*(q^2 + p^2) + a*(q^2 + 2*p*q)            [combine & un-distribute]
;;
;; And we get the same result (whew!).
;;
;;      newp(p,q) = q^2 + p^2
;;      newq(p,q) = q^2 + 2*q*p
;;
;; Now just add the newp and newq functions to the partial solution
;; provided in the text book:

(define (fib n)
  (define (new-p p q) (+ (square q) (square p)))
  (define (new-q p q) (+ (square q) (* 2 p q)))
  (define (iter a b p q count)
    (cond ((= count 0) b)
          ((even? count)
           (iter a
                 b
                 (new-p p q)         ; compute p'
                 (new-q p q)         ; compute q'
                 (/ count 2)))
          (else (iter (+ (* b q) (* a q) (* a p))
                      (+ (* b p) (* a q))
                      p
                      q
                      (- count 1)))))
  (iter 1 0 0 1 n))
