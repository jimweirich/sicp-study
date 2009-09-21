(defn r [] (require :reload 'chap1))

(def size 2)                            ; (define size 2)
(def pi 3.14159)
(def radius 10)

(defn circumference [] (* 2 pi radius))
(defn area [] (* pi (* radius radius)))

(defn square [x] (* x x))

(defn sum-of-squares [x y]
  (+ (square x) (square y)))

(defn f [a] (sum-of-squares (+ a 1) (* a 2)))

(defn abs1 [x]
  (cond
   (> x 0) x
   (== x 0) 0
   (< x 0) (- x) ))

(defn abs [x]
  (if (< x 0) (- x)
      x))

;; Exercise 1.2

(defn sum-squares-of-largests [a b c]
  (let [[x y z] (sort [a b c])]
       (sum-of-squares y z) ))

;; Exercise 1.3

(defn p [] (p))
(defn test1 [x y]
  (if (= x 0)
    0
    y))

;; Section 1.1.7

(defn average [x y]
  (/ (+ x y) 2.0) )

(defn improve [guess x]
  (average guess (/ x guess)) )

(defn good-enough? [guess x]
  (< (abs (- (square guess) x)) 0.001) )

(defn sqrt-iter [guess x]
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)) )

(defn sqrt1 [x]
  (sqrt-iter 1 x))

(defn sqrt2 [x]
  (loop [guess 1 iters 0]
    (cond (good-enough? guess x) guess
          (> iters 10000) guess
          :else (recur (improve guess x) (inc iters)) )))

(defn sqrt [x]
  (letfn
   [(my-good-enough? [guess]  (< (abs (- (square guess) x)) 0.001))
    (my-improve [guess]       (my-average guess (/ x guess)))
    (my-average [x y]         (/ (+ x y) 2.0))]
   (loop [guess 1 iters 0]
     (cond (my-good-enough? guess) guess
           (> iters 10000) guess
           :else (recur (my-improve guess) (inc iters)) ))))
   
; Exercise 1.11 (pg 43)

(defn exp [b n]
  (letfn
   [(halve [n]   (/ n 2))]
   (loop [number b power n result 1]
     (cond
      (zero? power) result
      (odd? power) (recur number (dec power) (* result number))
      :else    (recur (square number) (halve power) result) ))))

; Exercise 1.12 (pg 43)

(defn mult [a b]
  (if (= b 1) a
      (+ a (mult a (dec b))) ))

(defn fast-mult [a b]
  (letfn
   [(double [n] (+ n n))
    (halve [n]  (/ n 2))]
   (cond (= b 1) a
         (even? b) (fast-mult (double a) (halve b))
         :else (+ a (fast-mult a (dec b))) )))

; Exercise 1.13

(defn ifast-mult [i j]
  (letfn
   [(double [n] (+ n n))
    (halve [n]  (/ n 2))]
   (loop [a i b j result 0]
     (cond (= b 0) result
         (even? b) (recur (double a) (halve b) result)
         :else (recur a (dec b) (+ result a)) ))))

; Exercise 1.15
(comment
 (gcd 206 40))

(comment
 (gcd 206 40)
 (gcd 40 (rem 206 40))
 (gcd 40 6)
 (gcd 6 (rem 40 6))
 (gcd 6 4)
 (gcd 4 (rem 6 4))
 (gcd 4 2)
 (gcd 2 (rem 4 2))
 (gcd 2 0)
 2
 )

; Exercise 

(defn divides? [potential-divisor n]
  (zero? (rem n potential-divisor)) )

(defn find-divisor [n test-divisor]
  (cond
   (> (square test-divisor) n) n
   (divides? test-divisor n) test-divisor
   :else (recur n (inc test-divisor)) ))

(defn smallest-divisor [n]
  (find-divisor n 2) )

(defn prime? [n]
  (= n (smallest-divisor n)) )

(def ex1-16 (map smallest-divisor '(199 1999 19999)))


(defn expmod [b e m]
  (cond (zero? e) 1
        (even? e) (rem (square (expmod b (/ e 2) m)) m)
        :else (rem (* b (expmod b (- e 1) m)) m) ))

(def *random* (java.util.Random.))

(defn random [n]
  (.nextInt *random* n) )

(defn fermat-test [n]
  (let [a (+ 2 (random (- n 2)))]
    (= (expmod a n n) a) ))

(defn fast-prime? [n times]
  (cond (= times 0) true
        (fermat-test n) (recur n (dec times))
        :else false))

; Excersize 1.17

(def niners (iterate #(+ 9 (* % 10)) 1))

(defn tprime? [n]
  (let [start (System/currentTimeMillis)
        result (prime? n)
        end  (System/currentTimeMillis)]
    (println (str "(prime? " n ") => " result " : " (- end start)))
    result))

; Prime Experimentation

(defn reject-multiples [n] (fn [x] (not (zero? (mod x n)))))

(defn primes
  ([] (primes (iterate inc 2)))
  ([seq]
   (let [head (first seq)]
     (lazy-seq
      (cons head
            (primes (filter (reject-multiples head) (rest seq))) )))))

(def pnums (primes))

(defn really-long [n]
  (lazy-seq
   (cons n (really-long (inc n))) ))

(defn rl [n seq]
  (if (zero? n) nil
      (recur (dec n) (do (println (first seq)) (rest seq))) ))

; Section 1.3.1 (pg 52)

(defn sum-integers [a b]
  (loop [i a result 0]
    (if (> i b) result
        (recur (inc i) (+ i result)) )))
    
(defn cube [n] (* n n n))

(defn sum-cubes [a b]
  (loop [i a result 0]
    (if (> i b) result
        (recur (inc i) (+ (cube i) result)) )))
    
(defn pi-sum [a b]
  (loop [i a result 0]
    (if (> i b) result
        (recur (+ i 4) (+ (/ 1.0 (* i (+ i 2))) result)) )))
    
(defn pi-seq
  ([] (pi-seq 1))
  ([n]
   (lazy-seq
    (cons (/ 1.0 (* n (+ n 2)))
          (pi-seq (+ 4 n)) ))))
              
(defn sum [term a next b]
  (loop [i a result 0]
    (if (> i b) result
        (recur (next i) (+ (term i) result)) )))

(defn integral [f a b dx]
  (letfn [(add-dx [x] (+ x dx))]
         (* (sum f (+ a (/ dx 2)) add-dx b)
            dx) ))
