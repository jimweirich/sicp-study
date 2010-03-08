;; SICP 3.4

;; Exercise 3.4.  Modify the make-account procedure of exercise 3.3 by
;; adding another local state variable so that, if an account is
;; accessed more than seven consecutive times with an incorrect
;; password, it invokes the procedure call-the-cops.

;; -------------------------------------------------------------------

(define (make-account actual-password balance)
  (let ((count 0))
    (define (another-bad-password)
      (set! count (+ count 1)))
    (define (reset-password-count)
      (set! count 0))
    (define (too-many-bad-passwords?)
      (>= count 7))
    (define (withdraw amount)
      (cond ((> amount balance) "Insufficient funds")
            (else (set! balance (- balance amount))
                  balance)))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (bad-password ignored)
      (another-bad-password)
      (cond ((too-many-bad-passwords?) (call-the-cops))
            (t "Incorrect password")))
    (lambda (password operation)
      (if (not (equal? password actual-password))
          bad-password
          (begin
            (reset-password-count)
            (cond 
             ((equal? operation 'withdraw) withdraw)
             ((equal? operation 'deposit) deposit)))))))

