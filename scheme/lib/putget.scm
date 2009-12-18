(define *table* ())

(define (clear-table)
  (set! *table* ()))

(define (put operator type value)
  (let ((key (list operator type)))
    (set! *table* (del-assoc key *table*))
    (set! *table* (cons (cons key value) *table*))))

(define (get operator type)
  (let* ((key (list operator type))
         (pair (assoc key *table*))) 
    (if (pair? pair) (cdr pair) ())))
