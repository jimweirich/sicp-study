;; SICP 1.17 tests

(test-case "Ex 1.17 Fast Multiplying via addition"
           (assert-equal 0 (mult 0 3))
           (assert-equal 3 (mult 1 3))
           (assert-equal 6 (mult 2 3))
           (assert-equal 12 (mult 4 3))
           (assert-equal 9 (mult 3 3))
           (assert-equal 35 (mult 7 5)))
