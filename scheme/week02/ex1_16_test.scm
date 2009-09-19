(test-case "Fast Exp with an interative process"
            (assert-equal 1 (fexp 3 0))
            (assert-equal 9 (fexp 3 2))
            (assert-equal 3 (fexp 3 1)))
