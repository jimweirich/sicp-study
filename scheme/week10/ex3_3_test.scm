;; SICP Tests 3.3

(test-case "Ex 3.3 -- make-account creates an account"
           (let ((a (make-account 'pw 10)))
             (assert-not-equal () a)))

(test-case "Ex 3.3 -- withdrawing money from an account"
           (let ((acc (make-account 'pw 10)))
             (assert-equal 8 ((acc 'pw 'withdraw) 2))))

(test-case "Ex 3.3 -- withdrawing all money from an account"
           (let ((acc (make-account 'pw 10)))
             (assert-equal 0 ((acc 'pw 'withdraw) 10))))

(test-case "Ex 3.3 -- overdrawing money from an account"
           (let ((acc (make-account 'pw 10)))
             (assert-equal "Insufficient funds" ((acc 'pw 'withdraw) 12))))

(test-case "Ex 3.3 -- depositing money to an account"
           (let ((acc (make-account 'pw 10)))
             (assert-equal 17 ((acc 'pw 'deposit) 7))))

(test-case "Ex 3.3 -- bad password"
           (let ((acc (make-account 'pw 10)))
             (assert-equal "Incorrect password"
                           ((acc 'bad-pw 'deposit) 7))
             (assert-equal "Incorrect password"
                           ((acc 'bad-pw 'withdraw) 7))))
