
(load (get-environment-variable "TESTING_SCM"))

(test-case "Making Rows"
           (assert-equal '(1) (make-row ()))
           (assert-equal '(1 1) (make-row '(1)))
           (assert-equal '(1 4 6 4 1) (make-row '(1 3 3 1))))

(test-case "Pascal's Triangle"
           (assert-equal '((1))
                         (pascal 1))

           (assert-equal '((1)
                           (1 1))
                         (pascal 2))

           (assert-equal '((1)
                           (1 1)
                           (1 2 1)
                           (1 3 3 1)
                           (1 4 6 4 1))
                         (pascal 5)))

(tests)
