;; SICP 1.12

;; Exercise 1.12 The following pattern of numbers is called Pascal's triangle.
;;
;; The numbers at the edge of the triangle are all 1, and each number
;; inside the triangle is the sum of the two numbers above it. Write
;; a procedure that computes elements of Pascal's triangle by means of
;; a recursive process.

;; ANSWER ------------------------------------------------------------

(define (pascal-element row col)
  (define (edge? row col)
    (or (= row 1) (= col 1) (= row col)))
  (cond ((edge? row col) 1)
        (else (+ (pascal-element (- row 1) (- col 1))
                 (pascal-element (- row 1) col)))))

;; -------------------------------------------------------------------
;; ANOTHER ANSWER ...
;; That is way over complicated because I didn't read the instructions
;; carefully.
;; -------------------------------------------------------------------

;; Make the next row in the triangle from the current row.
(define (make-row row)
  (define (make-short-row row)
    (cond ((null? row) ())
          ((null? (cdr row)) '(1))
          (else (cons (+ (car row) (cadr row))
                      (make-short-row (cdr row))))))
  (cons 1 (make-short-row row)))

;; Make a pascals triangle of 'n' rows.
(define (pascal n)
  (define (pasc i prev)
    (cond ((zero? i) ())
          (else (let ((row (make-row prev)))
                  (cons row (pasc (- i 1) row))))))
  (pasc n ()))

