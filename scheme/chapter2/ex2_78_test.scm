;; SICP Tests 2.78 -- put/get

(test-case "Ex 2.78 -- put/get"
           (put 'op '(t1 t2) 'value)
           (assert-equal 'value (get 'op '(t1 t2) ))
           (assert-false (get 'op '(tx) )))

(test-case "Ex 2.78 -- Tagging"
           (let ((data (attach-tag 'the-tag 'the-value)))
             (assert-equal 'the-tag (type-tag data))
             (assert-equal 'the-value (contents data))))

(test-case "Ex 2.78 -- apply-generic"
           (define (op v) (+ 1 v))
           (put 'add1 '(t1) op)
           (let ((ten (attach-tag 't1 10)))
             (assert-equal 11 (apply-generic 'add1 ten))))

(test-case "Ex 2.78 -- Scheme number package"
           (let ((ten (make-scheme-number 10))
                 (eleven (make-scheme-number 11)))
             (assert-equal (make-scheme-number 21) (add ten eleven))))

(test-case "Ex 2.78 -- Rational Numbers"
           (let ((half (make-rational 1 2))
                 (third (make-rational 1 3)))
             (assert-equal (make-scheme-number 1) (numer half))
             (assert-equal (make-scheme-number 2) (denom half))
             (assert-equal (make-rational 5 6) (add half third))))

(test-case "Ex 2.78 -- Rectangular Numbers"
           (let ((x (make-from-real-imag 3 4)))
             (assert-equal 3 (real-part x))
             (assert-equal 4 (imag-part x))
             (assert-equal 5 (magnitude x))
             (assert-in-delta 0.927 (angle x) 0.01)))

(test-case "Ex 2.78 -- Polar Numbers"
           (let ((x (make-from-mag-ang 5 0.927)))
             (assert-in-delta 3 (real-part x) 0.01)
             (assert-in-delta 4 (imag-part x) 0.01)
             (assert-in-delta 5 (magnitude x) 0.01)
             (assert-in-delta 0.927 (angle x) 0.01)))

(test-case "Ex 2.78 -- Complex/rectangular Numbers"
           (let ((x (make-complex-from-real-imag 3 4)))
             (assert-in-delta 3 (real-part x) 0.01)
             (assert-in-delta 4 (imag-part x) 0.01)
             (assert-in-delta 5 (magnitude x) 0.01)
             (assert-in-delta 0.927 (angle x) 0.01)))

(test-case "Ex 2.78 -- Complex/polar Numbers"
           (let ((x (make-complex-from-mag-ang 5 0.927)))
             (assert-in-delta 3 (real-part x) 0.01)
             (assert-in-delta 4 (imag-part x) 0.01)
             (assert-in-delta 5 (magnitude x) 0.01)
             (assert-in-delta 0.927 (angle x) 0.01)))

(test-case "Ex 2.78 -- Complex Number arithmetic 1"
           (let ((x (make-complex-from-real-imag 3 4))
                 (y (make-complex-from-real-imag 9 12)))
             (assert-equal (make-complex-from-real-imag 12 16) (add x y))))

(test-case "Ex 2.78 -- Complex Number arithmetic 2"
           (let* ((x (make-complex-from-mag-ang 3 1))
                  (y (make-complex-from-mag-ang 4 1))
                  (result (add x y)))
             (assert-in-delta 7 (magnitude result) 0.01)
             (assert-in-delta 1 (angle result) 0.01)))
