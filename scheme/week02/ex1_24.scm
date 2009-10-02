;; SICP 1.24

;; Exercise 1.24.  Modify the timed-prime-test procedure of exercise
;; 1.22 to use fast-prime? (the Fermat method), and test each of the
;; 12 primes you found in that exercise. Since the Fermat test has
;; theta(log n) growth, how would you expect the time to test primes
;; near 1,000,000 to compare with the time needed to test primes near
;; 1000?  Do your data bear this out? Can you explain any discrepancy
;; you find?

;; ANSWER ------------------------------------------------------------

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))        

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))


;; Heres the timing code (copied from previous exercises and modified
;; to use fast-prime?).

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 1000)
      (report-prime (- (runtime) start-time))
      #f) )

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  elapsed-time)


(define (prime-check n count times)
  (cond ((zero? count) times)
        (else
         (let ((time-result (timed-prime-test n)))
           (if time-result
               (prime-check (+ n 1) (- count 1) (+ time-result times))
               (prime-check (+ n 1) count times)))) ))

(define (find-primes starting)
  (/ (prime-check starting 3 0) 3.0))

;; Wow.  This version is fast!  I started with it testing 10 random
;; numbers in the Fermat test and was unable to get decent timings
;; from that.
;;
;; So I upped the number of random samples to 1000 and started at
;; 10^6.  Since this should be log(n) growth, I squared n on each
;; step, so the time should more or less double each time.

;;          10^6     0.07   
;;          10^12    0.17   2.4
;;          10^24    0.38   2.23
;;          10^48    0.92   2.42
;;          10^96    2.84   3.09
;;          10^100   3.08   (ok, I had to try a google!)

;; The growth ratio was expected to be around 2.  Instead it is around
;; 2.5 to 3.  I suspect that performance issues in dealing with these
;; huge numbers is what is slowing down the speed.
