;; SICP 1.42 test

(test-case "Ex 1.42 Composing Functions"
           (assert-equal 121 ((compose square inc) 10)))
