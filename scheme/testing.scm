;;; Very minimalistic testing framework for simple scheme programs.

(define (expected-message expected actual)
  (with-output-to-string
    (lambda ()
      (write "assertion failure: Expected: <")
      (write expected)
      (write "> but got <")
      (write actual)
      (write ">"))))

(define (not-expected-message expected actual)
  (with-output-to-string
    (lambda ()
      (write "assertion failure: Expected: <")
      (write expected)
      (write "> to not equal <")
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

(define (not-delta-message expected actual delta)
  (with-output-to-string
    (lambda ()
      (write "assert failure: expected the delta of <")
      (write expected)
      (write "> and <")
      (write actual)
      (write "> to be greater than <")
      (write delta)
      (write "> but was <")
      (write (abs (- expected actual)))
      (write ">"))))

(define (assert-with procedure message)
  (if (not (procedure))
      (error message)
      'test-ok))

(define (assert-equal expected actual)
  (assert-with (lambda () (equal? expected actual))
               (expected-message expected actual)) )

(define (assert-not-equal expected actual)
  (assert-with (lambda () (not (equal? expected actual)))
               (not-expected-message expected actual)) )

(define (assert-eq expected actual)
  (assert-with (lambda () (eq? expected actual))
               (expected-message expected actual)))

(define (assert-not-eq expected actual)
  (assert-with (lambda () (not (eq? expected actual)))
               (not-expected-message expected actual)))

(define (assert-in-delta expected actual delta)
  (assert-with (lambda () (< (abs (- actual expected)) delta))
               (error (delta-message expected actual delta))))

(define (assert-not-in-delta expected actual delta)
  (assert-with (lambda () (>= (abs (- actual expected)) delta))
               (error (not-delta-message expected actual delta))))
