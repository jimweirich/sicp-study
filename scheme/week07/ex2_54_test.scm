;; SICP Tests 2.54

(test-case "Ex 2.54 -- Equality of symbols"
           (assert-equal #t (myequal? 'foo 'foo))
           (assert-equal #f (myequal? 'foo 'bar))
           (assert-equal #f (myequal? 'foo '(bar)))
           (assert-equal #f (myequal? '(foo) 'bar)))

(test-case "Ex 2.54 -- Equality of lists"
           (assert-equal #t (myequal? '(foo) '(foo)))
           (assert-equal #f (myequal? '(foo) '(bar)))
           (assert-equal #f (myequal? '(foo) '(bar baz)))
           (assert-equal #f (myequal? '(foo fie) '(bar))))

(test-case "Ex 2.54 -- Equality of nil"
           (assert-equal #t (myequal? '() '()))
           (assert-equal #f (myequal? '() '(bar)))
           (assert-equal #f (myequal? '(foo) '())))
