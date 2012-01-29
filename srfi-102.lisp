;;;; srfi-102.lisp

(cl:in-package :srfi-102.internal)

(defstruct (arity-at-least
            (:predicate arity-at-least?)
            (:conc-name ""))
  arity-at-least-value)

(defmethod print-object ((obj arity-at-least) stream)
  (print-unreadable-object (obj stream :type T)
    (princ (arity-at-least-value obj) stream)))

(defun procedure-arity (proc)
  (let ((args (#+sbcl sb-introspect:function-lambda-list
               #+LispWorks lw:function-lambda-list
               #-(:or sbcl LispWorks) not-implemented
               proc)))
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

;;; eof
