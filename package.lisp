;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :srfi-102
  (:use)
  (:export :procedure-arity
           :arity-at-least?
           :arity-at-least
           :arity-at-least-value
           :procedure-arity-includes?))

(defpackage :srfi-102.internal
  (:use :srfi-102 :cl :fiveam))
