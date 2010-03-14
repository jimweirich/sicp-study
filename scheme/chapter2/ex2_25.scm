;; SICP 2.25

;; Exercise 2.25.  Give combinations of cars and cdrs that will pick 7
;; from each of the following lists:

;; ANSWER ------------------------------------------------------------

(car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))

(car (car '((7))))

(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr '(1 (2 (3 (4 (5 (6 7))))))))))))))))))
