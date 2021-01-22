;; C:\Users\taowenbing\AppData\Roaming\.emacs.d\init.el
;; (setenv "HOME" "f:/tools/editor/emacs")
;; (load-file "~/.emacs.d/init_w.el")

;; For my language code setting (UTF-8)
;; (setq current-language-environment "UTF-8")
;; (setq default-input-method "chinese-py")
;; (setq locale-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;(prefer-coding-system 'utf-8-dos)

;; Setting English Font
(set-face-attribute 'default nil :font "Monaco 10")

;; Chinese Font
(defun zh-font-setting ()
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
		      charset
		      ;;(font-spec :family "Microsoft Yahei" :size 12)))
		      (font-spec :family "Microsoft Yahei"))))

(if (and (fboundp 'daemonp) (daemonp)) 
    (add-hook 'after-make-frame-functions
	      (lambda (new-frame)
		(with-selected-frame new-frame
				   (zh-font-setting))))
  (zh-font-setting))

(load-file "~/.emacs.d/init_u.el")
