;;; Very minimalistic testing framework for simple scheme programs.

(define (expected-message expected actual)
  (with-output-to-string
    (lambda ()
      (write "assertion failure: Expected: <")
      (write expected)
      (write "> but got <")
      (write actual)
      (write ">"))))

(define (delta-message expected actual delta)
  (with-output-to-string
    (lambda ()
      (write "assert failure: expected the delta of <")
      (write expected)
      (write "> and <")
      (write actual)
      (write "> to be less than <")
      (write delta)
      (write "> but was <")
      (write (abs (- expected actual)))
      (write ">"))))

(define (assert-equal expected actual)
  (if (not (equal? expected actual))
      (error (expected-message expected actual))
      #t) )

(define (assert-eq expected actual)
  (if (not (eq? expected actual))
      (error (expected-message expected actual))
      #t))

(define (assert-in-delta expected actual delta)
  (if (not (< (abs (- actual expected))
              delta))
      (error (delta-message expected actual delta))
      #t))
