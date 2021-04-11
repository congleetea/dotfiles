;;; init-plantform.el
;;; Commentary:
;;; Code:

(when (system-is-mac)
  ;; Switch the Cmd and Meta keys
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq ns-use-native-fullscreen nil)

  ;; On OSX, I use the pbpaste and pbcopy methods to interact with the system clipboard.
  ;; brew install coreutils
  (if (executable-find "gls")
      (progn
        (setq insert-directory-program "gls")
        (setq dired-listing-switches "-lFaGh1v --group-directories-first"))
    (setq dired-listing-switches "-ahlF"))

  (defun copy-from-osx ()
    "Handle copy/paste intelligently on osx."
    (let ((pbpaste (purecopy "/usr/bin/pbpaste")))
      (if (and (eq system-type 'darwin)
               (file-exists-p pbpaste))
          (let ((tramp-mode nil)
                (default-directory "~"))
            (shell-command-to-string pbpaste)))))

  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "/usr/bin/pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

  (setq interprogram-cut-function 'paste-to-osx
        interprogram-paste-function 'copy-from-osx)


  ;; Trash.
  (defun move-file-to-trash (file)
    "Use `trash' to move FILE to the system trash.
    When using Homebrew, install it using \"brew install trash\"."
    (call-process (executable-find "trash")
                  nil 0 nil
                  file))
  (setq trash-directory "~/.Trash/emacs")
  (setq delete-by-moving-to-trash t)
  (defun system-move-file-to-trash (file)
    "Use \"trash\" to move FILE to the system trash.
      When using Homebrew, install it using \"brew install trash\"."
    (call-process (executable-find "trash")
                  nil 0 nil
                  file))
  )


(when (system-is-linux)
  (defun yank-to-x-clipboard ()
    (interactive)
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  )

;; -----------------------------------------------------------------------
;;       clipboard 
;; -----------------------------------------------------------------------
(setq is-mac (equal system-type 'darwin))

(when is-mac
  (defun paste-with-Xclipboard ()
    (shell-command-to-string "pbpaste"))

  (defun copy-to-Xclipboard (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc)))))

(unless is-mac
  (defun paste-with-Xclipboard ()
    (shell-command-to-string "xsel -ob"))

  (defun copy-to-Xclipboard (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "copy_to_X" "*Messages*" "xsel" "-ib")))
        (process-send-string proc text)
        (process-send-eof proc)))))

(setq interprogram-cut-function 'copy-to-Xclipboard)
(setq interprogram-paste-function 'paste-with-Xclipboard)
;; ---------------------------- end clipboard -----------------------------

;; fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; ---------------------------- begin youdao ------------------------------ 
(use-package youdao-dictionary
  :ensure t
  :defer t
  :config (progn
            (setq helm-autoresize-mode 1)
            ))

(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)
(global-set-key (kbd "C-c o") 'youdao-dictionary-play-voice-at-point)
;; ---------------------------- end youdao -------------------------------- 

(global-set-key (kbd "C-c C-j") 'dired-jump)

(use-package telephone-line      :ensure t :config (telephone-line-mode 1))

(use-package monokai-theme       :ensure t :defer t)

(load-theme 'monokai t)
;; (use-package gotham-theme        :ensure t :defer t)
;; (load-theme 'gotham t)
;; (use-package atom-one-dark-theme :ensure t :defer t)
;; (load-theme 'atom-one-dark t)
;; (use-package solarized-theme     :ensure t :defer t)
;; (load-theme 'solarized t)

(provide 'init-platform)
