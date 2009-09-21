(defn r [] (require :reload 'chap2))

(defn gcd [a b]
  (if (= b 0) a
      (gcd b (rem a b))))

(defn make-rat [n d]
  (let [cd (gcd n d)]
    (list (/ n cd) (/ d cd)) ))

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


; --------------------------------------------------------------------

(defn conz [x y]
  (fn [m]
      (cond (= m 0) x
            (= m 1) y
            :else '(error "Argument not 0 or 1 -- CONZ" m) )))

(defn kar [z] (z 0))
(defn cdr [z] (z 1))
      
; --------------------------------------------------------------------

(defn mc
  [f seq]
  (loop [seq seq ans []]
    (if (empty? seq) ans
        (recur (rest seq) (conj ans (f (first seq)))) )))
