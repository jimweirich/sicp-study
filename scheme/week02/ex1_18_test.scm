(test-case "Ex 1.18 Fast Multiplying via addition and iterative process"
           (assert-equal 0 (iterative-mult 0 3))
           (assert-equal 3 (iterative-mult 1 3))
           (assert-equal 6 (iterative-mult 2 3))
           (assert-equal 12 (iterative-mult 4 3))
           (assert-equal 9 (iterative-mult 3 3))
           (assert-equal 35 (iterative-mult 7 5)))
