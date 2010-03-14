;; SICP 1.20

;; Exercise 1.20.  The process that a procedure generates is of course
;; dependent on the rules used by the interpreter. As an example,
;; consider the iterative gcd procedure given above. Suppose we were
;; to interpret this procedure using normal-order evaluation, as
;; discussed in section 1.1.5. (The normal-order-evaluation rule for
;; if is described in exercise 1.5.) Using the substitution method
;; (for normal order), illustrate the process generated in evaluating
;; (gcd 206 40) and indicate the remainder operations that are
;; actually performed. How many remainder operations are actually
;; performed in the normal-order evaluation of (gcd 206 40)? In the
;; applicative-order evaluation?

;; ANSWER ------------------------------------------------------------

;; The gcd function in the book is:

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;; First we do a normal order evaluation.  We will add an X to the
;; line every time a call to remainder is made.  At the end, we merely
;; count the number of X's to determine the number of remainder calls.

;; In order the keep the following lines a bit more readable, lets
;; define r to mean remainder.

(define (r a b) (remainder a b))

(gcd 206 40)
(if (= 206 0) 40 (gcd 40 (r 206 40)))
(gcd 40 (r 206 40))
(if (= (r 206 40) 0) 40 (gcd (r 206 40) (r 40 (r 206 40))))
(if (= 6 0) 40 (gcd (r 206 40) (r 40 (r 206 40)))) ;X
(gcd (r 206 40) (r 40 (r 206 40))) ;X
(if (= (r 40 (r 206 40)) 0) (r 206 40) (gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))) ; X
(if (= 4 0) (r 206 40) (gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))) ;XXX
(gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))) ;XXX
(if (= (r (r 206 40) (r 40 (r 206 40))) 0) (r 40 (r 206 40)) (gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))))) ;XXX
(if (= 2 0) (r 40 (r 206 40)) (gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))))) ;XXX
(gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))) ;XXXXXXX
(if (= (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) 0) (r (r 206 40) (r 40 (r 206 40))) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ;XXXXXXX
(if (= 0 0) (r (r 206 40) (r 40 (r 206 40))) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ;XXXXXXXXXXXXXX
(r (r 206 40) (r 40 (r 206 40))) ;XXXXXXXXXXXXXX
(r (r 206 40) (r 40 6)) ;XXXXXXXXXXXXXXX
(r (r 206 40) 4) ;XXXXXXXXXXXXXXXX
2 ;XXXXXXXXXXXXXXXXXX

;; A total of 18 remainder calls were made using normal order evaluation.

;; Now here is applicative order evaluation, using the X notation.

(gcd 206 40)
(if (= 40 0) 206 (gcd 40 (r 206 40)))
(gcd 40 (r 206 40)) ;X
(gcd 40 6) ;X
(if (= 6 0) 40 (gcd 6 (r 40 6))) ;X
(gcd 6 (r 40 6)) ;X
(gcd 6 4) ;XX
(if (= 4 0) 6 (gcd 4 (r 6 4))) ;XX
(gcd 4 (r 6 4)) ;XX
(gcd 4 2) ;XXX
(if (= 2 0) 4 (gcd 2 (r 4 2))) ;XXX
(gcd 2 (r 4 2)) ;XXX
(gcd 2 0) ;XXXX
(if (= 0 0) 2 (gcd 0 (r 2 0)))  ;XXXX
2 ;XXXX

;; Using applicative order, we will call remainder a total of 4 times.
