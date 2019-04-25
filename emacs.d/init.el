;;; package --- summary
;;; Commentary:
;;; Code:

(require 'package)
(package-initialize)

;;; set custom variables
(setq default-directory "~/gitlab")
(setq user-full-name "Clare Lee")
(setq user-mail-address "congleetea@gmail.com")

;;; set system directory and load them.
(defvar vendor-dir (expand-file-name "vendor" user-emacs-directory))
(defvar backup-dir "~/.emacs.d/backups/")
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path vendor-dir)
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
(let ((files (directory-files-and-attributes "~/.emacs.d/lisp" t)))
  (dolist (file files)
    (let ((filename (car file))
          (dir (nth 1 file)))
      (when (and dir (not (string-suffix-p "." filename)))
        (add-to-list 'load-path (car file))))))
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))


;;; install packages
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("org" . "http://elpa.emacs-china.org/org/")))

;; use proxy if repository is not access.
;; (setq url-proxy-services '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;;                            ("http" . "127.0.0.1:8123")
;;                            ("https" . "127.0.0.1:8123")
;;                            ))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

(eval-when-compile (require 'use-package))

;;; Require my custom configs. 
(require 'init-bootstrap)
(require 'init-utils)
(require 'init-platform)
(require 'init-pkgs)
(require 'init-evil)
(require 'init-org)
(require 'init-languages)
(require 'init-maps)


(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-evil yasnippet yaml-mode which-key web-mode use-package uimage telephone-line systemd swiper rainbow-mode rainbow-delimiters racket-mode paredit org-page neotree multiple-cursors monokai-theme monitor markdown-mode magit lua-mode js2-mode hippie-exp-ext highlight-symbol helm-projectile helm-ag google-c-style go-eldoc git-gutter geiser flycheck evil-surround evil-leader evil-indent-textobject dockerfile-mode docker dired-k diminish company-go company-c-headers comment-dwim-2 color-identifiers-mode cmake-mode bpr avy anzu ansible ag ac-slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
