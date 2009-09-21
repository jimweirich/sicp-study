(use 'clojure.contrib.test-is)

(defn r [] (require :reload 'ex2_5))

; Church Numerals in Closure
;
; Church numerals use anonymous functions to represent numbers.
;
; ((zero f) x) -- returns x
; ((one f)  x) -- return (f x)
; ((two f)  x) -- return (f (f x))
; ...

(def zero (fn [f] (fn [x] x)))
(def one (fn [f] (fn [x] (f (((fn [f] (fn [x] x)) f) x)))) )
(def two (fn [f] (fn [x] (f (((fn [f] (fn [x] (f (((fn [f] (fn [x] x)) f) x)))) f) x)))) )

; incr increments church numeral n by return a function that applies f
; one more time than n.
(defn incr [n] (fn [f] (fn [x] (f ((n f) x)))))

; Here's an easy way to test if a church numeral is zero.
(defn zero-cn? [n] ((n (fn [x] false)) true) )

; Add two church numerals to produce a new church numeral.
(defn +cn [a b]
  (fn [f] (fn [x] ((a f) ((b f) x)))))



(defn res [n f base] ((n f) base))
(defn =cn [a b] (= (res a inc 0) (res b inc 0)) )

(use 'clojure.contrib.test-is)

(deftest constants-test
  (is (= 0 (res zero inc 0)))
  (is (= 1 (res one inc 0)))
  (is (= 2 (res two inc 0))) )

(deftest incr-test
  (is (= 1 (((incr zero) inc) 0))) 
  (is (= 2 (((incr one) inc) 0))) )

(deftest zero?-test
  (is (= true (zero-cn? zero)))
  (is (= false (zero-cn? one))) )

(deftest addition-test
  (is (= 0 (res (+cn zero zero) inc 0)))
  (is (= 1 (res (+cn one zero) inc 0))) )
