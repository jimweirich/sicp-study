;;; My variation on the change making program.

(define denominations '(50 25 10 5 1))

(define (make-change amount)
  (mc amount denominations))

(define (mc amount denoms)
  (cond ((zero? amount) 1)
        ((null? denoms) 0)
        (else (count2 amount 0 denoms))))

(define (count2 amount n denoms)
  (cond ((> (* n (car denoms)) amount) 0)
        (else (+ (count2 amount (+ n 1) denoms)
                 (mc (- amount (* n (car denoms))) (cdr denoms))
                 ))))

;;; ------------------------------------------------------------------

(let ((testing-file
       (get-environment-variable "TESTING_SCM")))
  (if testing-file
      (begin
        (load testing-file)

        (test-case "Make Change"
                    (assert-equal 1 (make-change 1))
                    (assert-equal 292 (make-change 100)))
        
        (tests))))
