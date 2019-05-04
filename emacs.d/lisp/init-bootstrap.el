;;; init-bootstrap.el -- My bootstrap configuration.
;;; Commentary:
;;; Code:
;; Essential settings.

;; Use utf8
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(set-file-name-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-next-selection-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; start
(setq inhibit-splash-screen t
      initial-scratch-message nil
      inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      select-enable-clipboard t
      coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8
      )

(menu-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode 1)
(electric-indent-mode 1)
(global-auto-revert-mode t)
(unless (display-graphic-p)
  (setq-default linum-format "%d "))
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(require 'linum)
(global-linum-mode t)
(setq-default fill-column 80)

(setq backup-directory-alist (list (cons "." backup-dir)))
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-width-threshold 0)
(setq split-height-threshold nil)
(setq-default left-fringe-width nil)
(eval-after-load "vc" '(setq vc-handled-backends nil))
(defalias 'yes-or-no-p 'y-or-n-p)

; Set default font
(set-face-attribute 'default nil
                    ;; :family "Source Code Pro"
                    :family "Courier 10 Pitch"
                    :box '(:line-width 100)
                    :height 110
                    :weight 'normal
                    :width 'normal)

;; This makes my Emacs startup time ~35% faster.
(setq gc-cons-threshold 100000000)

;;; essential libs
(use-package s        :ensure t :defer t)
(use-package cl       :ensure t :defer t)
(use-package ht       :ensure t :defer t)
(use-package git      :ensure t :defer t)
(use-package dash     :ensure t :defer t)
(use-package mustache :ensure t :defer t)

(provide 'init-bootstrap)
