;;; init-org.el --- Set up Org Mode
;;; Commentary:
;; reffer to: http://www.zmonster.me/2015/07/15/org-mode-planning.html
;; reffer to: https://zhangda.wordpress.com/2016/02/15/configurations-for-beautifying-emacs-org-mode/

(use-package org-page :ensure t)
(use-package org-evil :ensure t)
(setq auto-mode-alist (cons '("\\.org$" . org-mode) auto-mode-alist))

;;; org-page
(use-package uimage
             :ensure t
             :defer t
             )
(setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/vendor/plantuml.jar"))
(setq org-ditaa-jar-path (expand-file-name "~/.emacs.d/vendor/ditaa0_9.jar"))
(setq org-confirm-babel-evaluate nil)
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(setq-default fill-column 80)

(require 'ob)
(require 'ob-plantuml)
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (plantuml . t)
   (org . t)
   (sh . t)
   (C . t)
   (python . t)
   (awk . t)
   (ditaa . t)
   (latex . t)
   ))

;; Highlight and indent source code blocks
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

;; Prevent confirmation
(setq org-confirm-babel-evaluate nil)

(use-package htmlize
             :ensure t
             :defer t
             :commands (htmlize-buffer
                        htmlize-file
                        htmlize-many-files
                        htmlize-many-files-dired
                        htmlize-region))

(use-package org-page
  :ensure t
  :config
  (progn
    (setq op/repository-directory "~/gitlab/congleetea.github.io")
    (setq op/site-domain "https://congleetea.github.io")
    (setq op/personal-github-link "https://github.com/congleetea")
    (setq op/site-main-title "清园索道")
    (setq op/site-sub-title "上下求索，识己识人识事")
    (setq op/personal-disqus-shortname "congleetea")
    (setq op/hashover-comments t)
    (setq op/theme-root-directory "~/.emacs.d/themes")
    (setq op/theme 'org-page-theme-suodao)
    (setq op/highlight-render 'js)
    )
  )

(provide 'init-org)
