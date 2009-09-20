;; SICP 1.23

;; Exercise 1.23.  The smallest-divisor procedure shown at the start
;; of this section does lots of needless testing: After it checks to
;; see if the number is divisible by 2 there is no point in checking
;; to see if it is divisible by any larger even numbers. This suggests
;; that the values used for test-divisor should not be 2, 3, 4, 5, 6,
;; ..., but rather 2, 3, 5, 7, 9, .... To implement this change,
;; define a procedure next that returns 3 if its input is equal to 2
;; and otherwise returns its input plus 2. Modify the smallest-divisor
;; procedure to use (next test-divisor) instead of (+ test-divisor
;; 1). With timed-prime-test incorporating this modified version of
;; smallest-divisor, run the test for each of the 12 primes found in
;; exercise 1.22. Since this modification halves the number of test
;; steps, you should expect it to run about twice as fast. Is this
;; expectation confirmed? If not, what is the observed ratio of the
;; speeds of the two algorithms, and how do you explain the fact that
;; it is different from 2?

;; ANSWER ------------------------------------------------------------

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))
      #f) )

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  elapsed-time)

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (define (next test-divisor)
    (if (= test-divisor 2) 3 (+ test-divisor 2)) )
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (prime-check n count times)
  (cond ((zero? count) times)
        (else
         (let ((time-result (timed-prime-test n)))
           (if time-result
               (prime-check (+ n 1) (- count 1) (+ time-result times))
               (prime-check (+ n 1) count times)))) ))

(define (find-primes starting)
  (/ (prime-check starting 3 0) 3.0))

;; Same table as 1.22, but with the better next divisor function.
;;
;;         10,000,000   0.006
;;        100,000,000   0.02    3.3
;;      1,000,000,000   0.06    3.0
;;     10,000,000,000   0.19    3.2
;;    100,000,000,000   0.63    3.3
;;  1,000,000,000,000   2.0     3.1
;; 10,000,000,000,000   6.3     3.2
;;  
;; Same growth characteristic (i.e. theta(sqrt(n)).  It is slightly
;; faster, but not twice as fast (e.g. 6.3 rather than 8.8).  The
;; reason it isn't twice as fast is probably because the (next
;; test-divisor) call is significantly more complicated than the
;; simple (+ test-divisor 1) code, therefore we lose a little
;; performance due to that.
