;; SICP 1.8

(test-case "Ex 1.8 Interval Subtraction"
           (let ((a (make-interval 10 12))
                 (b (make-interval 4 6)))
             (assert-equal 4 (lower-bound (sub-interval a b)))
             (assert-equal 8 (upper-bound (sub-interval a b)))))
