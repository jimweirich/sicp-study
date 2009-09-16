(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; (a-plus-abs-b 2 3)
;; ((if (> 3 0) + -) 2 3)
;; ((if true + -) 2 3)
;; (+ 2 3)
;; 5

;;; ------------------------------------------------------------------

(let ((testing-file
       (get-environment-variable "TESTING_SCM")))
  (if testing-file
      (begin
        (load testing-file)

        (test-case "test result"
                    (assert-equal 5 (a-plus-abs-b 2 3)))
        
        (tests))))

(let ((testing-file
       (get-environment-variable "TESTING_SCM")))
  (if testing-file
      (begin
        (load testing-file)

        (test-case "something"
                   (assert-equal 0 0)
                   (assert-not-equal 1 2))
        
        (tests))))
