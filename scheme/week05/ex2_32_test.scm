;; SICP Tests 2.32

(test-case "Ex 2.32"
           (assert-equal '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
                         (subsets '(1 2 3))))
