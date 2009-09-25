;;; Very minimalistic testing framework for simple scheme programs.

(load-option 'regular-expression)

;;; List of all recorded tests.
(define *tests* ())

;;; Assertion procedure to use.
;;;
;;; Outside of a test, an error is reported.  This is overridden
;;; inside a test so that the remaining tests can continue.
(define *fail-test* (lambda (args) (error "assertion-failed" args)))

;;; Assertion messages -----------------------------------------------

(define (expected-true-message actual)
  (with-output-to-string
    (lambda ()
      (write-string "Expected <")
      (display actual)
      (write-string "> to be true"))))

(define (expected-false-message actual)
  (with-output-to-string
    (lambda ()
      (write-string "Expected <")
      (display actual)
      (write-string "> to be false"))))

(define (equal-message expected actual)
  (with-output-to-string
    (lambda ()
      (write-string "Expected <")
      (display expected)
      (write-string "> but got <")
      (display actual)
      (write-string ">"))))

(define (not-equal-message expected actual)
  (with-output-to-string
    (lambda ()
      (write-string "Expected <")
      (display expected)
      (write-string "> to not equal <")
      (display actual)
      (write-string ">"))))

(define (equal-in-delta-message expected actual delta)
  (with-output-to-string
    (lambda ()
      (write-string "Expected the delta of <")
      (display expected)
      (write-string "> and <")
      (display actual)
      (write-string "> to be less than <")
      (display delta)
      (write-string "> but was <")
      (display (abs (- expected actual)))
      (write-string ">"))))

(define (not-equal-in-delta-message expected actual delta)
  (with-output-to-string
    (lambda ()
      (write-string "Expected the delta of <")
      (display expected)
      (write-string "> and <")
      (display actual)
      (write-string "> to be greater than <")
      (display delta)
      (write-string "> but was <")
      (display (abs (- expected actual)))
      (write-string ">"))))

;;; Available Assertions ---------------------------------------------

(define (assert-with procedure message)
  (if (not (procedure))
      (*fail-test*  message)
      'test-ok))

(define (assert-true actual)
  (assert-with (lambda () actual)
               (expected-true-message actual)))

(define (assert-false actual)
  (assert-with (lambda () (not actual))
               (expected-false-message actual)))

(define (assert-equal expected actual)
  (assert-with (lambda () (equal? expected actual))
               (equal-message expected actual)) )

(define (assert-not-equal expected actual)
  (assert-with (lambda () (not (equal? expected actual)))
               (not-equal-message expected actual)) )

(define (assert-eq expected actual)
  (assert-with (lambda () (eq? expected actual))
               (equal-message expected actual)))

(define (assert-not-eq expected actual)
  (assert-with (lambda () (not (eq? expected actual)))
               (not-equal-message expected actual)))

(define (assert-in-delta expected actual delta)
  (assert-with (lambda () (< (abs (- actual expected)) delta))
               (equal-in-delta-message expected actual delta)))

(define (assert-not-in-delta expected actual delta)
  (assert-with (lambda () (>= (abs (- actual expected)) delta))
               (not-equal-in-delta-message expected actual delta)))

;;; Running Tests ----------------------------------------------------

;; Run a single named test.
(define (run-a-test test-name test-code)
  (call-with-current-continuation
   (lambda (cc)
     (fluid-let ((*fail-test*
                  (lambda (msg) (cc (list 'fail test-name msg)))))
       (test-code)
       (list 'pass test-name)))))

;; Run all the recorded tests.  Return a list of test results.
(define (execute-tests tests)
  (define (loop al test-results)
    (if (null? al)
        test-results
        (loop (cdr al)
              (cons (run-a-test (caar al) (cadar al))
                    test-results))))
  (loop tests ()))

;; Report the results of a test run.
(define (report-tests test-results)
  (define (show-one-failure failure)
    (write-string ";Test '")
    (write-string (cadr failure))
    (write-string "' failed: ")
    (write-string (caddr failure))
    (write-string "\n\n"))

  (define (show-failures failures)
    (cond ((null? failures) ())
          (else (show-one-failure (car failures))
                (show-failures (cdr failures)))))

  (define (show-test-results passing failing failures)
    (show-failures failures)
    (write-string ";")
    (display passing)
    (write-string " passing tests, ")
    (display failing)
    (write-string " failing tests.\n\n")
    'done)

  (define (report-remaining-tests test-results passing failing failures)
    (cond ((null? test-results) (show-test-results passing failing failures))
          ((eq? (caar test-results) 'pass)
           (report-remaining-tests (cdr test-results) (+ 1 passing) failing failures))
          (else
           (report-remaining-tests (cdr test-results)
                                   passing
                                   (+ 1 failing)
                                   (cons (car test-results) failures)))))

  (report-remaining-tests test-results 0 0 ()))

(define (run-tests tests)
  (report-tests (execute-tests tests)))

;;; Defining tests ---------------------------------------------------

(define (record-test test-name procedure)
  (set! *tests*
        (cons (list test-name procedure)
              (del-assoc! test-name *tests*)))
  test-name)

(define-syntax test-case
  (syntax-rules ()
    ((test-case name . code) (record-test name (lambda () . code)))))

(define (tests-matching pattern)
  (let ((re (string-append ".*" pattern)))
    (define (match? string)
      (re-string-match re string true))
    (define (loop tests result)
      (cond ((null? tests) (reverse result))
            ((match? (caar tests))
             (loop (cdr tests)
                   (cons (car tests) result) ))
            (else (loop (cdr tests) result))))
    (loop *tests* ())))

(define (display-one-test test)
  (write-string ";")
  (write-string (car test))
  (write-string "\n"))

(define (display-tests tests)
  (cond ((null? tests)
         (write-string "\n")
         'done)
        (else (display-one-test (car tests))
              (display-tests (cdr tests)))))

(define (show-one-test test)
  (display-one-test test)
  (pp (cadr test))
  (write-string "\n")
  'done)

(define (show-the-tests tests)
  (cond ((null? tests) 'done)
        (else (show-one-test (car tests))
              (show-the-tests (cdr tests)))))

(define (apply-to-tests proc args)
  (if (null? args)
      (proc *tests*)
      (proc (tests-matching (car args)))))

;;; User Facing Code -------------------------------------------------

;; Clear the list of recorded tests.
(define (clear-tests)
  (set! *tests* ())
  'ok)

;; Run the matching tests.  Run all tests if no pattern is given.
(define (tests . args)
  (apply-to-tests run-tests args))

;; List the names of all the matching tests.  List all the tests if no
;; pattern is given.
(define (list-tests . args)
  (apply-to-tests display-tests args))

;; Show the name and code for the matching tests. Show all the tests
;; if no pattern is given.
(define (show-tests . args)
  (apply-to-tests show-the-tests args))

'done

