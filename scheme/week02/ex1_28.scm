;; SICP 1.28

;; Exercise 1.28.  One variant of the Fermat test that cannot be
;; fooled is called the Miller-Rabin test (Miller 1976; Rabin
;; 1980). This starts from an alternate form of Fermat's Little
;; Theorem, which states that if n is a prime number and a is any
;; positive integer less than n, then a raised to the (n - 1)st power
;; is congruent to 1 modulo n. To test the primality of a number n by
;; the Miller-Rabin test, we pick a random number a<n and raise a to
;; the (n - 1)st power modulo n using the expmod procedure. However,
;; whenever we perform the squaring step in expmod, we check to see if
;; we have discovered a ``nontrivial square root of 1 modulo n,'' that
;; is, a number not equal to 1 or n - 1 whose square is equal to 1
;; modulo n. It is possible to prove that if such a nontrivial square
;; root of 1 exists, then n is not prime. It is also possible to prove
;; that if n is an odd number that is not prime, then, for at least
;; half the numbers a<n, computing a^(n-1) in this way will reveal a
;; nontrivial square root of 1 modulo n. (This is why the Miller-Rabin
;; test cannot be fooled.) Modify the expmod procedure to signal if it
;; discovers a nontrivial square root of 1, and use this to implement
;; the Miller-Rabin test with a procedure analogous to
;; fermat-test. Check your procedure by testing various known primes
;; and non-primes. Hint: One convenient way to make expmod signal is
;; to have it return 0.

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
;; hugh numbers is what is slowing down the speed.
