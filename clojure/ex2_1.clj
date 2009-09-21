(defn r [] (require :reload 'ex2_1))

(defn gcd [a b]
  (if (= b 0) a
      (gcd b (rem a b))))

(defn negative?
  [n]
  (< n 0) )

(defn make-positive-rat [n d]
  (let [cd (gcd n d)]
    (list (/ n cd) (/ d cd)) ))

(defn make-negative-rat [n d]
  (let [cd (gcd n d)]
    (list (- (/ n cd)) (/ d cd)) ))

(defn make-rat [n d]
  (cond (and (negative? n) (negative? d)) (make-positive-rat (- n) (- d))
        (negative? n) (make-negative-rat (- n) d)
        (negative? d) (make-negative-rat n (- d))
        :else (make-positive-rat n d) ))

(defn numer [rat] (first rat))
(defn denom [rat] (first (rest rat)))

(defn +rat [a b]
  (make-rat (+ (* (numer a) (denom b)) (* (numer b) (denom a)))
            (* (denom a) (denom b)) ))

(defn -rat [a b]
  (make-rat (- (* (numer a) (denom b)) (* (numer b) (denom a)))
            (* (denom a) (denom b)) ))

(defn *rat [a b]
  (make-rat (* (numer a) (numer b))
            (* (denom a) (denom b)) ))

(defn div-rat [a b]
  (make-rat (* (numer a) (denom b))
            (* (denom a) (numer b)) ))

(defn rat= [a b]
  (= (* (numer a) (denom b))
     (* (denom a) (numer b)) ))

(defn print-rat [r]
  (do
      (print (numer r))
      (print "/")
    (print (denom r))))
             

(def half (make-rat 1 2))
(def third (make-rat 1 3))

