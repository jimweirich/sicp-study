;; SICP Test 2.56

(test-case "Ex 2.56 -- Simple differentiation"
           (assert-equal 1 (deriv '(+ x 3) 'x))
           (assert-equal 'y (deriv '(* x y) 'x))
           (assert-equal '(+ (* x y) (* y (+ x 3)))
                         (deriv '(* (* x y) (+ x 3)) 'x)))

(test-case "Ex 2.56 -- Make Exponentiation"
           (assert-equal '(** foo bar) (make-exponentiation 'foo 'bar))
           (assert-equal '1 (make-exponentiation 'foo 0))
           (assert-equal 'foo (make-exponentiation 'foo 1))
           (assert-equal 8 (make-exponentiation 2 3))
           (assert-equal 1 (make-exponentiation 1 'n)))

(test-case "Ex 2.56 -- Deconstructing exponenentiation"
           (let ((x (make-exponentiation 'base 'exp)))
             (assert-equal 'base (base x))
             (assert-equal 'exp (exponent x))))

(test-case "Ex 2.56 -- Exponentiation detection"
           (assert-equal #t (exponentiation? (make-exponentiation 'base 'exp)))
           (assert-equal #f (exponentiation? (make-sum 'a 'b)))
           (assert-equal #f (exponentiation? (make-product 'a 'b))))

(test-case "Ex 2.56 -- Simple Exponentiation differentiation"
           (assert-equal 0 (deriv '(** y 1) 'x))
           (assert-equal 1 (deriv '(** x 1) 'x))
           (assert-equal '(* 2 x) (deriv '(** x 2) 'x))
           (assert-equal '(* 3 (** x 2)) (deriv '(** x 3) 'x)))

(test-case "Ex 2.56 -- Advanced Exponentiation differentiation"
           (assert-equal 'y (deriv '(** (* x y) 1) 'x))
           (assert-equal '(* n (** x (+ n -1))) (deriv '(** x n) 'x)))

