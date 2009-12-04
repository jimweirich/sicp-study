;; SICP 2.63

;; Exercise 2.63.  Each of the following two procedures converts a
;; binary tree to a list.

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;; a. Do the two procedures produce the same result for every tree? If
;; not, how do the results differ? What lists do the two procedures
;; produce for the trees in figure 2.16?

;; b. Do the two procedures have the same order of growth in the
;; number of steps required to convert a balanced tree with n elements
;; to a list? If not, which one grows more slowly?


;; ANSWER ------------------------------------------------------------

;; A. Yes.  Both result in a mid-order traversal of the tree.  2.16
;; produces (1 2 3 4 5 6 7)

;; B. The second version will not consume stack when the left branch
;; is empty.  Also, it does not build an intermediate list that gets
;; appended for the final result.

;; -------------------------------------------------------------------
;; Library functions

(define x ())(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))
