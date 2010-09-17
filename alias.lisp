(in-package :uncl)

(defparameter aliases
  '((call funcall)
    (mlet macrolet)
    (sort! cl:sort)
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
    (remove! delete)
    (remove-duplicates delete-duplicates)
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
    (t (error "Cannot set an alias ~a for ~a" to from))))

;; functions
(dolist (alias aliases)
  (apply #'defalias alias))

(defun require (module-name &optional pathname-list)
  (disable-uncl-syntax)
  (cl:require module-name pathname-list)
  (enable-uncl-syntax))
