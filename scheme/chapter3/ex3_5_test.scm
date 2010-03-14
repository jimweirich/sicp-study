;; SICP Tests 3.5 -- Monte Carlo Integration

(test-case "Ex 3.5 -- Point ADT"
           (let ((pt (make-point 5 10)))
             (assert-equal 5 (point-x pt))
             (assert-equal 10 (point-y pt))))

(test-case "Ex 3.5 -- Integration"
           (define (f x y) (< x 5))
           (let ((area
                  (estimate-integral f 0.0 10.0 0.0 10.0 1000)))
             (assert-in-delta 50.0 area 10.0)))
