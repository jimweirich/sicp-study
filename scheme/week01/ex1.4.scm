(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; (a-plus-abs-b 2 3)
;; ((if (> 3 0) + -) 2 3)
;; ((if true + -) 2 3)
;; (+ 2 3)
;; 5

;;; ------------------------------------------------------------------

(load "../testing.scm")

(define (test)
  (assert-equal 5 (a-plus-abs-b 2 3)))

(test)
