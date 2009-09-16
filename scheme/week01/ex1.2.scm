(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 1 5)))))
   (* 3 (- 6 2) (- 2 7)) )

; Evals to -0.236666666666667

;;; ------------------------------------------------------------------

;; (load (merge-pathnames (pwd) "../lib/testing.scm"))

;; (define (test)
;;   (assert-equal -71/300
;;                 (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 1 5)))))
;;                    (* 3 (- 6 2) (- 2 7)) )))
;; (tests)

(display ( input-channel (current-input-port)))
