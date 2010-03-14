;; SICP 2.61 test

(test-case "Ex 2.61 -- Adjoin ordered set"
           (assert-equal '(1) (adjoin-set 1 ()))
           (assert-equal '(1 2 3) (adjoin-set 1 '(2 3)))
           (assert-equal '(1 2 3) (adjoin-set 2 '(1 3)))
           (assert-equal '(1 2 3) (adjoin-set 3 '(1 2)))
           (assert-equal '(1 2 3) (adjoin-set 1 '(1 2 3)))
           (assert-equal '(1 2 3) (adjoin-set 2 '(1 2 3)))
           (assert-equal '(1 2 3) (adjoin-set 3 '(1 2 3))))
