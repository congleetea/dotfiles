;;; init-languages.el --- Set up programming languages
;;; Commentary:
;; Basic programming languages

;;; Code:

;; --------------------------------------------------------------------
;; generate the tag files
;; --------------------------------------------------------------------
(require 'gtags)
(use-package bpr :ensure t)

;; Bind some useful keys in the gtags select buffer that evil overrides.
(add-hook 'gtags-select-mode-hook
          (lambda ()
            (evil-define-key 'normal gtags-select-mode-map (kbd "RET") 'gtags-select-tag)
            (evil-define-key 'normal gtags-select-mode-map (kbd "q") 'kill-buffer-and-window)))

(defun gtags-reindex ()
  "Kick off gtags reindexing."
  (interactive)
  (let* ((root-path (expand-file-name (vc-git-root (buffer-file-name))))
         (gtags-filename (expand-file-name "GTAGS" root-path)))
    (if (file-exists-p gtags-filename)
      (gtags-index-update root-path)
      (gtags-index-initial root-path))))

(defun gtags-index-initial (path)
  "Generate initial GTAGS files for PATH."
  (let ((bpr-process-directory path))
    (bpr-spawn "gtags")))

(defun gtags-index-update (path)
  "Update GTAGS in PATH."
  (let ((bpr-process-directory path))
    (bpr-spawn "global -uv")))

;;--------------------------------------------------------------
;; electric-mode
;;--------------------------------------------------------------
(use-package electric
  :config
  (electric-indent-mode t)
  (electric-pair-mode t)
  (electric-layout-mode t))

;;--------------------------------------------------------------
;; sh-mode
;;--------------------------------------------------------------
(use-package sh-script
             :defer t
             :config (setq sh-basic-offset 4))

(use-package eldoc
             :diminish eldoc-mode
             :init  (setq eldoc-idle-delay 0.1))

(use-package cmake-mode
             :init (setq cmake-tab-width 4))

;;--------------------------------------------------------------
;; cc-mode
;;--------------------------------------------------------------


(use-package cc-mode
  :config
  (progn
    (setq tab-width 2)
    (setq-default indent-tabs-mode nil)
    (setq c-basic-offset 2))
  :init
  (add-hook 'c-mode-hook
            (lambda ()
              (set-fill-column 80)
              (turn-on-auto-fill)
              (flyspell-mode t)
              (visual-line-mode t)))
  (add-hook 'c++-mode-hook
            (lambda ()
              (set-fill-column 80)
              (turn-on-auto-fill)
              (flyspell-mode t)
              (visual-line-mode t)))
  )

(use-package google-c-style
  :init
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c++-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)
  (add-hook 'c++-mode-common-hook 'google-make-newline-indent)
)

(require 'company-c-headers)
(use-package company-c-headers
  :init
  (add-to-list 'company-backends 'company-c-headers)
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/7/"))

;;---------------------------------------------------------------
;; Protobuf
;;---------------------------------------------------------------
(use-package protobuf-mode
             :ensure t
             :defer t
             :mode "\\.proto\\'"
             :init
             (add-hook 'protobuf-mode-hook
                       (defconst my-protobuf-style
                         '((c-basic-offset . 2)
                           (indent-tabs-mode . nil)))
                       (lambda () (c-add-style "my-style" my-protobuf-style t)))
)

;;---------------------------------------------------------------
;; Erlang
;;---------------------------------------------------------------
(let* ((emacs-version "2.11.1")
       (tools-path
        (concat "/usr/local/lib/erlang/lib/tools-" emacs-version "/emacs")))
  (when (file-exists-p tools-path)
    (setq load-path (cons tools-path load-path))
    (setq erlang-root-dir "/usr/local/lib/erlang")
    (setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
    (require 'erlang-start)
    (defvar inferior-erlang-prompt-timeout t)))

;; get erlang man page
(defun get-erl-man ()
  (interactive)
  (let* ((man-path "/usr/local/lib/erlang/man")
         (man-args (format "-M %s %s" man-path (current-word))))
    (man man-args)))

(add-to-list 'auto-mode-alist '("rebar.config" . erlang-mode))
(add-to-list 'auto-mode-alist '("rebar.config.script" . erlang-mode))
(add-to-list 'auto-mode-alist '("app.config" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.src$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.erlang$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))


;;;----------------------------------------------------------------------------
;;; cmake
;;;----------------------------------------------------------------------------
(use-package cmake-mode
             :defer t)

;;;----------------------------------------------------------------------------
;;; lua
;;;----------------------------------------------------------------------------
(use-package lua-mode
             :ensure t
             :defer t
             :mode "\\.lua\\'"
             :init
             (add-hook 'lua-mode-hook
                       (lambda ()
                         (setq lua-indent-level 4)
                         (auto-complete-mode)
                         (hs-minor-mode)
                         (turn-on-font-lock)
                         )
                       )
             )

;;----------------------------------------------------------------------------
;; lisp: C-x C-e 执行光标下lisp
;;----------------------------------------------------------------------------
(use-package slime
             :defer t
             :config
             (progn
               (use-package ac-slime :ensure t)
               (setq tab-width 4)
               (setq inferior-lisp-program "sbcl")
               (slime-setup)
               (add-hook 'slime-mode-hook 'set-up-slime-ac)
               (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
               (add-hook 'slime-mode-hook
                         (lambda ()
                           (unless (slime-connected-p)
                             (save-excursion (slime)))))
               (slime-setup '(slime-fancy slime-asdf))
               (slime-setup '(slime-repl slime-fancy slime-banner))
               (setq slime-protocol-version 'ignore
                     slime-net-coding-system 'utf-8-unix
                     ;;slime-complete-symbol*-fancy t
                     slime-complete-symbol-function 'slime-fuzzy-complete-symbol))
             :ensure t)

(use-package color-identifiers-mode
             :ensure t
             :init
             (add-hook 'emacs-lisp-mode-hook 'color-identifiers-mode)
             :diminish color-identifiers-mode)

;; refer https://www.emacswiki.org/emacs/PareditCheatsheet
(use-package paredit
             :ensure t
             :init
             (add-hook 'emacs-lisp-mode-hook 'paredit-mode))

;;----------------------------------------------------------------------------
;; Golang
;; go get github.com/rogpeppe/godef
;; go get -u github.com/golang/lint/golint
;; go get -u github.com/nsf/gocode
;;----------------------------------------------------------------------------
(use-package company-go
             :ensure t
             :defer t
             :init
             (with-eval-after-load 'company
                                   (add-to-list 'company-backends 'company-go)))

(use-package go-eldoc
             :ensure t
             :defer
             :init
             (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package go-mode
 :config
 (bind-keys :map go-mode-map
  ("M-." . godef-jump)
  ("M-," . pop-tag-mark)
  )
 (add-hook 'go-mode-hook '(lambda () (setq tab-width 2)))
 (setq gofmt-command "goimports")
 (add-hook 'before-save-hook 'gofmt-before-save))

;;----------------------------------------------------------------------------
;; other programming languages
;;----------------------------------------------------------------------------
(use-package markdown-mode
             :defer t
             :config
             (progn
               (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
               (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
               (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))
             (add-hook 'markdown-mode-hook
                       (lambda ()
                         (set-fill-column 80)
                         (turn-on-auto-fill)
                         (flyspell-mode t)
                         (visual-line-mode t)))
             (setq markdown-command "pandoc --smart -f markdown -t html")
             ;(setq markdown-css-paths `(,(expand-file-name "markdown.css" vendor-dir)))
             )

(use-package yaml-mode
             :defer t
             :mode ("\\.yml$" . yaml-mode))

;;----------------------------------------------------------------------------
;; auto insert
;;----------------------------------------------------------------------------
;; https://github.com/alexott/emacs-configs/blob/master/rc/emacs-rc-auto-insert.el
(load "autoinsert")
(auto-insert-mode)
(setq auto-insert t)
(setq auto-insert-query t)
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-alist
      (append '(
                (("\\.py$" . "python template")
                 nil
                 "#!/usr/bin/env python\n"
                 "\n"
                 "import sys, os, math\n"
                 "# import numpy as np\n"
                 "# import scipy as sp\n"
                 "# import ROOT\n"
                 "# import pyfits as pf\n"
                 "\n"
                 _
                 )) auto-insert-alist))
(setq auto-insert-alist
      (append '(
                (("\\.sh$" . "shell script template")
                 nil
                 "#!/bin/bash\n"
                 "\n"
                 _
                 )) auto-insert-alist))

;;----------------------------------------------------------------------------
;; YCM
;;----------------------------------------------------------------------------
(use-package ycmd
  :ensure t
  :init (add-hook 'c++-mode-hook #'ycmd-mode)
  :config
  (set-variable 'ycmd-server-command '("/usr/bin/python" "/home/congleetea/gitlab/dotfiles/emacs.d/vendor/ycmd/ycmd"))
  (set-variable 'ycmd-global-config "/home/congleetea/gitlab/dotfiles/emacs.d/vendor/ycmd/.ycm_extra_conf.py"))

(use-package company-ycmd
  :ensure t
  :init (company-ycmd-setup)
  )

;; Show argument list in echo area
(use-package eldoc
  :diminish eldoc-mode
  :init (add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup))

;;(use-package flycheck-ycmd
;;  :commands (flycheck-ycmd-setup)
;;  :init (add-hook 'ycmd-mode-hook 'flycheck-ycmd-setup))

(provide 'init-languages)
;;; init-languages.el ends here
