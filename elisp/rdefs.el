(defconst rdefs-buffer-name "*rdefs*")
(defconst rdefs-command "rdefs")
(define-minor-mode rdefs-mode
  "Toggle Rdefs mode"
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  :lighter " Rdefs"
  ;; The minor mode bindings.
  :keymap rdefs-mode-keymap
  :group 'rdefs)
(setq rdefs-mode-keymap (make-sparse-keymap))
(define-key rdefs-mode-keymap "q" '(lambda ()
				     (interactive)
				     (kill-buffer rdefs-buffer-name)))

;;; extract-ruby-defs with rdefs
(defun ruby-defs ()
  (interactive)
  (let ((obuf (current-buffer)))
    (setq buf (get-buffer-create rdefs-buffer-name))
    (set-buffer buf)
    (erase-buffer)
    (set-buffer obuf)
    (call-process-region
     (point-min)
     (point-max) rdefs-command nil buf)
    (switch-to-buffer-other-window buf)
    (toggle-read-only 1)
    (ruby-mode)
    (rdefs-mode)))

;;; ruby-mode key-bindings (extracted and modified from the original)
;;; Visit a ruby source code file and press Meta(ESC)-e, and you get
;;; the output from rdefs command.

(setq ruby-mode-map (make-sparse-keymap))
(define-key ruby-mode-map "\ee" 'ruby-defs)
(define-key ruby-mode-map "{" 'ruby-electric-brace)
(define-key ruby-mode-map "}" 'ruby-electric-brace)
(define-key ruby-mode-map "\e\C-a" 'ruby-beginning-of-defun)
(define-key ruby-mode-map "\e\C-e" 'ruby-end-of-defun)
(define-key ruby-mode-map "\e\C-b" 'ruby-backward-sexp)
(define-key ruby-mode-map "\e\C-f" 'ruby-forward-sexp)
(define-key ruby-mode-map "\e\C-p" 'ruby-beginning-of-block)
(define-key ruby-mode-map "\e\C-n" 'ruby-end-of-block)
(define-key ruby-mode-map "\e\C-h" 'ruby-mark-defun)
(define-key ruby-mode-map "\e\C-q" 'ruby-indent-exp)
(define-key ruby-mode-map "\t" 'ruby-indent-command)
(define-key ruby-mode-map "\C-c\C-e" 'ruby-insert-end)
(define-key ruby-mode-map "\C-j" 'ruby-reindent-then-newline-and-indent)
(define-key ruby-mode-map "\C-m" 'newline)
