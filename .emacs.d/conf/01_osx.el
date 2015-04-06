;;Mac のみに読み込ませる
(when (eq system-type 'darwin)
  ;;macのemacsでファイル名扱うための設定
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs)
)
