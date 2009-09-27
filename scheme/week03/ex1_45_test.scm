;; SICP 1.45 tests

(test-case "Ex 1.45 Average"
           (assert-equal 3.0 (average 2 4)))

(test-case "Ex 1.45 Power Function"
           (assert-equal 1 (power 2 0))
           (assert-equal 2 (power 2 1))
           (assert-equal 4 (power 2 2))
           (assert-equal 8 (power 2 3))
           (assert-equal 1000 (power 10 3)) )

(test-case "Ex 1.45 Try Root converging"
           (assert-not-equal 'failed (try-root 10 2 1))
           (assert-not-equal 'failed (try-root 10 3 1))
           (assert-equal 'failed (try-root 10 4 1))
           (assert-not-equal 'failed (try-root 10 4 2)))

(test-case "Ex 1.45 Try Root values"
           (assert-in-delta 2 (try-root (power 2 10) 10 3) 0.0001))

(test-case "Ex 1.45 Determine Damping"
           (assert-equal 1 (determine-damping 2))
           (assert-equal 1 (determine-damping 3))
           (assert-equal 2 (determine-damping 4)))

(test-case "Ex 1.45 Damping Results"
           (assert-equal '(1 1 1 2 2 2 2 3 3 3)
                         (map determine-damping (integers 10))))

(test-case "Ex 1.45 Try Root"
           (assert-in-delta 2 (try-root 8 3 1) 0.001)
           (assert-equal 'failed (try-root 16 4 1))
           (assert-in-delta 2 (try-root 16 4 2) 0.001))

(test-case "Ex 1.45 Nth Root"
           (assert-in-delta 2 (nth-root (power 2 2) 2) 0.001)
           (assert-in-delta 2 (nth-root (power 2 3) 3) 0.001)
           (assert-in-delta 2 (nth-root (power 2 4) 4) 0.001)
           (assert-in-delta 2 (nth-root (power 2 10) 10) 0.001))

