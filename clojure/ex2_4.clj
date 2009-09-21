(defn r [] (require :reload 'ex2_4))

(use 'clojure.contrib.test-is)

(defn square
  "Square a number"
  [n]
  (* n n) )

(defn exp
  "Raise b to the nth power."
  [b n]
  (letfn
   [(halve [n]   (/ n 2))]
   (loop [number b power n result 1]
     (cond
      (zero? power) result
      (odd? power) (recur number (dec power) (* result number))
      :else    (recur (square number) (halve power) result) ))))

(defn power-of
  "Power of b wrt n"
  [n b]
  (loop [b b i 0]
    (if (not (zero? (mod b n))) i
        (recur (/ b n) (inc i)) )))

(defn kons
  "Construct a pair of integers."
  [a b]
  (* (exp 2 a) (exp 3 b)) )

(defn kar
  "The first of a pair of integers."
  [m]
  (power-of 2 m) )

(defn kdr
  "The rest of a pair of integers."
  [m]
  (power-of 3 m) )

(deftest power-of-test
  (is (= 2 (power-of 3 9)))
  (is (= 4 (power-of 3 81)))
  (is (= 8 (power-of 2 256)))
  (is (= 0 (power-of 2 1)))
  (is (= 2 (power-of 3 18))) )

(deftest kons-test
  (let [cell (kons 5 7)]
    (is (= 5 (kar cell)))
    (is (= 7 (kdr cell))) ))
