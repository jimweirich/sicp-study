;; SICP 2.7 tests

(test-case "Ex 2.7 Interval Math"
           (assert-equal 11 (lower-bound (make-interval 11 22)))
           (assert-equal 22 (upper-bound (make-interval 11 22))))
