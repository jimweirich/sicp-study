;; SICP 1.40 tests

(test-case "Ex 1.40 Cubic Roots"
           (let ((f (lambda (x) ((cubic 2 3 4) x)))
                 (val (newtons-method f 1.0)))
             (assert-in-delta 0 (f val) 0.0001)))
