;; SICP Tests 2.28

(test-case "Ex 2.28 Fringe"
           (assert-equal () (fringe ()))
           (assert-equal '(a b c) (fringe '(a b c)))
           (assert-equal '(a b c) (fringe '(a (b) c)))
           (assert-equal '(a b c d) (fringe '((a b) (c d)))))
