(defn r [] (require :reload 'ex2_3))

(defn kons [a b]
  (fn [m] (m a b)) )
(defn kar [m]
  (m (fn [a b] a)) )
(defn kdr [m]
  (m (fn [a b] b)) )

(use 'clojure.contrib.test-is)

(deftest kons-test
  (let [cell (kons 'a 'b)]
    (is (= 'a (kar cell)))
    (is (= 'b (kdr cell))) ))
