
(test-case "Ex 1.44 Smoothing Functions"
           (let ((linear (lambda (x) (* 3 x))))
             (assert-in-delta 15 ((smooth linear) 5) 0.001)
             (assert-in-delta 100 ((smooth square) 10) 0.001)))


