;; SICP 2.61

;; Exercise 2.61.  Give an implementation of adjoin-set using the
;; ordered representation. By analogy with element-of-set? show how to
;; take advantage of the ordering to produce a procedure that requires
;; on the average about half as many steps as with the unordered
;; representation.

;; ANSWER ------------------------------------------------------------

(define (adjoin-set item set)
  (cond ((null? set) (list item))
        ((< item (car set)) (cons item set))
        ((equal? item (car set)) set)
        (else (cons (car set) (adjoin-set item (cdr set))))))
