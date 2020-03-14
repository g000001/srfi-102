;;;; srfi-102.lisp

(cl:in-package "https://github.com/g000001/srfi-102#internals")


(defstruct (arity-at-least
            (:predicate arity-at-least?)
            (:conc-name ""))
  (arity-at-least-value 0 :read-only T))


(defmethod print-object ((obj arity-at-least) stream)
  (print-unreadable-object (obj stream :type T)
    (princ (arity-at-least-value obj) stream)))


(defun function-lambda-list (proc)
  (#+sbcl sb-introspect:function-lambda-list
   #+LispWorks lw:function-lambda-list
   #-(:or sbcl LispWorks) |not-implemented: function-lambda-list|
   proc))


(defun procedure-arity (proc)
  (let ((args (function-lambda-list proc)))
    (etypecase args
      (null 0)
      (cons
       (let ((pos (position-if (lambda (x)
                                 (member x lambda-list-keywords) )
                               args )))
         (if pos
             (make-arity-at-least :arity-at-least-value pos)
             (length args) ))))))


(defun procedure-arity-includes? (proc k)
  (let ((arity (procedure-arity proc)))
    (etypecase arity
      (integer (= arity k))
      (arity-at-least (<= (arity-at-least-value arity) k)))))


;;; *EOF*
