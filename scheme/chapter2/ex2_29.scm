;; SICP 2.29

;; Exercise 2.29.  A binary mobile consists of two branches, a left
;; branch and a right branch. Each branch is a rod of a certain
;; length, from which hangs either a weight or another binary
;; mobile. We can represent a binary mobile using compound data by
;; constructing it from two branches (for example, using list):

;; (define (make-mobile left right)
;;   (list left right))

;; A branch is constructed from a length (which must be a number)
;; together with a structure, which may be either a number
;; (representing a simple weight) or another mobile:

;; (define (make-branch length structure)
;;   (list length structure))

;; a.  Write the corresponding selectors left-branch and right-branch,
;; which return the branches of a mobile, and branch-length and
;; branch-structure, which return the components of a branch.

;; b.  Using your selectors, define a procedure total-weight that
;; returns the total weight of a mobile.

;; c.  A mobile is said to be balanced if the torque applied by its
;; top-left branch is equal to that applied by its top-right branch
;; (that is, if the length of the left rod multiplied by the weight
;; hanging from that rod is equal to the corresponding product for the
;; right side) and if each of the submobiles hanging off its branches
;; is balanced. Design a predicate that tests whether a binary mobile
;; is balanced.

;; d.  Suppose we change the representation of mobiles so that the
;; constructors are

;; (define (make-mobile left right)
;;   (cons left right))
;; (define (make-branch length structure)
;;   (cons length structure))

;; How much do you need to change your programs to convert to the new
;; representation?

;; ANSWER ------------------------------------------------------------

;; (A)

(define (make-mobile left right) (error "not implemented"))
(define (left-branch mobile) (error "not implemented"))
(define (right-branch mobile) (error "not implemented"))
(define (make-branch length structure) (error "not implemented"))
(define (branch-length branch) (error "not implemented"))
(define (branch-structure branch) (error "not implemented")))

(define (list-based)
  (set! make-mobile
        (lambda (left right)
          (list left right)))

  (set! left-branch
        (lambda (mobile)
          (car mobile)))

  (set! right-branch
        (lambda (mobile)
          (cadr mobile)))


  (set! make-branch
        (lambda (length structure)
          (list length structure)))

  (set! branch-length
        (lambda (branch)
          (car branch)))

  (set! branch-structure
        (lambda (branch)
          (cadr branch))))

(list-based)

;; (B)

(define (branch-weight branch)
  (let ((struct (branch-structure branch)))
    (if (number? struct)
        struct
        (total-weight struct))))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

;; (C)

(define (torque branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (mobile-balanced? mobile)
  (= (torque (left-branch mobile))
     (torque (right-branch mobile))))


;; (D)

(define (cons-based)
  (set! make-mobile
        (lambda  (left right)
          (cons left right)))

  (set! left-branch
        (lambda  (mobile)
          (car mobile)))

  (set! right-branch
        (lambda  (mobile)
          (cdr mobile)))

  (set! make-branch
        (lambda  (length structure)
          (cons length structure)))

  (set! branch-length
        (lambda  (branch)
          (car branch)))

  (set! branch-structure
        (lambda  (branch)
          (cdr branch))))
