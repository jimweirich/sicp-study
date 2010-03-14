;; SICP 1.35 tests

(test-case "Ex 1.35 Golden Ratio via Fixed Point"
           (assert-in-delta
            1.6180 
            (fixed-point (lambda (x) (+ 1 (/ 1.0 x))) 1.0)
            0.0001))
