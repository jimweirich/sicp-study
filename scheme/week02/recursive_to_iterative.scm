;; There was some question in the study group today on converting a
;; recursive process to an iterative process.  At the time I was
;; unable to put into words how to do that.
;;
;; So here I will walk thru the fast exponentiation example with
;; explanations for each step.
;;
;; First, let's put in place a very simple test case for fast-exp.
;; Run this test after every change.

(define (check-exp step)
  (if (and (= 1 (fast-exp 2 0))
           (= 2 (fast-exp 2 1))
           (= 4 (fast-exp 2 2))
           (= 32 (fast-exp 2 5))
           (= 256 (fast-exp 2 8))
           (= 1024 (fast-exp 2 10)))
      (list step 'ok)
      (list step 'failed)) )

;; STEP 1:
;;
;; Here is the text-book definition of the recursive fast-exp.  We
;; will start with this.

(define (fast-exp b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-exp b (/ n 2))))
        (else (* b (fast-exp b (- n 1))))))

(check-exp 'step-1)

;; STEP 2:
;;
;; Let's go ahead and apply the relation that b^n is equivalent to
;; (b^2)^(n/2).

(define (fast-exp b n)
  (cond ((= n 0) 1)
        ((even? n) (fast-exp (square b) (/ n 2)))
        (else (* b (fast-exp b (- n 1))))))

(check-exp 'step-2)

;; STEP 3
;;
;; The first step is to define a no-argument loop function.  It
;; initially contains the original function definintion without any
;; changes.  Add a call to loop as the body of the main function to
;; kick it off.
;;
;; The key is that this function is still a valid definition of
;; fast-exp.  Go ahead and run the check-exp against it.

(define (fast-exp b n)
  (define (loop)
    (cond ((= n 0) 1)
          ((even? n) (fast-exp (square b) (/ n 2)))
          (else (* b (fast-exp b (- n 1))))))
  (loop))

(check-exp 'step-3)

;; STEP 4
;;
;; Now add an accumulator to the loop function to capture the
;; continuing state.  The terminating condition of the cond, (= n 0)
;; in this case, should return the accumulator.  The initial call to
;; loop should pass in the original value returned from the
;; terminating condition, in this case, 1.

(define (fast-exp b n)
  (define (loop accum)
    (cond ((= n 0) accum)
          ((even? n) (fast-exp (square b) (/ n 2)))
          (else (* b (fast-exp b (- n 1))))))
  (loop 1))

(check-exp 'step-4)

;; STEP 5
;;
;; Now converate all recursive calls to fast-exp into recursive calls
;; to loop.  If the recursive fast-exp call modifies one of its
;; parameters, then the parameter needs to be added to the loop
;; procedure and properly initialized in the main call to loop.
;;
;; Oh, and don't forget to add accum to each of the calls to loop.

(define (fast-exp b n)
  (define (loop b n accum)
    (cond ((= n 0) accum)
          ((even? n) (loop (square b) (/ n 2) accum))
          (else (* b (loop b (- n 1) accum)))))
  (loop b n 1))

(check-exp 'step-5)

;; STEP 6 
;;
;; Finally, let's remove the non-tail recursive call to loop by
;; removing the multiply by b continuation and multiplying accum by b
;; instead.

(define (fast-exp b n)
  (define (loop b n accum)
    (cond ((= n 0) accum)
          ((even? n) (loop (square b) (/ n 2) accum))
          (else (loop b (- n 1) (* b accum)))))
  (loop b n 1))

(check-exp 'step-6)

;; That's it.  Fast-exp now defines an interative process.

