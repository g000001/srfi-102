;;;; package.lisp

(cl:in-package cl-user)


(defpackage "https://github.com/g000001/srfi-102"
  (:use)
  (:export procedure-arity
           arity-at-least?
           arity-at-least
           arity-at-least-value
           procedure-arity-includes?))


(defpackage "https://github.com/g000001/srfi-102#internals"
  (:use "https://github.com/g000001/srfi-102"
        cl 
        fiveam))


;;; *EOF*
