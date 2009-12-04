;; SICP Test 2.59

(test-case "Ex 2.59 -- Adjoining Sets"
           (assert-equal '(a) (adjoin-set 'a ())) )

(test-case "Ex 2.59 -- Element of"
           (assert-equal #t (element-of-set? 'a '(a)))
           (assert-equal #f (element-of-set? 'a '(b c))))

(test-case "Ex 2.59 -- Set Intersection"
           (assert-equal '() (intersection-set '(a b) '(c d)))
           (assert-equal '(b) (intersection-set '(a b) '(b c))))

(test-case "Ex 2.59 -- Set Union"
           (assert-equal '() (union-set '() '()))
           (assert-equal '(a b c) (union-set '(a b) '(c)))
           (assert-equal '(a b c) (union-set '(a b) '(b c))))
