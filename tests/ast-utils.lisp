;;; -*- mode: Lisp; Syntax: Common-Lisp; -*-
;;;
;;; Copyright (c) 2008 by the authors.
;;;
;;; See COPYING for details.

(in-package :cl-walker-test)

(defsuite* (test/utils :in test))

(deftest test-collect-variable-references (form expected-count)
  (let ((ast (walk-form form)))
    (is (= expected-count
           (length (collect-variable-references ast))))))

(deftest test/utils/collect-variable-references/1 ()
  (loop
     :for (form expected-count) :in
     '((var 1)
       ((fn var1 var2) 2)
       ((progn (+ var1 var2)) 2)
       ((flet ((fn (x)
                 (+ x a)))
          (+ var1 (fn var2)))
        4))
     :do (test-collect-variable-references form expected-count)))
