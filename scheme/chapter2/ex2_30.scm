;; SICP 2.30

;; Exercise 2.30.  Define a procedure square-tree analogous to the
;; square-list procedure of exercise 2.21. That is, square-list should
;; behave as follows:

;; (square-tree
;;  (list 1
;;        (list 2 (list 3 4) 5)
;;        (list 6 7)))
;; (1 (4 (9 16) 25) (36 49))

;; Define square-tree both directly (i.e., without using any
;; higher-order procedures) and also by using map and recursion.

;; ANSWER ------------------------------------------------------------

(define (square-tree-1 items)
  (cond ((null? items) ())
        ((number? items) (square items))
        (else (cons (square-tree (car items))
                    (square-tree (cdr items))))))

(define (square-tree-2 items)
  (map (lambda (items)
         (cond ((not (pair? items)) (square items))
               (else (square-tree-2 items))))
       items))
