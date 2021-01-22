;; load emacs 24's package system. Add MELPA repository.
(require 'package)
(package-initialize)
(add-to-list
 'package-archives
 ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
 '("melpa" . "http://melpa.milkbox.net/packages/")
 t)

(if window-system
  (progn
    (set-background-color "#ffffea")
    ;; (set-foreground-color "#ffe97a")
    ;; (set-foreground-color "grey")
    ;; (set-cursor-color "grey")
    (set-scroll-bar-mode 'right)
    (tool-bar-mode 0)
    (set-face-attribute 'default nil :font "Monaco 11")
    (setq frame-title-format
  	'("emacs - |"
  	  (:eval (if (buffer-file-name)
  		     (abbreviate-file-name (buffer-file-name))
  		   "%b"))
  	  "|"))
    (setq default-frame-alist '((height . 37) (width . 106))))
  (progn
    (menu-bar-mode 0)))

(column-number-mode 1)
(blink-cursor-mode 0)
(show-paren-mode 1)
;; eliminate long "yes" or "no" prompts
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)
;; auto-save
(setq auto-save-default nil)
;; (setq auto-save-file-name-transforms (quote (("." . "~/.emacs.d/autosaves"))))
;; (setq auto-save-interval 500)   ; 500 characters
;; (setq auto-save-timeout 300)    ; 300 seconds
;; Scroll just one line when hitting bottom of window
(setq scroll-conservatively 10000)
;; day && date && time
;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)
;; (display-time-mode 1)
;; auto-backup
(setq make-backup-files nil)
;; (setq backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
;; bookmarks
(setq bookmark-save-flag 1)
(setq bookmark-default-file "~/.emacs.d/emacs.bmk")
;; (defalias 'list-buffers 'ibuffer) ; make ibuffer default

(defun my-copy-upword (&optional num)
  (interactive "p")
  (let (s e)
    (save-excursion
      (previous-line)
      (setq s (point))
      (forward-word (or num 1))
      (setq e (point)))
    (insert-buffer-substring (current-buffer) s e)
    (setq this-command nil)))

(progn
  ;; define a prefix keymap
  (define-prefix-command 'my-xyz-a-map)
  (define-key my-xyz-a-map "e" 'my-copy-upword)
  (define-key my-xyz-a-map " " 'company-complete)
  (define-key my-xyz-a-map [tab] "\C-q\t")	; Control tab quotes a tab.
  (define-key my-xyz-a-map "\C-b" 'ibuffer))
(global-set-key [f12] my-xyz-a-map)

(global-set-key [f7] 'compile)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key (kbd "C-j") 'newline)
(global-set-key "\M- " 'set-mark-command)
(global-set-key "\C-@" 'just-one-space)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key [f1] 'help-command)

(defun my-c-mode-hook ()
  ;;(define-key c-mode-map "\C-m" 'reindent-then-newline-and-indent)
  ;; (set (make-local-variable 'compile-command)
  ;;      (concat "gcc -Wall -pipe -g " (buffer-name)))
  ;; (local-set-key [f7] 'compile)
  (c-set-style "linux"))

(add-hook 'c-mode-hook 'my-c-mode-hook)
;; (add-hook 'c-mode-common-hook
;; 	  (lambda ()
;; 	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;; 	      (ggtags-mode 1))))
;; (add-hook 'after-init-hook 'global-company-mode)

;;(global-company-mode 1)
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(delete-selection-mode nil)
;; '(package-selected-packages (quote (company))))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; )
