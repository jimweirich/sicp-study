(test-case "Fast Exp with an interative process"
            (assert-equal 1 (iterative-fast-exp 3 0))
            (assert-equal 9 (iterative-fast-exp 3 2))
            (assert-equal 3 (iterative-fast-exp 3 1)))
