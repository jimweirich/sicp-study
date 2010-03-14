;; SICP Test 2.23

(test-case "Ex 2.23 For Each"
           (let ((result ()))
             (for-each-1 (lambda (x) (set! result (cons x result))) (list 57 321 88))
             (assert-equal '(88 321 57) result)))
