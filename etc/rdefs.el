;; some code for emacs
;;
;; add this to your dot.emacs
;; (require 'rdefs)
;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (define-key ruby-mode-map (kbd "M-e") 'ruby-rdefs)))

(defconst rdefs-buffer-name "*rdefs*")
(defconst rdefs-command "rdefs")
(setq rdefs-mode-keymap (make-sparse-keymap))
(define-key rdefs-mode-keymap "q" '(lambda ()
				     (interactive)
				     (kill-buffer rdefs-buffer-name)))
(define-minor-mode rdefs-mode
  "Toggle Rdefs mode"
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  :lighter " Rdefs"
  ;; The minor mode bindings.
  :keymap rdefs-mode-keymap
  :group 'rdefs)

;;; extract-ruby-defs with rdefs
(defun ruby-defs ()
  (interactive)
  (let ((oldbuf (current-buffer)))
    (setq buf (get-buffer-create rdefs-buffer-name))
    (set-buffer buf)
    (erase-buffer)
    (set-buffer oldbuf)
    (call-process-region
     (point-min)
     (point-max) rdefs-command nil buf)
    (switch-to-buffer-other-window buf)
    (toggle-read-only 1)
    (ruby-mode)
    (rdefs-mode)))

(provide 'rdefs)
