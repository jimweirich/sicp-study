;; SICP 1.8 tests

(test-case "Ex 1.8 Cube Root"
           (assert-in-delta 3 (cbrt 27) 0.0001))
