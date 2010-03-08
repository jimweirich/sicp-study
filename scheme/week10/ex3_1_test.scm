;; SICP Tests 3.1 -- 

(test-case "Ex 3.1 -- make-accumulator"
           (let ((a (make-accumulator 5)))
             (assert-equal 15 (a 10))
             (assert-equal 25 (a 10))))
