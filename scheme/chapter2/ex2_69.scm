;; SICP 2.69

;; Exercise 2.69.  The following procedure takes as its argument a
;; list of symbol-frequency pairs (where no symbol appears in more
;; than one pair) and generates a Huffman encoding tree according to
;; the Huffman algorithm.

;; (define (generate-huffman-tree pairs)
;;   (successive-merge (make-leaf-set pairs)))

;; Make-leaf-set is the procedure given above that transforms the list
;; of pairs into an ordered set of leaves. Successive-merge is the
;; procedure you must write, using make-code-tree to successively
;; merge the smallest-weight elements of the set until there is only
;; one element left, which is the desired Huffman tree. (This
;; procedure is slightly tricky, but not really complicated. If you
;; find yourself designing a complex procedure, then you are almost
;; certainly doing something wrong. You can take significant advantage
;; of the fact that we are using an ordered set representation.)

;; LIBRARY FUNCTIONS -------------------------------------------------

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (define (loop tree)
    (cond ((leaf? tree) ())
          ((member symbol (symbols (left-branch tree)))
           (cons 0 (loop (left-branch tree))))
          (else (cons 1 (loop (right-branch tree))))))
  (if (member symbol (symbols tree))
        (loop tree)
        (error "Symbol not found")))

;; ANSWER ------------------------------------------------------------

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-pairs)
  (cond ((null? ordered-pairs) ())
        ((null? (cdr ordered-pairs)) (car ordered-pairs))
        (else (successive-merge
               (adjoin-set
                (make-code-tree (car ordered-pairs)
                                (cadr ordered-pairs))
                (cddr ordered-pairs))))))

;; Data from Exercise 2.70 -------------------------------------------

(define sample-pairs '((A 2)
                          (NA 16)
                          (BOOM 1)
                          (SHA 3)
                          (GET 2)
                          (YIP 9)
                          (JOB 2)
                          (WAH 1)))

(define tree (generate-huffman-tree sample-pairs))

(define song '(Get a job
                   Sha na na na na na na na na
                   Get a job
                   Sha na na na na na na na na
                   Wah yip yip yip yip yip yip yip yip yip
                   Sha boom))

(define answer (encode song tree))
; => (1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1
;     1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1
;     0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1)

;; 84 bits were required for the encoding.  Encoding 36 words with an
;; 8 bit encoding would use 288 bits.
