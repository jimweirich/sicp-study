;; SICP Tests 2.30

(test-case "Ex 2.30 - without map"
           (assert-equal '(1 (4 (9 16) 25) (36 49)) 
                         (square-tree-1 '(1 (2 (3 4) 5) (6 7)))))

(test-case "Ex 2.30 - with map"
           (assert-equal '(1 (4 (9 16) 25) (36 49))
                         (square-tree-2 '(1 (2 (3 4) 5) (6 7)))))
