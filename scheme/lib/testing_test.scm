(test-case "Testing Expected Messages"
           (assert-equal "Expected <#f> to be true" (expected-true-message false))
           (assert-equal "Expected <#t> to be false" (expected-false-message true))
           (assert-equal "Expected <1> but got <2>" (equal-message 1 2))
           (assert-equal "Expected <1> to not equal <1>" (not-equal-message 1 1))
           (assert-equal "Expected the delta of <1.> and <2.> to be less than <.5> but was <1.>"
                         (equal-in-delta-message 1.0 2.0 0.5))
           (assert-equal "Expected the delta of <1.> and <2.> to be greater than <2.> but was <1.>"
                         (not-equal-in-delta-message 1.0 2.0 2.0)))
