;; Interval math tests

(test-case "Interval creation"
           (let ((a (make-interval 4 6)))
             (assert-equal 4 (lower-bound a))
             (assert-equal 6 (upper-bound a))))

(test-case "Interval addition"
           (let* ((a (make-interval 4 6))
                  (b (make-interval 7 9))
                  (sum (add-interval a b)))
             (assert-equal 11 (lower-bound sum))
             (assert-equal 15 (upper-bound sum))))

(test-case "Interval subtraction"
           (let* ((a (make-interval 4 6))
                  (b (make-interval 7 9))
                  (diff (sub-interval b a)))
             (assert-equal 1 (lower-bound diff))
             (assert-equal 5 (upper-bound diff))))

(test-case "Interval multiplication ++ ++"
           (let* ((a (make-interval 4 6))
                  (b (make-interval 7 9))
                  (prod (mul-interval b a)))
             (assert-equal 28 (lower-bound prod))
             (assert-equal 54 (upper-bound prod))))

(test-case "Interval multiplication -+ ++"
           (let* ((a (make-interval -4 6))
                  (b (make-interval 7 9))
                  (prod (mul-interval b a)))
             (assert-equal -36 (lower-bound prod))
             (assert-equal 54 (upper-bound prod))))

(test-case "Interval multiplication -- ++"
           (let* ((a (make-interval -4 -6))
                  (b (make-interval 7 9))
                  (prod (mul-interval b a)))
             (assert-equal -54 (lower-bound prod))
             (assert-equal -28 (upper-bound prod))))

(test-case "Interval multiplication ++ -+"
           (let* ((a (make-interval 4 6))
                  (b (make-interval -7 9))
                  (prod (mul-interval b a)))
             (assert-equal -42 (lower-bound prod))
             (assert-equal 54 (upper-bound prod))))

(test-case "Interval multiplication -+ -+"
           (let* ((a (make-interval -4 6))
                  (b (make-interval -7 9))
                  (prod (mul-interval b a)))
             (assert-equal -42 (lower-bound prod))
             (assert-equal 54 (upper-bound prod))))

(test-case "Interval multiplication -- -+"
           (let* ((a (make-interval -4 -6))
                  (b (make-interval -7 9))
                  (prod (mul-interval b a)))
             (assert-equal -54 (lower-bound prod))
             (assert-equal 42 (upper-bound prod))))

(test-case "Interval multiplication ++ --"
           (let* ((a (make-interval 4 6))
                  (b (make-interval -7 -9))
                  (prod (mul-interval b a)))
             (assert-equal -54 (lower-bound prod))
             (assert-equal -28 (upper-bound prod))))

(test-case "Interval multiplication -+ --"
           (let* ((a (make-interval -4 6))
                  (b (make-interval -7 -9))
                  (prod (mul-interval b a)))
             (assert-equal -54 (lower-bound prod))
             (assert-equal 36 (upper-bound prod))))

(test-case "Interval multiplication -- --"
           (let* ((a (make-interval -4 -6))
                  (b (make-interval -7 -9))
                  (prod (mul-interval b a)))
             (assert-equal 28 (lower-bound prod))
             (assert-equal 54 (upper-bound prod))))

(test-case "Interval Construction -- Center Percent Intervals"
           (let* ((i (make-center-percent 200 5)))
             (assert-in-delta 200 (center i) 0.0001)
             (assert-in-delta 210 (upper-bound i) 0.0001)
             (assert-in-delta 190 (lower-bound i) 0.0001)
             (assert-in-delta 5 (percent i) 0.0001)
             (assert-in-delta 10 (width i) 0.0001)))
