;; SICP 1.3 tests

(test-case "square tests"
           (assert-equal 1 (square 1))
           (assert-equal 4 (square 2))
           (assert-equal 9 (square 3))
           (assert-equal 256 (square 16)))

(test-case "sum-of-squares test"
           (assert-equal 25 (sum-of-squares 3 4)))

(test-case "sum-of-two-largest-squares test" 
           (assert-equal 41 (sum-of-two-largest-squares 3 4 5))
           (assert-equal 41 (sum-of-two-largest-squares 4 3 5))
           (assert-equal 41 (sum-of-two-largest-squares 4 5 3)))
