;; SICP 1.46 tests

(test-case "Ex 1.46 Sqrt with iterative-improve"
           (assert-in-delta 10 (new-sqrt 100) 0.001))

(test-case "Ex 1.46 fixed-point with iterative-improve"
           (assert-in-delta 10
                            (fixed-point (average-damp (lambda (y) (/ 100 y))) 1.0)
                            0.001))
