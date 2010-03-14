;; SICP 1.38 tests

(test-case "Ex 1.38 Value of E"
            (assert-in-delta (exp 1) (e) 0.0001))

