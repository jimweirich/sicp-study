;; -*- scheme-mode -*-

;; I have a symlink from ~/.scheme.init to this file.  MIT Scheme will
;; load this file automatically when it is starts up.

(set-environment-variable! "TESTING_SCM"
                           "/Users/jim/pgm/sicp/jimweirich/scheme/lib/testing.scm")

;; Load the testing tools.
(define (testing)
  (load (get-environment-variable "TESTING_SCM")))

;; Short cut for running tests.
(define (t) (tests))

;; Short cut for aborting after failures.
(define (r) (restart 1))
