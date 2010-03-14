;; SICP 2.10 tests

(test-case "Ex 2.10 Spanning Zero"
           (let ((positive (make-interval 0.9 1.1))
                 (negative (make-interval -1.1 -0.9))
                 (spanning (make-interval -0.1 0.1))
                 (spanning-positive (make-interval 0.0 0.1))
                 (spanning-negative (make-interval -0.1 0.0)))
             (assert-false (span-zero-interval? positive))
             (assert-false (span-zero-interval? negative))
             (assert-true (span-zero-interval? spanning))
             (assert-true (span-zero-interval? spanning-negative))
             (assert-true (span-zero-interval? spanning-positive))))

