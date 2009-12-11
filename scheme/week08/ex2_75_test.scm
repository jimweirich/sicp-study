;; SICP Tests 2.75

(test-case "Ex 2.75 -- To Radians"
           (assert-in-delta 0.707 (to-rad 45) 0.783))


(test-case "Ex 2.75 -- Data Driven Complex Number"
           (let ((c (make-from-mag-ang 1 (to-rad 45))))
             (assert-equal 1 (c 'magnitude))
             (assert-in-delta (to-rad 45) (c 'angle) 0.001)
             (assert-in-delta 0.707 (c 'real-part) 0.001)
             (assert-in-delta 0.707 (c 'imag-part) 0.001)))

(test-case "Ex 2.75 -- Data Driven Complex Number 2"
           (let ((c (make-from-mag-ang 1 (to-rad 0))))
             (assert-equal 1 (c 'magnitude))
             (assert-in-delta (to-rad 0) (c 'angle) 0.001)
             (assert-in-delta 1 (c 'real-part) 0.001)
             (assert-in-delta 0 (c 'imag-part) 0.001)))
