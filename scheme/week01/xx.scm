(define (fact n)
  (if (zero? n)
      1
      (* (fact (- n 1)))))
