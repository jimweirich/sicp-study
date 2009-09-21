(defn r [] (require :reload 'ex2_2))

(defn make-point
  [x y]
  (list x y) )

(defn x-coord
  [pt]
  (first pt) )

(defn y-coord
  [pt]
  (first (rest pt)) )

(defn +point
  [pt1 pt2]
  (make-point
   (+ (x-coord pt1) (x-coord pt2))
   (+ (y-coord pt1) (y-coord pt2)) ))

(defn -point
  [pt1 pt2]
  (make-point
   (- (x-coord pt1) (x-coord pt2))
   (- (y-coord pt1) (y-coord pt2)) ))

(defn scale-point
  [n pt]
  (make-point
   (* n (x-coord pt))
   (* n (y-coord pt)) ))

(defn =point
  [p1 p2]
  (and (= (x-coord p1) (x-coord p2))
       (= (y-coord p1) (y-coord p2)) ))

(def a (make-point 10 20))
(def b (make-point 16 26))

(defn make-segment
  [start-pt end-pt]
  (list start-pt end-pt) )

(defn start-point
  [segment]
  (first segment) )

(defn end-point
  [segment]
  (first (rest segment)) )

(defn midpoint
  ([segment]
   (midpoint (start-point segment) (end-point segment)))
  ([p1 p2]
   (scale-point 0.5 (+point p1 p2)) ))

(use 'clojure.contrib.test-is)

(deftest create-point-test
  (let [p (make-point 10 20)]
    (is (= 10 (x-coord p)))
    (is (= 20 (y-coord p))) ))

(deftest +point-test
  (let [p1 (make-point 10 20)
        p2 (make-point 6  16)
        sum (+point p1 p2)]
    (is (= 16 (x-coord sum)))
    (is (= 36 (y-coord sum))) ))

(deftest -point-test
  (let [p1 (make-point 10 20)
        p2 (make-point 6  16)
        diff (-point p1 p2)]
    (is (= 4 (x-coord diff)))
    (is (= 4 (y-coord diff))) ))

(deftest -point-test
  (let [p1 (make-point 10 20)
        result (scale-point 2 p1)]
    (is (= 20 (x-coord result)))
    (is (= 40 (y-coord result))) ))

(deftest =point-test
  (let [pt (make-point 10 20)
        same (make-point 10 20)
        diffx (make-point 11 20)
        diffy (make-point 10 19)]
    (is (=point same pt))
    (is (not (=point diffx pt)))
    (is (not (=point diffy pt))) ))

(deftest create-segment
  (let [p1 (make-point 10 20)
        p2 (make-point 16 26)
        segment (make-segment p1 p2)]
    (is (=point p1 (start-point segment)))
    (is (=point p2 (end-point segment))) ))

(deftest midpoint-of-points-test
  (let [p1 (make-point 10 20)
        p2 (make-point 12 22)
        mid (midpoint p1 p2)]
    (is (=point (make-point 11 21) mid)) ))

(deftest midpoint-of-segment-test
  (let [p1 (make-point 10 20)
        p2 (make-point 12 22)
        segment (make-segment p1 p2)
        mid (midpoint segment)]
    (is (=point (make-point 11 21) mid)) ))

