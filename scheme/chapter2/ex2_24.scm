;; SICP 2.24

;; Exercise 2.24.  Suppose we evaluate the expression (list 1 (list 2
;; (list 3 4))). Give the result printed by the interpreter, the
;; corresponding box-and-pointer structure, and the interpretation of
;; this as a tree (as in figure 2.6).

;; ANSWER ------------------------------------------------------------

(define (count-leaves items)
  (cond ((null? items) 0)
        ((pair? items) (+ (count-leaves (car items))
                          (count-leaves (cdr items))))
        (else 1)))

(count-leaves (list 1 (list 2 (list 3 4))))


;; +---+---+      +---+---+     +---+---+      +---+---+
;; | o | o-|----->| o | o-|---->| o | o-|----->| o | / |
;; +-|-+---+      +-|-+---+     +---+---+      +-|-+---+
;;   |              |             |              |
;;   V              V             V              V 
;; +---+          +---+         +---+          +---+
;; | 1 |          | 2 |         | 3 |          | 4 |
;; +---+          +---+         +---+          +---+
