(in-package :uncl)

(let ((r (copy-readtable nil)))
  (defun read-symbol (stream)
    (let ((*readtable* r))
      (set-macro-character #\] (get-macro-character #\)))
      (set-macro-character #\} (get-macro-character #\)))
      (read-preserving-whitespace stream))))

(defun double-dot-symbol (symbol)
  (cl-ppcre:register-groups-bind (st en)
      ("^(.+?)\\.\\.(.+?)$" (symbol-name symbol))
    `(range ,@(mapcar #'(lambda (s)
                          (or (parse-integer s :junk-allowed t)
                              (intern s)))
                      (list st en)))))

(defun symbol-reader-macro-reader (stream char)
  (unread-char char stream)
  (let ((s (read-symbol stream)))
    (acond2
     (not (symbolp s)) s
     (get s 'symbol-reader-macro) (funcall it stream s)
     (double-dot-symbol s) it
     t s)))

(defun set-macro-symbol (symbol readfn)
  (setf (get symbol 'symbol-reader-macro) readfn)
  t)

(defmacro define-macro-symbol (from to)
  `(set-macro-symbol ',from
                     #'(lambda (stream symbol)
                         (declare (ignore stream symbol))
                         ',to)))

(defparameter aliases
  '((def defvar)
    (call funcall)
    (mlet macrolet)
    (sort! sort)
    (mapcan! mapcan)
    (append! nconc)
    (revappend! nreconc)
    (butlast! nbutlast)
    (set-difference! nset-difference)
    (set-exclusive-or! nset-exclusive-or)
    (string-capitalize! nstring-capitalize)
    (string-downcase! nstring-downcase)
    (string-upcase! nstring-upcase)
    (sublis! nsublis)
    (subst! nsubst)
    (subst!-if nsubst-if)
    (substitute nsubstitute)
    (substitute!-if nsubstitute-if)
    (reverse! nreverse)
    (filter remove-if-not)
    (rotate! rotatef)
    (setcar! rplaca)
    (setcdr! rplacd)
    (shift! shiftf)
    (set! setf)
    (pset! psetf)
    (rem! remf)
    (inc! incf)
    (dec! decf)
    (push! push)
    (pop! pop)
    (vector-push! vector-push)
    (vector-pop! vector-pop)
    (y-or-n? y-or-n-p)
    (yes-or-no? yes-or-no-p)
    (adjustable-array? adjustable-array-p)
    (alpha-char? alpha-char-p)
    (alphanumeric? alphanumericp)
    (array-has-fill-pointer? array-has-fill-pointer-p)
    (array-in-bounds? array-in-bounds-p)
    (array? arrayp)
    (bit-vector? bit-vector-p)
    (both-case? both-case-p)
    (bound? boundp)
    (char-greater? char-greaterp)
    (char-less? char-lessp)
    (character? characterp)
    (compiled-function? compiled-function-p)
    (complex? complexp)
    (cons? consp)
    (constant? constantp)
    (digit-char? digit-char-p)
    (end? endp)
    (even? evenp)
    (fbound? fboundp)
    (float? floatp)
    (function? functionp)
    (graphic-char? graphic-char-p)
    (hash-table? hash-table-p)
    (input-stream? input-stream-p)
    (integer? integerp)
    (interactive-stream? interactive-stream-p)
    (keyword? keywordp)
    (list? listp)
    (logbit? logbitp)
    (lower-case? lower-case-p)
    (minus? minusp)
    (null? null)
    (odd? oddp)
    (open-stream? open-stream-p)
    (output-stream? output-stream-p)
    (package? packagep)
    (pathname-match? pathname-match-p)
    (pathname? pathnamep)
    (plus? plusp)
    (random-state? random-state-p)
    (rational? rationalp)
    (readtable? readtablep)
    (real? realp)
    (simple-bit-vector? simple-bit-vector-p)
    (simple-string? simple-string-p)
    (simple-vector? simple-vector-p)
    (slot-bound? slot-boundp)
    (slot-exists? slot-exists-p)
    (special-operator? special-operator-p)
    (standard-char? standard-char-p)
    (stream? streamp)
    (string-greater? string-greaterp)
    (string-less? string-lessp)
    (string? stringp)
    (subset? subsetp)
    (subtype? subtypep)
    (symbol? symbolp)
    (tail? tailp)
    (type? typep)
    (upper-case? upper-case-p)
    (vector? vectorp)
    (wild-pathname? wild-pathname-p)
    (zero? zerop)
    ))

(defun defalias (to from)
  (cond
    ((macro-function from)
     (setf (macro-function to) (macro-function from)))
    ((symbol-function from)
     (setf (symbol-function to) (symbol-function from)))
    (t (define-macro-symbol from to))))

(defun init-readtable ()
  (map nil (lambda (c)
             (set-macro-character c #'symbol-reader-macro-reader t))
       "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@$%^&_=+-*/|:<>.?0123456789")

  ;; special forms
  (define-macro-symbol if aif)
  (define-macro-symbol cond acond2)
  (define-macro-symbol fn lambda)
  (define-macro-symbol let let2)
  (define-macro-symbol let* let2*)
  (define-macro-symbol sort sort*)
  (define-macro-symbol string string*)

  ;; functions
  (dolist (alias aliases)
    (apply #'defalias alias))

  (enable-escape-sequence))
