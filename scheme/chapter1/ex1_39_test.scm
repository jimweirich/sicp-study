;; Ex 1.39 tests

(test-case "Ex 1.39 Tan as a continued fraction"
           (assert-in-delta (tan 0.0) (tan-cf 0.0 10) 0.00001)
           (assert-in-delta (tan 0.5) (tan-cf 0.5 10) 0.00001)
           (assert-in-delta (tan 1) (tan-cf 1 10) 0.00001))
