;; SICP 1.11 tests

(test-case "Ex 1.11 Recursive Process"
           (assert-equal 1 (f1 1))
           (assert-equal 2 (f1 2))
           (assert-equal 4 (f1 3))
           (assert-equal 11 (f1 4))
           (assert-equal 25 (f1 5))
           (assert-equal 59 (f1 6)))

(test-case "Ex 1.11 Iterative Process"
           (assert-equal 1 (f2 1))
           (assert-equal 2 (f2 2))
           (assert-equal 4 (f2 3))
           (assert-equal 11 (f2 4))
           (assert-equal 25 (f2 5))
           (assert-equal 59 (f2 6)))
