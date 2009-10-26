;; SICP Tests 2.27

(test-case "Ex 2.27 Deep Reverse"
           (let  ((x (list (list 1 2) (list 3 4))))
             (assert-equal () (deep-reverse ()))
             (assert-equal '(2 1) (deep-reverse ()))
             (assert-equal '((4 3) (2 1)) (deep-reverse x))))

