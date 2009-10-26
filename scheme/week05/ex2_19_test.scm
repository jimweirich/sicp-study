;; SICP Tests 2.19

(test-case "Ex 2.19"
           (assert-equal 292 (cc 100 us-coins))
           (assert-equal 571 (cc 25 uk-coins)))
