;; Given:

;;     (define (p) (p))

;;     (define (test x y)
;;       (if (= x 0)
;;           0
;;           y))
;;     (test 0 (p))

;; Since applicative order evaluates the arguments before calling the
;; function, the (p) expression results in an infinite recursion.  And
;; since scheme has TCO, the interpreter will enter an infinite loop.
