;; SICP 2.6 tests

(test-case "Ex 2.6 numbers"
           (let ((inc (lambda (n) (+ 1 n))))
             (assert-equal 0 ((zero inc) 0))
             (assert-equal 1 ((one inc) 0))
             (assert-equal 2 ((two inc) 0))))

(test-case "Ex 2.6 Addition"
           (let ((inc (lambda (n) (+ 1 n)))
                 (three (add one two)))
             (assert-equal 3 ((three inc) 0))))
