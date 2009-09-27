;; SICP 2.1 tests

(test-case "Ex 2.1 Improved make-rat handles signs"
           (assert-equal (cons 1 2) (make-rat 1 2))
           (assert-equal (cons -1 2) (make-rat -1 2))
           (assert-equal (cons -1 2) (make-rat 1 -2))
           (assert-equal (cons 1 2) (make-rat -1 -2)))

(test-case "Ex 2.1 Improved make-rat reduces"
           (assert-equal (cons 1 2) (make-rat 2 4))
           (assert-equal (cons -1 2) (make-rat -2 4))
           (assert-equal (cons -1 2) (make-rat 2 -4))
           (assert-equal (cons 1 2) (make-rat -2 -4)))
