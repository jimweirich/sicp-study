;; SICP 3.3

;; Exercise 3.3.  Modify the make-account procedure so that it creates
;; password-protected accounts. That is, make-account should take a
;; symbol as an additional argument, as in

;; (define acc (make-account 100 'secret-password))

;; The resulting account object should process a request only if it is
;; accompanied by the password with which the account was created, and
;; should otherwise return a complaint: 

;; ((acc 'secret-password 'withdraw) 40)
;; 60

;; ((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"

;; -------------------------------------------------------------------

(define (make-account actual-password balance)
  (define (withdraw amount)
    (cond ((> amount balance) "Insufficient funds")
          (else (set! balance (- balance amount))
                balance)))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (bad-password ignored)
    "Incorrect password")
  (lambda (password operation)
    (cond ((not (equal? password actual-password)) bad-password)
          ((equal? operation 'withdraw) withdraw)
          ((equal? operation 'deposit) deposit))))
