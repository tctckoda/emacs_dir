
(add-hook 'php-mode-hook
	  (lambda ()
	    ;; imenu をメニューバーに追加
	    (imenu-add-to-menubar "Imenu")
 	    ;;(when (require 'flymake-php)
 	    ;;(add-hook 'php-mode-hook 'flymake-php-load))
 	    ;; (eval-after-load 'flymake
 	    ;;   '(progn
 	    ;; 	 (set-face-background 'flymake-errline "red")
 	    ;; 	 (set-face-background 'flymake-warnline "blue")
 	    ;; 	 ))
 	    (require 'php-completion)
 	    (php-completion-mode t)
 	    (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
	    (when (require 'auto-complete nil t)
	      (make-variable-buffer-local 'ac-sources)
 	      (add-to-list 'ac-sources 'ac-source-php-completion)
 	      (auto-complete-mode t)	      )
	    (c-set-offset 'case-label' 4)
	    (c-set-offset 'arglist-intro' 4)
	    (c-set-offset 'arglist-cont-nonempty' 4)
	    (c-set-offset 'arglist-close' 0)
 	    )
	  )

 (add-hook 'php-mode-user-hook
	   '(lambda ()
	      (setq tab-width 4)
	      (setq c-basic-offset 4)
	      (setq indent-tabs-mode nil)))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode)) ;*.phpのファイルのときにphp-modeを自動起動する
