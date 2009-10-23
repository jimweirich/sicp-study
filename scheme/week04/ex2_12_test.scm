;; SICP 2.1 tests

(test-case "Ex 2.12 Center Percent Intervals"
           (let* ((i (make-center-percent 200 5)))
             (assert-in-delta 200 (center i) 0.0001)
             (assert-in-delta 210 (upper-bound i) 0.0001)
             (assert-in-delta 190 (lower-bound i) 0.0001)
             (assert-in-delta 5 (percent i) 0.0001)
             (assert-in-delta 10 (width i) 0.0001)))

