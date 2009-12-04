;; SICP 2.55

;; Eva Lu Ator types to the interpreter the expression
;;
;;   (car ''abracadabra)
;;
;; To her surprise, the interpreter prints back quote. Explain. 

;; ANSWER ------------------------------------------------------------

;; The expression evaluations to (car '(quote abracadabra)), and the
;; result of that is indeed "quote".
