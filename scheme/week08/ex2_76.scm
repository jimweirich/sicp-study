;; SICP 2.76

;; Exercise 2.76.  As a large system with generic operations evolves,
;; new types of data objects or new operations may be needed. For each
;; of the three strategies -- generic operations with explicit
;; dispatch, data-directed style, and message-passing-style --
;; describe the changes that must be made to a system in order to add
;; new types or new operations. Which organization would be most
;; appropriate for a system in which new types must often be added?
;; Which would be most appropriate for a system in which new
;; operations must often be added?

;; ANSWER ------------------------------------------------------------

;; When the major changes involve adding new data types, organizing
;; with the operations defined per data type makes a lot sense.  If
;; the operations are likely to change, then the opposite organization
;; with methods associated with operations makes sense as well.
