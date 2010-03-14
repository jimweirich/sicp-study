;; SICP 1.22

;; Exercise 1.22.  Most Lisp implementations include a primitive
;; called runtime that returns an integer that specifies the amount of
;; time the system has been running (measured, for example, in
;; microseconds). The following timed-prime-test procedure, when
;; called with an integer n, prints n and checks to see if n is
;; prime. If n is prime, the procedure prints three asterisks followed
;; by the amount of time used in performing the test.

;; (NOTE: The following code has be slightly modified from the code
;; given in the book).

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

;; Using this procedure, write a procedure search-for-primes that
;; checks the primality of consecutive odd integers in a specified
;; range. Use your procedure to find the three smallest primes larger
;; than 1000; larger than 10,000; larger than 100,000; larger than
;; 1,000,000. Note the time needed to test each prime. Since the
;; testing algorithm has order of growth of theta(sqrt(n)), you should
;; expect that testing for primes around 10,000 should take about
;; sqrt(10) times as long as testing for primes around 1000. Do your
;; timing data bear this out? How well do the data for 100,000 and
;; 1,000,000 support the sqrt(n) prediction? Is your result compatible
;; with the notion that programs on your machine run in time
;; proportional to the number of steps required for the computation?

;; ANSWER ------------------------------------------------------------

;; Here is the prime number detection code from the book. 

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n)
  (= n (smallest-divisor n)))

;; Here is some code to check for numbers.  I used the modified timing
;; code from the book to find the first three primes after the
;; starting number.  The return value of find-primes is the average of
;; the times for each of the first 3 primes.

(define (prime-check n count times)
  (cond ((zero? count) times)
        (else
         (let ((time-result (timed-prime-test n)))
           (if time-result
               (prime-check (+ n 1) (- count 1) (+ time-result times))
               (prime-check (+ n 1) count times)))) ))

(define (find-primes starting)
  (/ (prime-check starting 3 0) 3.0))

;; Here are the times I got for the suggested starting times:
;;
;;              1000     0
;;            10,000     0
;;           100,000     0
;;         1,000,000     0
;;
;; Hmmm ... could it possibly be that today's computers are a bit
;; faster than the computers availble back when SICP was written?
;; Let's try some more numbers.  The number in the third colum is the
;; ratio of that time to the previous time.
;;
;;         10,000,000   0.003
;;        100,000,000   0.023   7.6
;;      1,000,000,000   0.083   3.6
;;     10,000,000,000   0.28    3.4
;;    100,000,000,000   0.88    3.1
;;  1,000,000,000,000   2.8     3.2
;; 10,000,000,000,000   8.8     3.1
;;  
;; Since n is increased by 10 every line, we would expect the ratio to
;; be close to sqrt(10), which is (approximately) 3.16.  So the time
;; growth of the prime number detector follows our expectations.
