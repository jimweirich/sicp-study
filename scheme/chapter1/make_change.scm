;;; My variation on the change making program.

(define denominations '(50 25 10 5 1))

;; Recursive Version of make-change, Using a list of denominations.

(define (make-change amount)
  (mc amount denominations))

(define (mc amount denoms)
  (cond ((zero? amount) 1)
        ((null? denoms) 0)
        ((< amount 0) 0)
        (else (+ (mc amount (cdr denoms))
                 (mc (- amount (car denoms)) denoms)))))


;; Iterative version of the above

(define (imake-change amount)
  (imc amount denominations))

(define (imc amount denoms)
  (define (loop result pending)
    (cond ((null? pending) result)
          (else
           (let ((amt (caar pending))
                 (den (cadar pending))
                 (remaining (cdr pending)))
             (cond ((zero? amt) (loop (+ 1 result) remaining))
                   ((null? den) (loop result remaining))
                   ((< amt 0) (loop result remaining))
                   (else (loop result
                               (cons (list amt (cdr den))
                                     (cons (list (- amt (car den)) den)
                                           remaining)))))))))
  (loop 0
        (list (list amount denoms))))



