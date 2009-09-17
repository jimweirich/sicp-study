(define (make-row row)
  (define (make-short-row row)
    (cond ((null? row) ())
          ((null? (cdr row)) '(1))
          (else (cons (+ (car row) (cadr row))
                      (make-short-row (cdr row))))))
  (cons 1 (make-short-row row)))

(define (pascal n)
  (define (pasc i prev)
    (cond ((zero? i) ())
          (else (let ((row (make-row prev)))
                  (cons row (pasc (- i 1) row))))))
  (pasc n ()))

;;; ------------------------------------------------------------------

(let ((testing-file
       (get-environment-variable "TESTING_SCM")))
  (if testing-file
      (begin
        (load testing-file)

        (test-case "Making Rows"
                    (assert-equal '(1) (make-row ()))
                    (assert-equal '(1 1) (make-row '(1)))
                    (assert-equal '(1 4 6 4 1) (make-row '(1 3 3 1))))

        (test-case "Pascal's Triangle"
                   (assert-equal '((1)) (pascal 1))
                   (assert-equal '((1) (1 1)) (pascal 2))
                   (assert-equal '((1)
                                   (1 1)
                                   (1 2 1)
                                   (1 3 3 1)
                                   (1 4 6 4 1))
                                 (pascal 5)))
        
        (tests))))
