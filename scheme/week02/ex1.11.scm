(define (f1 n)
  (if (< n 3)
      n
      (+ (f1 (- n 1))
         (* 2 (f1 (- n 2)))
         (* 3 (f1 (- n 3))) )))

(define (f2 n)
  (define (f2-aux i a1 a2 a3)
    (if (= n i)
        a1
        (f2-aux (+ 1 i) (+ a1 (* 2 a2) (* 3 a3)) a1 a2)))
  (if (< n 3)
      n
      (f2-aux 3 4 2 1)))


;;; ------------------------------------------------------------------

(let ((testing-file
       (get-environment-variable "TESTING_SCM")))
  (if testing-file
      (begin
        (load testing-file)

        (test-case "Recursive Process"
                    (assert-equal 1 (f1 1))
                    (assert-equal 2 (f1 2))
                    (assert-equal 4 (f1 3))
                    (assert-equal 11 (f1 4))
                    (assert-equal 25 (f1 5))
                    (assert-equal 59 (f1 6)))
        
        (test-case "Iterative Process"
                    (assert-equal 1 (f2 1))
                    (assert-equal 2 (f2 2))
                    (assert-equal 4 (f2 3))
                    (assert-equal 11 (f2 4))
                    (assert-equal 25 (f2 5))
                    (assert-equal 59 (f2 6)))
        
        (tests))))
