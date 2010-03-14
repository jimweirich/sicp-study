;; SICP 1.41

;; Exercise 1.41.  Define a procedure double that takes a procedure of
;; one argument as argument and returns a procedure that applies the
;; original procedure twice. For example, if inc is a procedure that
;; adds 1 to its argument, then (double inc) should be a procedure
;; that adds 2. What value is returned by

;; (((double (double double)) inc) 5)

;; ANSWER ------------------------------------------------------------

(define (double f)
  (lambda (x) (f (f x))))

;; Here's the expansion for (((double (double double)) inc) 5)
;; The final result will be 21 (16 increment operations

(((double (double double)) inc) 5)
----------
(((double (lambda (f) (double (double f)))) inc) 5)
----------
(((lambda (x1)
    ((lambda (f) (double (double f)))
     ((lambda (f) (double (double f)))
      x1)))
  inc)
 5)
----------
(((lambda (f) (double (double f)))
  ((lambda (f) (double (double f)))
   inc))
 5)
----------
(((lambda (f) (double (double f)))
  (double (double inc)))
 5)
----------
(((lambda (f) (double (double f)))
  (double (lambda (x) (inc (inc x)))))
 5)
----------
(((lambda (f) (double (double f)))
  (lambda (x2)
    ((lambda (x3) (inc (inc x3)))
     ((lambda (x4) (inc (inc x4)))
      x2))))
 5)
----------
((double
  (double
   (lambda (x2)
     ((lambda (x3) (inc (inc x3)))
      ((lambda (x4) (inc (inc x4)))
       x2)))))
 5)
----------
((double
  (lambda (x5)
    ((lambda (x2)
       ((lambda (x3) (inc (inc x3)))
        ((lambda (x4) (inc (inc x4)))
         x2)))
     ((lambda (x2)
        ((lambda (x3) (inc (inc x3)))
         ((lambda (x4) (inc (inc x4)))
          x2)))
      x5))))
 5)
----------
((lambda (x6)
   ((lambda (x5)
      ((lambda (x2)
         ((lambda (x3) (inc (inc x3)))
          ((lambda (x4) (inc (inc x4)))
           x2)))
       ((lambda (x2)
          ((lambda (x3) (inc (inc x3)))
           ((lambda (x4) (inc (inc x4)))
            x2)))
        x5)))
    ((lambda (x5)
       ((lambda (x2)
          ((lambda (x3) (inc (inc x3)))
           ((lambda (x4) (inc (inc x4)))
            x2)))
        ((lambda (x2)
           ((lambda (x3) (inc (inc x3)))
            ((lambda (x4) (inc (inc x4)))
             x2)))
         x5)))
     x6)))
 5)
----------
((lambda (x5)
   ((lambda (x2)
      ((lambda (x3) (inc (inc x3)))
       ((lambda (x4) (inc (inc x4)))
        x2)))
    ((lambda (x2)
       ((lambda (x3) (inc (inc x3)))
        ((lambda (x4) (inc (inc x4)))
         x2)))
     x5)))
 ((lambda (x5)
    ((lambda (x2)
       ((lambda (x3) (inc (inc x3)))
        ((lambda (x4) (inc (inc x4)))
         x2)))
     ((lambda (x2)
        ((lambda (x3) (inc (inc x3)))
         ((lambda (x4) (inc (inc x4)))
          x2)))
      x5)))
  5))
----------
((lambda (x5)
   ((lambda (x2)
      ((lambda (x3) (inc (inc x3)))
       ((lambda (x4) (inc (inc x4)))
        x2)))
    ((lambda (x2)
       ((lambda (x3) (inc (inc x3)))
        ((lambda (x4) (inc (inc x4)))
         x2)))
     x5)))
 ((lambda (x2)
    ((lambda (x3) (inc (inc x3)))
     ((lambda (x4) (inc (inc x4)))
      x2)))
  ((lambda (x2)
     ((lambda (x3) (inc (inc x3)))
      ((lambda (x4) (inc (inc x4)))
       x2)))
   5)) )
----------
((lambda (x5)
   ((lambda (x2)
      ((lambda (x3) (inc (inc x3)))
       ((lambda (x4) (inc (inc x4)))
        x2)))
    ((lambda (x2)
       ((lambda (x3) (inc (inc x3)))
        ((lambda (x4) (inc (inc x4)))
         x2)))
     x5)))
 ((lambda (x2)
    ((lambda (x3) (inc (inc x3)))
     ((lambda (x4) (inc (inc x4)))
      x2)))
  ((lambda (x3) (inc (inc x3)))
   ((lambda (x4) (inc (inc x4)))
    5))))
----------
((lambda (x5)
   ((lambda (x2)
      ((lambda (x3) (inc (inc x3)))
       ((lambda (x4) (inc (inc x4)))
        x2)))
    ((lambda (x2)
       ((lambda (x3) (inc (inc x3)))
        ((lambda (x4) (inc (inc x4)))
         x2)))
     x5)))
 ((lambda (x2)
    ((lambda (x3) (inc (inc x3)))
     ((lambda (x4) (inc (inc x4)))
      x2)))
  ((lambda (x3) (inc (inc x3)))
   (inc (inc 5)))))
----------
((lambda (x5)
   ((lambda (x2)
      ((lambda (x3) (inc (inc x3)))
       ((lambda (x4) (inc (inc x4)))
        x2)))
    ((lambda (x2)
       ((lambda (x3) (inc (inc x3)))
        ((lambda (x4) (inc (inc x4)))
         x2)))
     x5)))
 ((lambda (x2)
    ((lambda (x3) (inc (inc x3)))
     ((lambda (x4) (inc (inc x4)))
      x2)))
  (inc (inc (inc (inc 5))))))
----------
((lambda (x5)
   ((lambda (x2)
      ((lambda (x3) (inc (inc x3)))
       ((lambda (x4) (inc (inc x4)))
        x2)))
    ((lambda (x2)
       ((lambda (x3) (inc (inc x3)))
        ((lambda (x4) (inc (inc x4)))
         x2)))
     x5)))
 ((lambda (x3) (inc (inc x3)))
  ((lambda (x4) (inc (inc x4)))
   (inc (inc (inc (inc 5)))))))
----------
((lambda (x5)
   ((lambda (x2)
      ((lambda (x3) (inc (inc x3)))
       ((lambda (x4) (inc (inc x4)))
        x2)))
    ((lambda (x2)
       ((lambda (x3) (inc (inc x3)))
        ((lambda (x4) (inc (inc x4)))
         x2)))
     x5)))
 ((lambda (x3) (inc (inc x3)))
  (inc (inc (inc (inc (inc (inc 5))))))))
----------
((lambda (x5)
   ((lambda (x2)
      ((lambda (x3) (inc (inc x3)))
       ((lambda (x4) (inc (inc x4)))
        x2)))
    ((lambda (x2)
       ((lambda (x3) (inc (inc x3)))
        ((lambda (x4) (inc (inc x4)))
         x2)))
     x5)))
 (inc (inc (inc (inc (inc (inc (inc (inc 5)))))))))
----------
((lambda (x2)
   ((lambda (x3) (inc (inc x3)))
    ((lambda (x4) (inc (inc x4)))
     x2)))
 ((lambda (x2)
    ((lambda (x3) (inc (inc x3)))
     ((lambda (x4) (inc (inc x4)))
      x2)))
  (inc (inc (inc (inc (inc (inc (inc (inc 5))))))))))
----------
((lambda (x2)
   ((lambda (x3) (inc (inc x3)))
    ((lambda (x4) (inc (inc x4)))
     x2)))
 ((lambda (x3) (inc (inc x3)))
  ((lambda (x4) (inc (inc x4)))
   (inc (inc (inc (inc (inc (inc (inc (inc 5)))))))))))
----------
((lambda (x2)
   ((lambda (x3) (inc (inc x3)))
    ((lambda (x4) (inc (inc x4)))
     x2)))
 ((lambda (x3) (inc (inc x3)))
  (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc 5))))))))))))
----------
((lambda (x3) (inc (inc x3)))
 ((lambda (x4) (inc (inc x4)))
  (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc 5))))))))))))))
----------
((lambda (x3) (inc (inc x3)))
 (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc 5)))))))))))))))
----------
(inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc 5))))))))))))))))
----------
(inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc 6)))))))))))))))
----------
(inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc 7))))))))))))))
----------
(inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc 8)))))))))))))
----------
(inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc 9))))))))))))
----------
(inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc 10)))))))))))
----------
(inc (inc (inc (inc (inc (inc (inc (inc (inc (inc 11))))))))))
----------
(inc (inc (inc (inc (inc (inc (inc (inc (inc 12)))))))))
----------
(inc (inc (inc (inc (inc (inc (inc (inc 13))))))))
----------
(inc (inc (inc (inc (inc (inc (inc 14)))))))
----------
(inc (inc (inc (inc (inc (inc 15))))))
----------
(inc (inc (inc (inc (inc 16)))))
----------
(inc (inc (inc (inc 17))))
----------
(inc (inc (inc 18)))
----------
(inc (inc 19))
----------
(inc 20)
----------
21



