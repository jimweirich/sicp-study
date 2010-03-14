;; SICP 2.31

;; Exercise 2.31.  Abstract your answer to exercise 2.30 to produce a
;; procedure tree-map with the property that square-tree could be
;; defined as

;; (define (square-tree tree) (tree-map square tree))

;; ANSWER ------------------------------------------------------------

(define (tree-map func items)
  (map (lambda (items)
         (cond ((not (pair? items)) (func items))
               (else (tree-map func items))))
       items))

(define (square-tree-3 tree) (tree-map square tree))
