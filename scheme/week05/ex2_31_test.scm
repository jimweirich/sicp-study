;; SICP Tests 2.31

(test-case "Ex 2.31 - without map"
           (assert-equal '(1 (4 (9 16) 25) (36 49)) 
                         (square-tree-3 '(1 (2 (3 4) 5) (6 7)))))

