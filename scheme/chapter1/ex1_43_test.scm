;; SICP 1.43 test

(test-case "Ex 1.43 Repeated Compose"
           (assert-equal 625 ((repeated square 2) 5))
           (assert-equal 0 ((repeated inc 0) 0))
           (assert-equal 10 ((repeated inc 10) 0)))
