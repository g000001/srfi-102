;;;; srfi-102.asd

(cl:in-package :asdf)


(defsystem :srfi-102
  :version "20200315"
  :description "SRFI 102 for CL: Procedure Arity Inspection"
  :long-description "SRFI 102 for CL: Procedure Arity Inspection
https://srfi.schemers.org/srfi-102"
  :author "CHIBA Masaomi"
  :maintainer "CHIBA Masaomi"
  :serial t
  :depends-on (:fiveam #+sbcl sb-introspect)
  :components ((:file "package")
               (:file "srfi-102")
               (:file "test")))


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-102))))
  (let ((name "https://github.com/g000001/srfi-102")
        (nickname :srfi-102))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-102))))
  (let ((*package*
         (find-package
          "https://github.com/g000001/srfi-102#internals")))
    (eval
     (read-from-string
      "
      (or (let ((result (run 'srfi-102)))
            (explain! result)
            (results-status result))
          (error \"test-op failed\") )"))))


;;; *EOF*
