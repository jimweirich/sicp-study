;; SICP 2.68

;; Exercise 2.68.  The encode procedure takes as arguments a message
;; and a tree and produces the list of bits that gives the encoded
;; message.

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;; Encode-symbol is a procedure, which you must write, that returns
;; the list of bits that encodes a given symbol according to a given
;; tree. You should design encode-symbol so that it signals an error
;; if the symbol is not in the tree at all. Test your procedure by
;; encoding the result you obtained in exercise 2.67 with the sample
;; tree and seeing whether it is the same as the original sample
;; message.

;; ANSWER ------------------------------------------------------------

(define (encode-symbol symbol tree)
  (define (loop tree)
    (cond ((leaf? tree) ())
          ((member symbol (symbols (left-branch tree)))
           (cons 0 (loop (left-branch tree))))
          (else (cons 1 (loop (right-branch tree))))))
  (if (member symbol (symbols tree))
        (loop tree)
        (error "Symbol not found")))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(define sample-decoded-message '(a d a b b c a))

sample-message

(define answer (encode sample-decoded-message sample-tree))

(equal? sample-message answer)          ; => #t
