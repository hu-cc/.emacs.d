;; -*- lexical-binding: t; -*-

(setq default-directory "D:/")

;; Require and initialize `package`.
(require 'package)
(setq package-check-signature nil
      load-prefer-newer t)

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; Aggregate all package autoloads into a single file (skip per-package scanning)
(setq package-quickstart t)

(unless (bound-and-true-p package--initialized)
  (package-initialize))

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

(require 'use-package)

;; diminish & delight, as use-package optional dependency
;; Deferred — only loaded when a package actually uses :diminish or :delight
(use-package diminish :defer t)
(use-package delight :defer t)

;; Load config — only load Org to tangle when config.org is newer than config.el
(let ((org-file (expand-file-name "config.org" user-emacs-directory))
      (el-file  (expand-file-name "config.el" user-emacs-directory)))
  (when (file-newer-than-file-p org-file el-file)
    (require 'org)
    (org-babel-tangle-file org-file el-file "emacs-lisp"))
  (load el-file nil t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mini-frame-show-parameters '((top . 10) (width . 0.7) (left . 0.5)))
 '(org-agenda-files nil)
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
