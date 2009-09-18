(load (get-environment-variable "TESTING_SCM"))

(test-case "cube root"
           (assert-in-delta 3 (cbrt 27) 0.0001))

(tests)
