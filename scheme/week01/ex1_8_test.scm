;; SICP 1.8 tests

(test-case "cube root"
           (assert-in-delta 3 (cbrt 27) 0.0001))
