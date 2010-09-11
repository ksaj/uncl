(in-package :cl-user)

(sb-ext:unlock-package :cl)

(defpackage uncl
  (:nicknames :ucl)
  (:use :cl :cl-ppcre :cl-interpol :cl-utilities :named-readtables)
  (:import-from :named-readtables
                :defreadtable
                :in-readtable)
  (:import-from :cl-interpol
                :*stream*
                :*start-char*
                :*term-char*
                :*pair-level*
                :*inner-delimiters*
                :*saw-backslash*
                :*readtable-copy*
                :inner-reader
                :read-char*
                :*previous-readtables*)
  (:export :afn
           :dfn
           :alet

           ;; for debug
           :print-form-and-results

           ;; from CL-UTILITIES
           :with-gensyms
           :once-only
           :compose

           ;; from COMMON-LISP
           :*
           :+
           :-
           :/
           :/=
           :1+
           :1-
           :<
           :<=
           :=
           :>
           :>=
           :abort
           :abs
           :acos
           :acosh
           :add-method
           :adjoin
           :adjust-array
           :adjustable-array?
           :allocate-instance
           :alpha-char?
           :alphanumeric?
           :and
           :append
           :append!
           :apply
           :apropos
           :apropos-list
           :aref
           :arithmetic-error-operands
           :arithmetic-error-operation
           :array-dimension
           :array-dimensions
           :array-displacement
           :array-element-type
           :array-has-fill-pointer?
           :array-in-bounds?
           :array-rank
           :array-row-major-index
           :array-total-size
           :array?
           :ash
           :asin
           :asinh
           :assert
           :assoc
           :assoc-if
           :atan
           :atanh
           :atom
           :bit
           :bit-and
           :bit-andc1
           :bit-andc2
           :bit-eqv
           :bit-ior
           :bit-nand
           :bit-nor
           :bit-not
           :bit-orc1
           :bit-orc2
           :bit-vector?
           :bit-xor
           :block
           :boole
           :both-case?
           :bound?
           :break
           :broadcast-stream-streams
           :butlast
           :butlast!
           :byte
           :byte-position
           :byte-size
           :caaaar
           :caaadr
           :caaar
           :caadar
           :caaddr
           :caadr
           :caar
           :cadaar
           :cadadr
           :cadar
           :caddar
           :cadddr
           :caddr
           :cadr
           :call-method
           :car
           :case
           :catch
           :ccase
           :cdaaar
           :cdaadr
           :cdaar
           :cdadar
           :cdaddr
           :cdadr
           :cdar
           :cddaar
           :cddadr
           :cddar
           :cdddar
           :cddddr
           :cdddr
           :cddr
           :cdr
           :ceiling
           :cell-error-name
           :cerror
           :change-class
           :char
           :char-code
           :char-downcase
           :char-equal
           :char-greater?
           :char-int
           :char-less?
           :char-name
           :char-upcase
           :char/=
           :char<
           :char<=
           :char=
           :char>
           :char>=
           :character
           :character?
           :check-type
           :cis
           :class-name
           :class-of
           :clear-input
           :clear-output
           :close
           :clrhash
           :code-char
           :coerce
           :compile
           :compile-file
           :compile-file-pathname
           :compiled-function?
           :compiler-macro-function
           :complement
           :complex
           :complex?
           :compute-applicable-methods
           :compute-restarts
           :concatenate
           :concatenated-stream-streams
           :cond
           :conjugate
           :cons
           :cons?
           :constantly
           :constant?
           :continue
           :copy-alist
           :copy-list
           :copy-pprint-dispatch
           :copy-readtable
           :copy-seq
           :copy-structure
           :copy-symbol
           :copy-tree
           :cos
           :cosh
           :count
           :count-if
           :ctypecase
           :dec!
           :declaim
           :decode-float
           :decode-universal-time
           :defclass
           :defconstant
           :defgeneric
           :define-compiler-macro
           :define-condition
           :define-method-combination
           :define-modify-macro
           :define-setf-expander
           :define-symbol-macro
           :defmacro
           :defmacro*
           :defmethod
           :defpackage
           :defparameter
           :defsetf
           :defstruct
           :deftype
           :defun
           :def
           :delete-file
           :delete-if
           :delete-package
           :denominator
           :deposit-field
           :describe
           :describe-object
           :digit-char
           :digit-char?
           :directory
           :directory-namestring
           :disassemble
           :do
           :do*
           :do-all-symbols
           :do-external-symbols
           :do-symbols
           :documentation
           :dolist
           :dotimes
           :dpb
           :dribble
           :ecase
           :echo-stream-input-stream
           :echo-stream-output-stream
           :ed
           :eighth
           :elt
           :encode-universal-time
           :end?
           :enough-namestring
           :ensure-directories-exist
           :ensure-generic-function
           :eq
           :eql
           :equal
           :equalp
           :error
           :etypecase
           :eval
           :eval-when
           :even?
           :every
           :exp
           :export
           :expt
           :fbound?
           :fceiling
           :fdefinition
           :ffloor
           :fifth
           :file-author
           :file-error-pathname
           :file-length
           :file-namestring
           :file-position
           :file-string-length
           :file-write-date
           :fill
           :fill-pointer
           :find
           :find-all-symbols
           :find-class
           :find-if
           :find-method
           :find-package
           :find-restart
           :find-symbol
           :finish-output
           :first
           :flet
           :float
           :float-digits
           :float-precision
           :float-radix
           :float-sign
           :float?
           :floor
           :fmakunbound
           :force-output
           :format
           :formatter
           :fourth
           :fresh-line
           :fround
           :ftruncate
           :call
           :function
           :function-keywords
           :function-lambda-expression
           :function?
           :gcd
           :gensym
           :gentemp
           :get
           :get-decoded-time
           :get-dispatch-macro-character
           :get-internal-real-time
           :get-internal-run-time
           :get-macro-character
           :get-output-stream-string
           :get-properties
           :get-setf-expansion
           :get-universal-time
           :getf
           :gethash
           :go
           :graphic-char?
           :handler-bind
           :handler-case
           :hash-table-count
           :hash-table?
           :hash-table-rehash-size
           :hash-table-rehash-threshold
           :hash-table-size
           :hash-table-test
           :host-namestring
           :identity
           :if
           :ignore-errors
           :imagpart
           :import
           :in-package
           :inc!
           :initialize-instance
           :input-stream?
           :inspect
           :integer-decode-float
           :integer-length
           :integer?
           :interactive-stream?
           :intern
           :intersection
           :invalid-method-error
           :invoke-debugger
           :invoke-restart
           :invoke-restart-interactively
           :isqrt
           :keyword?
           :label
           :labels
           :lambda
           :fn
           :last
           :lcm
           :ldb
           :ldb-test
           :ldiff
           :length
           :let
           :let*
           :lisp-implementation-type
           :lisp-implementation-version
           :list
           :list*
           :list-all-packages
           :list-length
           :listen
           :list?
           :load
           :load-logical-pathname-translations
           :load-time-value
           :locally
           :log
           :logand
           :logandc1
           :logandc2
           :logbit?
           :logcount
           :logeqv
           :logical-pathname
           :logical-pathname-translations
           :logior
           :lognand
           :lognor
           :lognot
           :logorc1
           :logorc2
           :logtest
           :logxor
           :long-site-name
           :loop
           :loop-finish
           :lower-case?
           :machine-instance
           :machine-type
           :machine-version
           :macro-function
           :mexpand-all
           :mexpand
           :mlet
           :make-array
           :make-broadcast-stream
           :make-concatenated-stream
           :make-condition
           :make-dispatch-macro-character
           :make-echo-stream
           :make-hash-table
           :make-instance
           :make-instances-obsolete
           :make-list
           :make-load-form
           :make-load-form-saving-slots
           :make-package
           :make-pathname
           :make-random-state
           :make-sequence
           :make-string
           :make-string-input-stream
           :make-string-output-stream
           :make-symbol
           :make-synonym-stream
           :make-two-way-stream
           :makunbound
           :map
           :map-into
           :mapc
           :mapcan
           :mapcan!
           :mapcar
           :mapcon
           :maphash
           :mapl
           :maplist
           :mask-field
           :max
           :member
           :member-if
           :merge
           :merge-pathnames
           :method-combination-error
           :method-qualifiers
           :min
           :minus?
           :mismatch
           :mod
           :muffle-warning
           :multiple-value-bind
           :multiple-value-call
           :multiple-value-list
           :multiple-value-prog1
           :multiple-value-setq
           :name-char
           :namestring
           :nintersection
           :ninth
           :no-applicable-method
           :no-next-method
           :not
           :nth
           :nth-value
           :nthcdr
           :null?
           :number?
           :numerator
           :nunion
           :odd?
           :open
           :open-stream?
           :or
           :output-stream?
           :package-error-package
           :package-name
           :package-nicknames
           :package-shadowing-symbols
           :package-use-list
           :package-used-by-list
           :package?
           :pairlis
           :parse-integer
           :parse-namestring
           :pathname
           :pathname-device
           :pathname-directory
           :pathname-host
           :pathname-match?
           :pathname-name
           :pathname-type
           :pathname-version
           :pathname?
           :peek-char
           :phase
           :plus?
           :pop!
           :position
           :position-if
           :pprint
           :pprint-dispatch
           :pprint-exit-if-list-exhausted
           :pprint-fill
           :pprint-indent
           :pprint-linear
           :pprint-logical-block
           :pprint-newline
           :pprint-pop
           :pprint-tab
           :pprint-tabular
           :prin1
           :prin1-to-string
           :princ
           :princ-to-string
           :print
           :print-not-readable-object
           :print-object
           :print-unreadable-object
           :probe-file
           :proclaim
           :prog
           :prog*
           :prog1
           :progn
           :progv
           :provide
           :pset!
           :psetq
           :push!
           :pushnew
           :quote
           :random
           :random-state?
           :rassoc
           :rassoc-if
           :rational
           :rationalize
           :rational?
           :read
           :read-byte
           :read-char
           :read-char-no-hang
           :read-delimited-list
           :read-from-string
           :read-line
           :read-preserving-whitespace
           :read-sequence
           :readtable-case
           :readtable?
           :real?
           :realpart
           :reduce
           :reinitialize-instance
           :rem
           :rem!
           :remhash
           :remove
           :remove!
           :remove-duplicates
           :remove-duplicates!
           :remove-if
           :remove-method
           :remprop
           :rename-file
           :rename-package
           :replace
           :require
           :rest
           :restart-bind
           :restart-case
           :restart-name
           :return
           :return-from
           :revappend
           :revappend!
           :reverse
           :reverse!
           :room
           :rotate!
           :round
           :row-major-aref
           :setcar!
           :setcdr!
           :sbit
           :scale-float
           :schar
           :search
           :second
           :set
           :set-difference
           :set-difference!
           :set-dispatch-macro-character
           :set-exclusive-or
           :set-exclusive-or!
           :set-macro-character
           :set-pprint-dispatch
           :set-syntax-from-char
           :set!
           :setq
           :seventh
           :shadow
           :shadowing-import
           :shared-initialize
           :shift!
           :short-site-name
           :signal
           :signum
           :simple-bit-vector?
           :simple-condition-format-arguments
           :simple-condition-format-control
           :simple-string?
           :simple-vector?
           :sin
           :sinh
           :sixth
           :sleep
           :slot-bound?
           :slot-exists?
           :slot-makunbound
           :slot-missing
           :slot-unbound
           :slot-value
           :software-type
           :software-version
           :some
           :sort
           :sort!
           :special-operator?
           :sqrt
           :stable-sort
           :standard-char?
           :step
           :store-value
           :stream-element-type
           :stream-error-stream
           :stream-external-format
           :stream?
           :string
           :string-capitalize
           :string-capitalize!
           :string-downcase
           :string-downcase!
           :string-equal
           :string-greater?
           :string-left-trim
           :string-less?
           :string-right-trim
           :string-trim
           :string-upcase
           :string-upcase!
           :string/=
           :string<
           :string<=
           :string=
           :string>
           :string>=
           :string?
           :sublis
           :sublis!
           :subseq
           :subset?
           :subst
           :subst!
           :subst-if
           :subst!-if
           :substitute
           :substitute!
           :substitute-if
           :substitute!-if
           :subtype?
           :svref
           :sxhash
           :symbol-function
           :symbol-macrolet
           :symbol-name
           :symbol-package
           :symbol-plist
           :symbol-value
           :symbol?
           :synonym-stream-symbol
           :tagbody
           :tail?
           :tan
           :tanh
           :tenth
           :terpri
           :the
           :third
           :throw
           :time
           :trace
           :translate-logical-pathname
           :translate-pathname
           :tree-equal
           :truename
           :truncate
           :two-way-stream-input-stream
           :two-way-stream-output-stream
           :type-error-datum
           :type-error-expected-type
           :type-of
           :typecase
           :type?
           :unbound-slot-instance
           :unexport
           :unintern
           :union
           :unless
           :unread-char
           :untrace
           :unuse-package
           :unwind-protect
           :update-instance-for-different-class
           :update-instance-for-redefined-class
           :upgraded-array-element-type
           :upgraded-complex-part-type
           :upper-case?
           :use-package
           :use-value
           :user-homedir-pathname
           :values
           :values-list
           :vector
           :vector-pop!
           :vector-push!
           :vector-push-extend
           :vector?
           :warn
           :when
           :wild-pathname?
           :with-accessors
           :with-compilation-unit
           :with-condition-restarts
           :with-hash-table-iterator
           :with-input-from-string
           :with-open-file
           :with-open-stream
           :with-output-to-string
           :with-package-iterator
           :with-simple-restart
           :with-slots
           :with-standard-io-syntax
           :write
           :write-byte
           :write-char
           :write-line
           :write-sequence
           :write-string
           :write-to-string
           :y-or-n?
           :yes-or-no?
           :zero?

           ;; COMMON-LISP varialbes
           :*break-on-signals*
           :*compile-file-pathname*
           :*compile-file-truename*
           :*compile-print*
           :*compile-verbose*
           :*debug-io*
           :*debugger-hook*
           :*default-pathname-defaults*
           :*error-output*
           :*features*
           :*gensym-counter*
           :*load-pathname*
           :*load-print*
           :*load-truename*
           :*load-verbose*
           :*macroexpand-hook*
           :*modules*
           :*package*
           :*print-array*
           :*print-base*
           :*print-case*
           :*print-circle*
           :*print-escape*
           :*print-gensym*
           :*print-length*
           :*print-level*
           :*print-lines*
           :*print-miser-width*
           :*print-pprint-dispatch*
           :*print-pretty*
           :*print-radix*
           :*print-readably*
           :*print-right-margin*
           :*query-io*
           :*random-state*
           :*read-base*
           :*read-default-float-format*
           :*read-eval*
           :*read-suppress*
           :*readtable*
           :*standard-input*
           :*standard-output*
           :*terminal-io*
           :*trace-output*
           :array-dimension-limit
           :array-rank-limit
           :array-total-size-limit
           :boole-1
           :boole-2
           :boole-and
           :boole-andc1
           :boole-andc2
           :boole-c1
           :boole-c2
           :boole-clr
           :boole-eqv
           :boole-ior
           :boole-nand
           :boole-nor
           :boole-orc1
           :boole-orc2
           :boole-set
           :boole-xor
           :call-arguments-limit
           :char-code-limit
           :double-float-epsilon
           :double-float-negative-epsilon
           :internal-time-units-per-second
           :lambda-list-keywords
           :lambda-parameters-limit
           :least-negative-double-float
           :least-negative-long-float
           :least-negative-normalized-double-float
           :least-negative-normalized-long-float
           :least-negative-normalized-short-float
           :least-negative-normalized-single-float
           :least-negative-short-float
           :least-negative-single-float
           :least-positive-double-float
           :least-positive-long-float
           :least-positive-normalized-double-float
           :least-positive-normalized-long-float
           :least-positive-normalized-short-float
           :least-positive-normalized-single-float
           :least-positive-short-float
           :least-positive-single-float
           :long-float-epsilon
           :long-float-negative-epsilon
           :most-negative-double-float
           :most-negative-fixnum
           :most-negative-long-float
           :most-negative-short-float
           :most-negative-single-float
           :most-positive-double-float
           :most-positive-fixnum
           :most-positive-long-float
           :most-positive-short-float
           :most-positive-single-float
           :multiple-values-limit
           :nil
           :pi
           :short-float-epsilon
           :short-float-negative-epsilon
           :single-float-epsilon
           :single-float-negative-epsilon
           :t
           :*argv*

           ;; named-readtable
           :in-readtable
           :syntax
           :enable-uncl-syntax
           :disable-uncl-syntax
           :require

           ;; contrib
           :flatten
           :group
           :filter
           :range
           ))

(defpackage uncl-user
  (:use :uncl))

(setf *print-case* :downcase)
(defvar uncl:*argv* sb-ext:*posix-argv*)
