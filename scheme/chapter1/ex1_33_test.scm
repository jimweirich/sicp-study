;; SICP 1.33 Tests

(test-case "Ex 1.33 Sum of Squares using Filtered Accumulate"
            (assert-equal 87 (sum-square-primes 1 10)))

(test-case "Ex 1.33 Product of Relatively-prime Integers"
            (assert-equal 189 (product-relatively-prime 10)))

