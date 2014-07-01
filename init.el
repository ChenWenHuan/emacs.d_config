;; -*- coding: utf-8 -*-
(add-to-list 'load-path "~/.emacs.d/site-lisp/cedet-1.1/common")
(require 'cedet)
(require 'semantic-ia)
 
;; Enable EDE (Project Management) features
(global-ede-mode 1)
 
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)
 
;; Enable SRecode (Template management) minor-mode.
(global-srecode-minor-mode 1)

(add-to-list 'load-path "~/.emacs.d/site-lisp/ecb-snap")
(require 'ecb)
(require 'ecb-autoloads)
(setq stack-trace-on-error nil)
(setq ecb-auto-activate t
 ecb-tip-of-the-day nil)



(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *macbook-pro-support-enabled* t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))
(setq *win32* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *linux-x* (and window-system *linux*) )
(setq *xemacs* (featurep 'xemacs) )
(setq *emacs23* (and (not *xemacs*) (or (>= emacs-major-version 23))) )
(setq *emacs24* (and (not *xemacs*) (or (>= emacs-major-version 24))) )

;----------------------------------------------------------------------------
; Functions (load all files in defuns-dir)
; Copied from https://github.com/magnars/.emacs.d/blob/master/init.el
;----------------------------------------------------------------------------
(setq defuns-dir (expand-file-name "~/.emacs.d/defuns"))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
      (load file)))
;----------------------------------------------------------------------------
; Load configs for specific features and modes
;----------------------------------------------------------------------------
(require 'init-modeline)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'cl-lib)
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el

;; win32 auto configuration, assuming that cygwin is installed at "c:/cygwin"
(condition-case nil
    (when *win32*
      (setq cygwin-mount-cygwin-bin-directory "c:/cygwin/bin")
      (require 'setup-cygwin)
      ;; better to set HOME env in GUI
      ;; (setenv "HOME" "c:/cygwin/home/someuser")
      )
  (error
   (message "setup-cygwin failed, continue anyway")
   ))

(require 'init-elpa)
(require 'init-exec-path) ;; Set up $PATH
(require 'init-frame-hooks)
;; any file use flyspell should be initialized after init-spelling.el
;; actually, I don't know which major-mode use flyspell.
(require 'init-spelling)
(require 'init-xterm)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-maxframe)
(require 'init-proxies)
;(require 'init-dired)
(require 'init-isearch)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flymake)
(require 'init-artbollocks-mode)
(require 'init-recentf)
(require 'init-ido)
(require 'init-smex)
(if *emacs24* (require 'init-helm))
(require 'init-hippie-expand)
(require 'init-windows)
(require 'init-sessions)
(require 'init-fonts)
(require 'init-git)
(require 'init-crontab)
(require 'init-textile)
(require 'init-markdown)
(require 'init-csv)
(require 'init-erlang)
(require 'init-javascript)
(require 'init-sh)
(when *emacs24*
  (require 'init-org)
  (require 'init-org-mime))
(require 'init-css)
(require 'init-haml)
(require 'init-python-mode)
(require 'init-haskell)
(require 'init-ruby-mode)
(require 'init-lisp)
(require 'init-elisp)
(require 'init-yasnippet)
;; Use bookmark instead
(require 'init-zencoding-mode)
(require 'init-yari)
(require 'init-cc-mode)
(require 'init-gud)
(require 'init-semantic)
(require 'init-cmake-mode)
(require 'init-csharp-mode)
(require 'init-linum-mode)
(require 'init-emacs-w3m)
(require 'init-eim)
(require 'init-which-func)
(require 'init-keyfreq)
;; (require 'init-gist)
(require 'init-emacspeak)
(require 'init-pomodoro)
(require 'init-moz)
(require 'init-gtags)
;; use evil mode (vi key binding)
(require 'init-evil)
;(require 'init-misc)
(require 'init-ctags)
(require 'init-ace-jump-mode)
(require 'init-bbdb)
(require 'init-gnus)
;; itune cannot play flac, so I use mplayer+emms instead (updated, use mpd!)
(require 'init-emms)
(require 'init-lua-mode)
(require 'init-doxygen)
(require 'init-workgroups2)
(require 'init-move-window-buffer)
(require 'init-term-mode)
(require 'init-web-mode)
(require 'init-sr-speedbar)
(require 'init-smartparens)
(require 'init-slime)
(when *emacs24* (require 'init-company))
(require 'init-stripe-buffer)
(require 'init-elnode)
(require 'init-themes)


(add-to-list 'load-path "~/.emacs.d/xcscope")
(require 'xcscope)
(setq cscope-do-not-update-database t)


;;unicad自动编码识别器
(require 'unicad)
;(set-default-font "Source Code Pro-14")
(set-fontset-font "fontset-default" 'gb18030' ("STHeiti" . "unicode-bmp"))
;; set Chinese font, or the when showing Italic Chinese characters, only
;; rectangle block shown
(set-fontset-font
 (frame-parameter nil 'font)
  'han
   (font-spec :family "Hiragino Sans GB" ))

   ;; set default encoding to utf-8
;(setq-default buffer-file-coding-system 'utf-8)
   ;; ;; set writing buffer default to utf-8, or emacs always show encoding
   ;; ;; problem when saving files.
;(setq save-buffer-coding-system 'utf-8)
;(setq coding-system-for-write 'utf-8)

;using ctrl + f5 reflsh files modified by other editor
(defun refresh-file ()
      (interactive)
      (revert-buffer t (not (buffer-modified-p)) t))

(global-set-key [(control f5)] 'refresh-file)  ')


;;;;;
;;以 y/n 替代 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; org-mode < 8.0
;(setq org-latex-to-pdf-process '("xelatex -interaction nonstopmode %f"
;                                 "xelatex -interaction nonstopmode %f"))

;;  org-mode 8.0
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/texlive/2013/bin/x86_64-darwin/"))
(setq exec-path (append exec-path '("/usr/local/texlive/2013/bin/x86_64-darwin/")))

(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
                              "xelatex -interaction nonstopmode %f"))
;; latex mode 下设置xelatex编译方法
(add-hook 'LaTeX-mode-hook (lambda()
          (add-to-list 'TeX-command-list '("XeLaTeX"
          "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
           (setq TeX-command-default "XeLaTeX")
           (setq TeX-save-query  nil )
           (setq TeX-show-compilation t)
           ))
;; ditaa draw picture
(setq org-confirm-babel-evaluate nil)
(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/scripts/plantuml.jar"))
(setq org-ditaa-jar-path (format "%s%s" (if *cygwin* "c:/cygwin" "")
                         (expand-file-name "~/.emacs.d/elpa/contrib/scripts/ditaa.jar")) )


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
;(if (file-readable-p (expand-file-name "~/.custom.el"))
;     (load-file (expand-file-name "~/.custom.el")))
;
;;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
;(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;(when (file-exists-p custom-file)
;  (load custom-file))

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
;(require 'init-locales) ;does not work in cygwin


(when (require 'time-date nil t)
   (message "Emacs startup time: %d seconds."
    (time-to-seconds (time-since emacs-load-start-time)))
   )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector (vector "#657b83" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#fdf6e3"))
 '(bmkp-last-as-first-bookmark-file "~/.emacs.bmk")
 '(custom-enabled-themes (quote (sanityinc-solarized-dark)))
 '(custom-safe-themes (quote ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default)))
 '(ecb-options-version "2.40")
 '(fci-rule-color "#eee8d5")
 '(safe-local-variable-values (quote ((emacs-lisp-docstring-fill-column . 75) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby"))))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#cb4b16") (60 . "#b58900") (80 . "#859900") (100 . "#2aa198") (120 . "#268bd2") (140 . "#d33682") (160 . "#6c71c4") (180 . "#dc322f") (200 . "#cb4b16") (220 . "#b58900") (240 . "#859900") (260 . "#2aa198") (280 . "#268bd2") (300 . "#d33682") (320 . "#6c71c4") (340 . "#dc322f") (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))
;;; Local Variables:
;;; no-byte-compile: t
;;; End:
(put 'erase-buffer 'disabled nil)
(put 'upcase-region 'disabled nil)
