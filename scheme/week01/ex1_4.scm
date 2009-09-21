;; SICP 1.4

;; Exercise 1.4.  Observe that our model of evaluation allows for
;; combinations whose operators are compound expressions. Use this
;; observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; (a-plus-abs-b 2 3)
;; ((if (> 3 0) + -) 2 3)    ;; First expansion
;; ((if true + -) 2 3)       ;; Expand condition
;; (+ 2 3)                   ;; Substitute if
;; 5                         ;; Substitute the addition
