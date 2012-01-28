(cl:in-package :srfi-102.internal)

(def-suite srfi-102)

(in-suite srfi-102)

(test srfi-102
  (for-all ((n (gen-integer :min 0)))
    (is-true (procedure-arity-includes? #'cl:list n)))
  (for-all ((n (gen-integer :max -1)))
    (is-false (procedure-arity-includes? #'cl:list n)))
  (is-true (procedure-arity-includes? #'cl:cons 2))
  (is-false (procedure-arity-includes? #'cl:cons 1))
  (is-true (arity-at-least? (procedure-arity #'cl:list)))
  (is-false (arity-at-least? (procedure-arity #'cl:cons)))
  (signals (cl:type-error)
    (arity-at-least-value (procedure-arity #'cl:cons)))
  (is (zerop (arity-at-least-value (procedure-arity #'cl:list)))))

;;; eof
