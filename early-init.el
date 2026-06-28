;; -*- lexical-binding: t; -*-

;; For speed up the startup, please do NOT forget reset it to a reasonable
;; value after Emacs finishes loading, or it may cause freezes.
;; 100 MB is appropriate for a 16 GB machine — won't GC too often.
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          #'(lambda () (setq gc-cons-threshold (* 100 1024 1024))))

;; Prevent unwanted runtime compilation for native-comp users
(setq inhibit-automatic-native-compilation t)

;; Package initialize occurs automatically, before `user-init-file' is loaded
;; but after `early-init-file'. If you want to handle package initialization,
;; you can prevent Emacs from doing it early by uncomment next line!
(setq package-enable-at-startup nil)

;; [From DOOM Emacs]
;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

;; Do not resize the frame at this early stage.
(setq frame-inhibit-implied-resize t)

;; Clean GUI
(push '(scroll-bar-mode . nil) default-frame-alist)
(push '(tool-bar-mode . nil) default-frame-alist)
(push '(menu-bar-mode . nil) default-frame-alist)

;; System default coding
;; (set-language-environment 'utf-8)

;; Misc settings
(setq mode-line-compact t)

;; Reduce file-system scanning overhead on Windows: only look for .elc and .el
(setq load-suffixes '(".elc" ".el")
      load-file-rep-suffixes '(""))

;; Startup timer for performance diagnostics
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs 启动完成，耗时 %.2f 秒，GC #%d 次。"
                     (float-time (time-subtract after-init-time before-init-time))
                     gcs-done)))

;;; early-init.el ends here
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; END:
