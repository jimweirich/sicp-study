;; SICP 2.75

;; Exercise 2.75.  Implement the constructor make-from-mag-ang in
;; message-passing style. This procedure should be analogous to the
;; make-from-real-imag procedure given above.

;; ANSWER ------------------------------------------------------------

(define PI 3.1415972)
(define (to-rad deg)
  (* PI (/ deg 180.0)))

(define (make-from-mag-ang mag ang)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* mag  (cos ang)))
          ((eq? op 'imag-part) (* mag (sin ang)))
          ((eq? op 'magnitude) mag)
          ((eq? op 'angle) ang)
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)
