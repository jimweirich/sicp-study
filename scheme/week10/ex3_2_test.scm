;; SICP Tests 3.2 -- 

(define (f x) x)

(test-case "Ex 3.2 -- make-monitored passes thru"
           (let ((mf (make-monitored f)))
             (assert-equal 1 (mf 1))))

(test-case "Ex 3.2 -- make-monitored counts calls"
           (let ((mf (make-monitored f)))
             (assert-equal 0 (mf 'how-many-calls?))
             (mf 2)
             (assert-equal 1 (mf 'how-many-calls?))
             (mf 3)
             (assert-equal 2 (mf 'how-many-calls?))))

(test-case "Ex 3.2 -- make-monitored resets count"
           (let ((mf (make-monitored f)))
             (mf 2)
             (mf 3)
             (mf 'reset-count)
             (assert-equal 0 (mf 'how-many-calls?))))
