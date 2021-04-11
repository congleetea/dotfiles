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
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://elpa.emacs-china.org/org/")))

;; use proxy if repository is not access.
(setq url-proxy-services '(("no_proxy" . "^\\(localhost\\|10.*\\)")
                           ("http" . "127.0.0.1:2340")
                           ("https" . "127.0.0.1:2340")
                           ))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
;; (xterm-mouse-mode t)  ;; 鼠标
(eval-when-compile (require 'use-package))
  
;; evil-viaualstar: on string world, hit * to search that selection forward, or # to se    arch that selection backward.
;; (use-package evil-visualstar :config (global-evil-visualstar-mode t))
;; Require my custom configs. 
(require 'init-bootstrap)
(require 'init-utils)
(require 'init-platform)
(require 'init-pkgs)
(require 'init-evil)
(require 'init-languages)
(require 'init-org)
(require 'init-maps)


(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
