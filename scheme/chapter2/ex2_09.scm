;; SICP 1.9

;; Exercise 2.9.  The width of an interval is half of the difference
;; between its upper and lower bounds. The width is a measure of the
;; uncertainty of the number specified by the interval. For some
;; arithmetic operations the width of the result of combining two
;; intervals is a function only of the widths of the argument
;; intervals, whereas for others the width of the combination is not a
;; function of the widths of the argument intervals. Show that the
;; width of the sum (or difference) of two intervals is a function
;; only of the widths of the intervals being added (or
;; subtracted). Give examples to show that this is not true for
;; multiplication or division.

;; ANSWER ------------------------------------------------------------

;; Width for addtion:

;; lb = a.lb + b.lb
;; lb = (a.c - a.w) + (b.c - b.w)

;; ub = a.ub + b.ub
;; ub = (a.c + a.w) + (b.c + b.w)

;; w = (ub - lb)/2
;;   = ((a.c + a.w) + (b.c + b.w) - ((a.c - a.w) + (b.c - b.w)))/2
;;   = (a.c + a.w + b.c + b.w - a.c + a.w - b.c + b.w)/2
;;   = (a.c - a.c + b.c - b.c + a.w + b.w + a.w + b.w)/2
;;   = (2 * (a.w + b.w))/2
;;   = a.w + b.w

;; Clearly, the final width only depends on the widths of a and b.

;; -------------------------------------------------------------------
;; Width for subtraction

;; lb = a.lb - b.ub
;; lb = (a.c - a.w) - (b.c + b.w)

;; ub = a.ub - b.lb
;; ub = (a.c + a.w) - (b.c - b.w)

;; w = (ub - lb)/2
;;   = ((a.c + a.w) - (b.c - b.w) - ((a.c - a.w) - (b.c + b.w)))/2
;;   = (a.c + a.w - b.c + b.w - (a.c - a.w - b.c - b.w))/2
;;   = (a.c + a.w - b.c + b.w - a.c + a.w + b.c + b.w)/2
;;   = (a.c - a.c + b.c - b.c + a.w + a.w + b.w + b.w )/2
;;   = (2*a.w + 2*b.w)/2
;;   = a.w + b.w

;; Same result as for addition.

;; -------------------------------------------------------------------
;; Width for multiplication

;; p1 = a.lb * b.lb
;;    = (a.c - a.w) * (b.c - b.w)
;;    = (a.c*b.c - a.c*b.w - a.w*b.c + a.w*b.w)

;; p2 = a.ub * b.ub
;;    = (a.c + a.w) * (b.c + b.w)
;;    = (a.c*b.c + a.c*b.w + a.w*b.c + a.w*b.w)

;; w = (ub - lb)/2
;;   = ((a.c*b.c + a.c*b.w + a.w*b.c + a.w*b.w) - (a.c*b.c - a.c*b.w - a.w*b.c + a.w*b.w))/2
;;   = (a.c*b.c + a.c*b.w + a.w*b.c + a.w*b.w - a.c*b.c + a.c*b.w + a.w*b.c - a.w*b.w)/2
;;   = (2*a.c*b.w + 2*a.w*b.c)/2
;;   = a.c*b.w + b.c*a.w

;; The final width in multiplication depends on the center values as
;; well as the widths.  (Notice that I assumed that p1 and p2
;; represented the upper and lower bounds.  That might not necessarily
;; be true, but it it is sufficient to show in this case the result is
;; not solely dependent on the original widths.

;; -------------------------------------------------------------------
;; Width for division

;; Ok, I'm leaving this one as an exercise for the reader. :)
