;; SICP Test 2.62

(test-case "Ex 2.62 -- Union of ordered sets"
           (assert-equal '() (union-set () ()))
           (assert-equal '(1 2) (union-set '(1) '(2)))
           (assert-equal '(1 2) (union-set '(1) '(1 2)))
           (assert-equal '(1 2) (union-set '(1 2) '(1 2))))
