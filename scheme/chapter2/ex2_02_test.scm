;; SICP 2.2 tests

(test-case "Ex 2.2 Point operations"
           (let ((point (make-point 11 13)))
             (assert-equal 11 (x-point point))
             (assert-equal 13 (y-point point))))

(test-case "Ex 2.2 Segment operations"
           (let* ((p1 (make-point 3 5))
                  (p2 (make-point 7 11))
                  (seg (make-segment p1 p2)))
             (assert-equal p1 (start-segment seg))
             (assert-equal p2 (end-segment seg))))

(test-case "Ex 2.2 Midpoint"
           (let* ((p1 (make-point 3 5))
                  (p2 (make-point 7 11))
                  (seg (make-segment p1 p2)))
             (assert-equal (make-point 5.0 8.0) (midpoint seg))))
