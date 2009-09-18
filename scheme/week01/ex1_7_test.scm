(let ((testing-file
       (get-environment-variable "TESTING_SCM")))
  (if testing-file
        (load testing-file)))

(test-case "new good enough"
            (assert-in-delta 2 (sqrt 4) 0.000001)
            (assert-in-delta 4 (sqrt 16) 0.000001)
            (assert-in-delta 20000 (sqrt 400000000) (/ 20000 1000000)) )

(tests)
