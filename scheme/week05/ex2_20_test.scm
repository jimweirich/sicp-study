;; SICP Tests 2.20

(test-case "Ex 2.10 - Same Parity"
           (assert-equal (list 1 3 5 7) (same-parity 1 2 3 4 5 6 7))
           (assert-equal (list 2 4 6) (same-parity 2 3 4 5 6 7)))
