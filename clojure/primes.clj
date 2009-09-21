(defn reject-multiples
  "A function that rejects multiples of n."
  [n]
  (fn [x] (not (zero? (mod x n)))))

(defn primes
  "An infinite sequence of prime numbers"
  ([] (primes (iterate inc 2)))
  ([seq]
   (let [head (first seq)]
     (lazy-seq
      (cons head
            (primes (filter (reject-multiples head) (rest seq))) )))))

; Give me the first prime > 1000

(println (first (drop-while #(< % 1000) (primes))))
