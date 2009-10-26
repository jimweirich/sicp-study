;; SICP Test 2.29

(test-case "Ex 2.29 - Simple Branch"
           (let ((branch (make-branch 10 5)))
             (assert-equal 10 (branch-length branch))
             (assert-equal 5 (branch-structure branch))))

(test-case "Ex 2.29 - Structured Branch"
           (let* ((br10 (make-branch 5 10))
                  (br05 (make-branch 10 5))
                  (submobile (make-mobile br05 br10))
                  (branch (make-branch 10 submobile)))
             (assert-equal 10 (branch-length branch))
             (assert-equal submobile (branch-structure branch))
             (assert-equal 15 (branch-weight branch))))

(test-case "Ex 2.29 - Mobile"
           (let* ((left (make-branch 5 10))
                  (right (make-branch 10 5))
                  (mobile (make-mobile left right)))
             (assert-equal left (left-branch mobile))
             (assert-equal right (right-branch mobile))))

(test-case "Ex 2.29 - Total Weight"
           (let* ((br10 (make-branch 5 10))
                  (br05 (make-branch 10 5))
                  (mobile (make-mobile br05 br10))
                  (mobile20 (make-mobile br10 br10)))
             (assert-equal 15 (total-weight mobile))
             (assert-equal 20 (total-weight mobile20))))

(test-case "Ex 2.29 - Balanced"
           (let* ((left (make-branch 1 50))
                  (right (make-branch 10 5))
                  (mobile (make-mobile left right)))
             (assert-true (mobile-balanced? mobile))))
