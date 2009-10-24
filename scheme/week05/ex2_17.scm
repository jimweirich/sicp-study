;; SICP 2.17

;; Exercise 2.17.  Define a procedure last-pair that returns the list
;; that contains only the last element of a given (nonempty) list:
;;
;; (last-pair (list 23 72 149 34))
;; (34)

;; ANSWER ------------------------------------------------------------

(define (last-pair lst)
  (cond ((null? lst) ())
        ((null? (cdr lst)) (car lst))
        (else (last-pair (cdr lst)))))
