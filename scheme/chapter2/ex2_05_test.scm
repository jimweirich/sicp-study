;; SICP 2.5 tests

(test-case "Ex 2.4 Numeric Pairs"
           (assert-equal 5 (icar (icons 5 6)))
           (assert-equal 6 (icdr (icons 5 6))))
