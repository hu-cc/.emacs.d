;; Preferences
(setq inhibit-startup-screen t)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq ring-bell-function 'ignore)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

;; Appearance

(set-frame-font "Fira Code Retina 12" nil t)

(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)
