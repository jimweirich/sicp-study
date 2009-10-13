;; SICP 1.14 Extra Credit testing

(test-case "Ex 1.14 Extra: Make Change recursive version"
           (assert-equal 1 (make-change 1))
           (assert-equal 292 (make-change 100)))

(test-case "Ex 1.14 Extra: Make Change iterative version"
           (assert-equal 1 (imake-change 1))
           (assert-equal 292 (imake-change 100)))


