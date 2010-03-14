;; SICP 2.18

;; Exercise 2.18.  Define a procedure reverse that takes a list as
;; argument and returns a list of the same elements in reverse order:
;;
;; (reverse (list 1 4 9 16 25))
;; (25 16 9 4 1)

;; ANSWER ------------------------------------------------------------

(define (reverse lst)
  (define (loop lst result)
    (cond ((null? lst) result)
          (else (loop (cdr lst) (cons (car lst) result)))))
  (loop lst ()))
