
(test-case "Get returns nil if key not defined"
           (clear-table)
           (assert-equal () (get 'a '(x y))))

(test-case "Can retrieve data with get"
           (clear-table)
           (put 'a 'b 1)
           (put 'a 'c 2)
           (assert-equal 1 (get 'a 'b))
           (assert-equal 2 (get 'a 'c)))

(test-case "Can overwrite preexisting key values"
           (clear-table)
           (put 'a '(int float) 1)
           (put 'a '(int float) 10)
           (assert-equal 10 (get 'a '(int float))))

(test-case "Can clear an existing table"
           (clear-table)
           (put 'a '(x y) 10)
           (clear-table)
           (assert-equal () (get 'a '(x y))))
