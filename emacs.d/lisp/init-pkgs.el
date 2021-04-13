;;; init-packages.el
;;; Commentary:
;;; Code:

(use-package diminish
  :ensure t)

;;; Emacs package that displays available keybindings in popup
(use-package which-key
  :ensure t
  :defer 10
  :config
  (progn
    ;; (which-key-setup-side-window-right)
    (which-key-mode 1)
    (which-key-setup-side-window-bottom)
    ))

;; (use-package helm-descbinds
;;   :ensure t
;;   :init (helm-descbinds-mode 1))

(use-package json-reformat
  :ensure t
  :defer 5
  :bind (("C-x i" . json-reformat-region)))

(use-package dired-k
  :ensure t
  :config
  (progn
    (add-hook 'dired-initial-position-hook 'dired-k)))

(use-package neotree
  :ensure t
  :bind ("C-c t" . neotree-toggle))

(use-package rainbow-mode
  :ensure t
  :defer t
  :commands rainbow-mode)

(use-package rainbow-delimiters
  :defer t
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package anzu
  :ensure    anzu
  :defer t
  :config (global-anzu-mode t)
  :diminish  anzu-mode)

;;  Emacs isearch with an overview. Oh, man!
;; https://github.com/abo-abo/swiper
(use-package swiper
  :ensure t)

;; I strongly dislike systemd...
;; but this mode is pretty handy when you need it.
(use-package systemd
  :defer t
  :ensure t)

(use-package comment-dwim-2
  :defer t
  :ensure t
  :bind ("M-;" . comment-dwim-2))

(use-package avy
  :ensure t
  :init
  :defer t
  :bind ("C-c SPC" . avy-goto-char))

(use-package multiple-cursors
             :ensure t
             :bind (("C-c n" . mc/mark-next-like-this)
                    ("C-c l" . mc/edit-lines)
                    ("C-c *" . mc/mark-all-like-this)
                    ("C-c r" . set-rectangular-region-anchor)
                    ("C-c e" . mc/edit-ends-of-lines)
                    ("C-c a" . mc/edit-beginnings-of-lines)))
 
(use-package hl-line
  :ensure t
  :init (add-hook 'prog-mode-hook 'hl-line-mode))

(use-package helm
  :ensure t
  :defer t
  :bind
  ("C-x C-f" . helm-find-files)
  ("C-x b" . helm-mini)
  ("C-h i" . helm-info-emacs)
  :commands helm-mode
  :init (progn
          ;; for os-x add the line
          (setq helm-man-format-switches "%s")
          (require 'helm-config)
          )
  :config (progn
            (setq helm-move-to-line-cycle-in-source nil
                  helm-candidate-number-limit 30
                  helm-M-x-requires-pattern 0
                  helm-google-suggest-use-curl-p t
             )
            (helm-autoresize-mode 1)
            (define-key helm-map (kbd "C-j") 'helm-next-line)
            (define-key helm-map (kbd "C-k") 'helm-previous-line)
            ))

(use-package hideshow
  :ensure t
  :bind (("C-c TAB" . hs-toggle-hiding)
         ("M--" . hs-hide-all)
         ("M-+" . hs-show-all)
         )
  :init (progn
          (defun my/enable-hs-minor-mode ()
            (interactive)
            (hs-minor-mode t))
          (add-hook 'prog-mode-hook 'my/enable-hs-minor-mode))
  :config (progn
            (defvar hs-special-modes-alist
              (mapcar 'purecopy
                      '((c-mode "{" "}" "/[*/]" nil nil)
                        (c++-mode "{" "}" "/[*/]" nil nil)
                        (bibtex-mode ("@\\S(*\\(\\s(\\)" 1))
                        (js-mode "{" "}" "/[*/]" nil)
                        (javascript-mode  "{" "}" "/[*/]" nil))))))

;; (use-package highlight-defined
;;   :config
;;   (progn
;;     (add-hook'emacs-lisp-mode-hook 'highlight-defined-mode)))

(use-package flycheck
  :ensure t
  :defer t
  :config (global-flycheck-mode)
           (setq-default flycheck-disabled-checkers
                         (append flycheck-disabled-checkers
                                 '(javascript-jshint)))
           (setq flycheck-checkers '(javascript-eslint))
           ;; use eslint with web-mode for jsx files
           (flycheck-add-mode 'javascript-eslint 'web-mode)
           (flycheck-add-mode 'javascript-eslint 'js2-mode)
           (flycheck-add-mode 'javascript-eslint 'js-mode)
           ;; To verify just do C-h v flycheck-eslintrc
           (setq flycheck-eslintrc "~/.eslintrc"))

(use-package ag
  :ensure t
  :defer t
  :config (progn
            (setq ag-highlight-search t)
            (bind-key "n" 'compilation-next-error ag-mode-map)
            (bind-key "p" 'compilation-previous-error ag-mode-map)
            (bind-key "N" 'compilation-next-file ag-mode-map)
            (bind-key "P" 'compilation-previous-file ag-mode-map)))

(use-package helm-ag
  :ensure t
  :defer t
  :init (setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case"
              helm-ag-command-option "--all-text"
              helm-ag-insert-at-point 'symbol))

(use-package yasnippet
  :ensure t
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  :init (progn
          (setq yas-verbosity 3)
          (yas-global-mode 1)))

(use-package hippie-exp-ext
  :ensure t
  :defer t
  :init (setq hippie-expand-try-functions-list
              '(try-complete-file-name-partially
                try-complete-file-name
                try-expand-dabbrev
                try-expand-dabbrev-all-buffers
                try-expand-dabbrev-from-kill))
  :bind ("M-/" . hippie-expand))

(use-package magit
  :ensure t
  :defer t
  :bind (("M-g s" . magit-status)
         ("M-g l" . magit-log)
         ("M-g f" . magit-pull)
         ("M-g p" . magit-push)
         ("M-g x" . magit-reset-hard))
  :init
  (setq magit-popup-show-common-commands nil)
  (setq magit-log-arguments '("--graph"
                              "--decorate"
                              "--color"))
  :config
  (progn
    (defadvice magit-status (around magit-fullscreen activate)
      (window-configuration-to-register :magit-fullscreen)
      ad-do-it
      (delete-other-windows))

    (defun magit-quit-session ()
      "Restores the previous window configuration and kills the magit buffer"
      (interactive)
      (kill-buffer)
      (jump-to-register :magit-fullscreen))

    (define-key magit-status-mode-map (kbd "q") 'magit-quit-session))

  ;; removes 1.4.0 warning in arguably cleaner way
  (remove-hook 'after-init-hook 'magit-maybe-show-setup-instructions)
  (defadvice magit-blame-mode (after switch-to-emacs-state activate)
    (if magit-blame-mode
        (evil-emacs-state 1)
      (evil-normal-state 1))))

;(use-package git-gutter
;  :ensure t
;  :defer t
;  :init (global-git-gutter-mode t)
;  :config
;  (progn
;    (setq git-gutter:window-width 2)
;    (setq git-gutter:modified-sign "==")
;    (setq git-gutter:added-sign "++")
;    (setq git-gutter:deleted-sign "--")
;    (set-face-foreground 'git-gutter:added "#daefa3")
;    (set-face-foreground 'git-gutter:deleted "#FA8072")
;    (set-face-foreground 'git-gutter:modified "#b18cce")
;    ))

(use-package projectile
  :defer t
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package helm-projectile
  :defer t
  :commands (helm-projectile helm-projectile-switch-project)
  :ensure t)

;; Autocomplete
(use-package company
  :defer 10
  :diminish company-mode
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous))
  :preface
  ;; enable yasnippet everywhere
  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")
  (defun company-mode/backend-with-yas (backend)
    (if (or 
         (not company-mode/enable-yas) 
         (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))

  :init (global-company-mode t)
  :config
  ;; no delay no autocomplete
  (setq
   company-idle-delay 0
   company-minimum-prefix-length 2
   company-tooltip-limit 20)
  (setq company-backends 
                 (mapcar #'company-mode/backend-with-yas company-backends)))

(provide 'init-pkgs)
