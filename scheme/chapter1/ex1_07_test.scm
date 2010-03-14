;; SICP 1.7

(test-case "Ex 1.7 New Good Enough"
            (assert-in-delta 2 (sqrt 4) 0.000001)
            (assert-in-delta 4 (sqrt 16) 0.000001)
            (assert-in-delta 20000 (sqrt 400000000) (/ 20000 1000000)) )
