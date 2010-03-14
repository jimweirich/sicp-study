(test-case "Ex 1.31 Factorial via Product"
            (assert-equal 1 (factorial 0))
            (assert-equal 1 (factorial 1))
            (assert-equal 2 (factorial 2))
            (assert-equal 120 (factorial 5)))

(test-case "Ex 1.31 PI via product series"
           (assert-in-delta 3.14 (pi-series 100) 0.1))

(test-case "Ex 1.31 Factorial via Recursive Product"
            (assert-equal 1 (factorial-r 0))
            (assert-equal 1 (factorial-r 1))
            (assert-equal 2 (factorial-r 2))
            (assert-equal 120 (factorial-r 5)))

(test-case "Ex 1.31 PI via recursive product series"
           (assert-in-delta 3.14 (pi-series-r 100) 0.1))
