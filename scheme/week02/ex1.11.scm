;; Exercise 1.11.  A function f is defined by the rule that f(n) = n
;; if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3. Write a
;; procedure that computes f by means of a recursive process. Write a
;; procedure that computes f by means of an iterative process.

;; First, the recursive version.

(define (f1 n)
  (if (< n 3)
      n
      (+ (f1 (- n 1))
         (* 2 (f1 (- n 2)))
         (* 3 (f1 (- n 3))) )))

;; Now the iterative version.

(define (f2 n)
  (define (iter i a1 a2 a3)
    (if (= n i)
        a1
        (iter (+ 1 i) (+ a1 (* 2 a2) (* 3 a3)) a1 a2)))
  (if (< n 3)
      n
      (iter 3 4 2 1)))
