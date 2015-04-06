;;load_path を追加する関数を設定
(when (> emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d"))

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "public_repos" "elisp" "conf" "auto-install")

;; スタートアップ非表示
(setq inhibit-startup-screen t)
;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; init-loader
(require 'init-loader)
;; 設定ディレクトリ
(init-loader-load "~/.emacs.d/conf")
;; ログファイルを表示
(setq init-loader-show-log-after-init t)




;;auto-install
;;=====================================================================
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup) ; 互換性確保
;;キーバインド
;;auto-install
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))
;;=====================================================================


;;anything
;;(require 'anything)
(require 'anything-startup)
(global-set-key (kbd "C-x ;") 'anything)
;;C-x ; でanything起動

(global-set-key (kbd "C-x b") 'anything-for-files)
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "C-x M-x") 'anything-M-x)
(setq recentf-max-menu-items 10);; 表示するファイルの数
(setq recentf-max-saved-items 30);; 保存するファイルの数
(setq kill-ring-max 100)                ;; kill-ring で保存される最大値


;;ysnipet

;;(add-to-list 'load-path "~/.emacs.d/elisp/yasnippet")
(when (require 'yasnippet nil t)
 ;; (yas--initialize)
  ;;(yas/load-directory "~/.emacs.d/elisp/yasnippet/snippets")
  ;;(yas/load-directory "~/.emacs.d/elisp/yasnippet/extras/imported")
  (yas/global-mode 1)
  (setq yas-snippet-dirs'("~/.emacs.d/snippets" ;; 作成するスニペットはここに入る
        "~/.emacs.d/elisp/yasnippet/snippets" ;; 最初から入っていたスニペット(省略可能)
        ))
(yas-global-mode 1)
;; 単語展開キーバインド (ver8.0から明記しないと機能しない)
;; (setqだとtermなどで干渉問題ありでした)
;; もちろんTAB以外でもOK 例えば "C-;"とか
(custom-set-variables '(yas-trigger-key "TAB"))
;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
)

;;auto-install
(when (require 'auto-complete-config nil t )
  (ac-config-default)
  (setq ac-auto-start 1)
  (setq ac-dwim t)
  (setq ac-use-menu-map t) 
;;C-n/C-pで候補選択可能 
  (add-to-list 'ac-sources 'ac-source-yasnippet)
;;常にYASnippetを補完候補にxb
  (setq ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/ac-dict") 
;; 辞書ファイルのディレクトリ
  (setq ac-comphist-file "~/.emacs.d/elisp/auto-complete/ac-comphist.dat") 
;; 補完履歴のキャッシュ先
)


(setq-default truncate-partial-width-windows t)
(setq-default truncate-lines t)


(autoload 'coffee-mode "coffee-mode" "Major mode for editing CoffeeScript." t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
;; See more at: http://yohshiy.blog.fc2.com/blog-entry-165.html#sthash.6CAcWg5o.dpuf
