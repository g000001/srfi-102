;;;; srfi-102.asd

(cl:in-package :asdf)

(defsystem :srfi-102
  :serial t
  :depends-on (:fiveam)
  :components ((:file "package")
               (:file "srfi-102")
               (:file "test")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-102))))
  (load-system :srfi-102)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-102.internal :srfi-102))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))
