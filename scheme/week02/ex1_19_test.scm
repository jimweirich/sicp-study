;; SICP 1.19 tests

(test-case "Ex 1.19 Fast Fibinacci"
            (assert-equal
             '(1 1 2 3 5 8 13 21 34 55)
             (map fib '(1 2 3 4 5 6 7 8 9 10))))
