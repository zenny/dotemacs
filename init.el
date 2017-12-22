;; Emacs configuration

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Change some default settings    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; General settings
(setq user-full-name "Sriram Krishnaswamy")									  	; Hi Emacs, I'm Sriram
(setq gc-cons-threshold (* 500 1024 1024))									  	; increase the threshold for garbage collection - 100 MB
(setq delete-old-versions -1)												  	; delete excess backup versions silently
(setq version-control t)													  	; use version control for backups
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))				  	; which directory to put backups file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))	; transform backups file name
(setq inhibit-startup-screen t)												  	; inhibit useless and old-school startup screen
(setq visible-bell nil)														  	; no visible bell for errors
(setq ring-bell-function 'ignore)											  	; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8)										  	; use utf-8 by default for reading
(setq coding-system-for-write 'utf-8)										  	; use utf-8 by default for writing
(setq sentence-end-double-space nil)										  	; sentence SHOULD end with only a point.
(setq-default fill-column 80)													; toggle wrapping text at the 80th character
(setq initial-scratch-message "(hello-human)")								  	; print a default message in the empty scratch buffer opened at startup
(menu-bar-mode -1)															  	; deactivate the menubar
(tool-bar-mode -1)															  	; deactivate the toolbar
(scroll-bar-mode -1)														  	; deactivate the scrollbar
(tooltip-mode -1)															  	; deactivate the tooltip
(setq initial-frame-alist													  	; initial frame size
	  '((width . 102)														  	; characters in a line
		(height . 54)))														  	; number of lines
(setq default-frame-alist													  	; subsequent frame size
	  '((width . 100)														  	; characters in a line
		(height . 52)))														  	; number of lines
(blink-cursor-mode -1)														  	; don't blink the cursor
(defun display-startup-echo-area-message () (message "Let the games begin!")) 	; change the default startup echo message
(setq-default truncate-lines t)												  	; if line exceeds screen, let it
(setq large-file-warning-threshold (* 15 1024 1024))						  	; increase threshold for large files
(fset 'yes-or-no-p 'y-or-n-p)												  	; prompt for 'y' or 'n' instead of 'yes' or 'no'
(setq-default abbrev-mode t)												  	; turn on abbreviations by default
(setq recenter-positions '(middle top bottom))								  	; recenter from the top instead of the middle
(put 'narrow-to-region 'disabled nil)										  	; enable narrowing to region
(put 'narrow-to-defun 'disabled nil)										  	; enable narrowing to function
(when (fboundp 'winner-mode)												  	; when you can find 'winner-mode'
  (winner-mode 1))															  	; activate winner mode
(setq recentf-max-saved-items 1000											  	; set the number of recent items to be saved
	  recentf-exclude '("/tmp/" "/ssh:"))									  	; exclude the temporary and remote files accessed recently
(setq ns-use-native-fullscreen nil)											  	; don't use the native fullscreen - more useful in a Mac
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))		  	; setup a new custom file
(when (file-exists-p custom-file)											  	; if the custom file exists
  (load custom-file :noerror :nomessage))									  	; load the custom file but don't show any messages or errors
(put 'scroll-left 'disabled nil)											  	; enable sideward scrolling
(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)			  	; backward kill word in minibuffer
(setq enable-recursive-minibuffers t)										  	; use the minibuffer while using the minibuffer
(setq echo-keystrokes 0.05)													  	; when to echo keystrokes
(setq-default ibuffer-expert t)												    ; don't ask confirmation when deleting unmodified buffers
(setq frame-resize-pixelwise t)												    ; resize based on pixels to remove annoying gaps

;; line number after emacs 26
(if (version< emacs-version "26")
	(message "Line number mode not activated")
  (global-display-line-numbers-mode))

;; how tabs are seen and added
(setq-default tab-width 4)
(setq-default tab-stop-list
			  '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

;; how to interpret the command key and the option key on a Mac
(when (eq system-type 'darwin)
  ;; (setq mac-command-key-is-meta nil)
  (setq mac-command-modifier 'meta)
  ;; (setq mac-option-key-is-meta t)
  ;; (setq mac-option-modifier 'meta)
  )

;; Set fonts
(cond ((eq system-type 'gnu/linux)                 ; if system is GNU/Linux
       (set-frame-font "DejaVu Sans Mono"))        ; set the font to DejaVu Sans Mono
      ((eq system-type 'darwin)                    ; if system is macOS
	   (mac-auto-operator-composition-mode)        ; ligature support
       (set-frame-font "Fira Code"))               ; set the font to Monaco
      ((eq system-type 'windows-nt)                ; if system is Windows
       (set-frame-font "Lucida Sans Typewriter"))) ; set the font to Lucida Sans Typewriter

;; dummy function
(defun sk/nothing ()
  "Sends a message saying nothing here"
  (interactive)
  (message "Nothing here!"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Package management    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Include the module to install packages
(require 'package)

;; tells emacs not to load any packages before starting up
(setq package-enable-at-startup nil)

;; the following lines tell emacs where on the internet to look up
;; for new packages.
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
						 ("gnu"       . "http://elpa.gnu.org/packages/")
						 ("melpa"     . "https://melpa.org/packages/")))

;; initialize the packages
(package-initialize)

;; allow unsigned packages
(setq package-check-signature nil)

;;;;;;;;;;;;;;;;;;;;;;;
;;    use-package    ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path (concat user-emacs-directory "use-package/"))
  (require 'use-package))

;; Keep the mode-line clean
(use-package diminish
  :ensure t
  :demand t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Built-in packages    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; directory listing
(use-package dired
  :hook (dired-mode . dired-hide-details-mode)
  :init
  (setq dired-dwim-target t
        dired-recursive-copies 'top
        dired-recursive-deletes 'top
        dired-listing-switches "-alh"))

;; dired library for additional functions
(use-package dired-x
  :commands
  (dired-jump))

;; pdf/image viewing
(use-package doc-view
  :hook ((doc-view-mode . doc-view-fir-page-to-window)
         (doc-view-minor-mode . doc-view-fir-page-to-window))
  :init
  (setq doc-view-continuous t))

;; builtin version control
(use-package vc
  :init
  (setq vc-make-backup-files t
        vc-follow-symlinks t))

;; diff management
(use-package ediff
  :init
  (setq ediff-window-setup-function 'ediff-setup-windows-plain
        ediff-split-window-function 'split-window-horizontally))

;; abbrev
(use-package abbrev
  :diminish abbrev-mode
  :init
  (setq save-abbrevs 'silently)
  :config
  (if (file-exists-p abbrev-file-name)
      (quietly-read-abbrev-file)))

;; subword navigation
(use-package subword
  :hook (prog-mode . subword-mode)
  :config
  (subword-mode 1))

;; visual line - soft wrap
(use-package visual-line
  :hook (text-mode . visual-line-mode)
  :diminish (visual-line-mode . " ω")
  :commands
  (visual-line-mode))

;; auto revert mode
(use-package autorevert
  :demand t
  :diminish auto-revert-mode)

;; builtin support for folding
(use-package hs-minor
  :hook ((text-mode . hs-minor-mode)
         (prog-mode . hs-minor-mode))
  :diminish hs-minor-mode)

;; documentation helper
(use-package eldoc
  :hook (prog-mode . eldoc-mode)
  :diminish eldoc-mode)

;; spell check
(use-package flyspell
  :hook ((text-mode . flyspell-mode)
         (org . flyspell-mode))
  :diminish (flyspell-mode . " φ"))

;; save history
(use-package savehist
  :demand t
  :config
  (savehist-mode 1))

;; debugging gdb
(use-package gud
  :init
  (setq gdb-many-windows t
        gdb-show-main t)
  :commands
  (gud-run
   gud-down
   gud-up
   gud-next
   gud-step
   gud-next
   gud-finish
   gud-cont
   gud-goto-info
   gud-basic-call
   gud-print
   gud-refresh
   gud-find-c-expr
   gdb-toggle-breakpoint
   gdb-delete-breakpoint
   gdb))

;; ibuffer
(use-package ibuffer
  :commands
  (ibuffer)
  :bind (:map ibuffer-mode-map
			  ("a a" . ibuffer-mark-by-mode)
			  ("a s" . ibuffer-mark-special-buffers)
			  ("a m" . ibuffer-mark-unsaved-buffers)
			  ("a u" . ibuffer-mark-modified-buffers)
			  ("a r" . ibuffer-mark-by-name-regexp)
			  ("a f" . ibuffer-mark-by-file-name-regexp)
			  ("a d" . ibuffer-mark-dired-buffers)
			  ("a h" . ibuffer-mark-hel-buffers)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Third party packages    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; extra functions
(add-to-list 'load-path
             (expand-file-name "defuns" user-emacs-directory))

;; extra macros
(add-to-list 'load-path
             (expand-file-name "macros" user-emacs-directory))

;; extra major/minor modes
(add-to-list 'load-path
             (expand-file-name "modes" user-emacs-directory))

;; language specific setup
(add-to-list 'load-path
             (expand-file-name "lang" user-emacs-directory))

;; other configuration
(add-to-list 'load-path
             (expand-file-name "config" user-emacs-directory))

;; string manipulation library
(use-package s
  :ensure t)

;; list library
(use-package dash
  :ensure t)

;; Make sure the path is set right for macOS
(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
  :ensure t
  :bind* (("C-x x" . exec-path-from-shell-initialize)
          ("C-x y" . exec-path-from-shell-copy-env))
  :init
  (setq exec-path-from-shell-check-startup-files nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Core functions    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Macros
(require 'sk-repl-macros)

;; functions
(require 'sk-buffer-defuns)
(require 'sk-dired-defuns)
(require 'sk-display-defuns)
(require 'sk-doc-defuns)
(require 'sk-editing-defuns)
(require 'sk-navigation-defuns)
(require 'sk-search-defuns)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Core packages    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; hint for bindings
(use-package which-key
  :ensure t
  :demand t
  :diminish which-key-mode
  :bind* (("C-c ?" . which-key-show-top-level))
  :config
  ;; workaround for emacs 26
  (if (version< emacs-version "26")
	  (message "Tracking stable Emacs")
	(defalias 'display-buffer-in-major-side-window 'window--make-major-side-window))
  ;; turn on which key and add some names for default/common prefixes
  (which-key-enable-god-mode-support)
  (which-key-mode))

;; simulating mouse click
(use-package avy
  :ensure t
  :commands
  (avy-goto-char-2
   avy-goto-word-1
   avy-goto-char-2-above
   avy-goto-char-2-below
   avy-goto-char-in-line
   avy-goto-line)
  :init
  (setq avy-keys-alist
		`((avy-goto-char-2			. (?j ?k ?l ?f ?s ?d ?e ?r ?u ?i))
		  (avy-goto-word-1			. (?j ?k ?l ?f ?s ?d ?e ?r ?u ?i))
		  (avy-goto-char-in-line	. (?j ?k ?l ?f ?s ?d ?e ?r ?u ?i))
		  (avy-goto-char-2-above	. (?j ?k ?l ?f ?s ?d ?e ?r ?u ?i))
		  (avy-goto-char-2-below	. (?j ?k ?l ?f ?s ?d ?e ?r ?u ?i))
		  (avy-goto-line			. (?j ?k ?l ?f ?s ?d ?e ?r ?u ?i))))
  ;; (setq avy-style 'pre)
  (setq avy-background t)
  (defface avy-lead-face-0
	'((t (:foreground "white" :background "color-21")))
	"Face used for first non-terminating leading chars."))

;; jump to windows quickly
(use-package ace-window
  :ensure t
  :after (avy)
  :commands
  (ace-window))

;; jump and open links fast
(use-package ace-link
  :ensure t
  :after (avy)
  :config
  (ace-link-setup-default))

;; moving across changes
(use-package goto-chg
  :ensure t
  :commands (goto-last-change
			 goto-last-change-reverse))

;; smart beginning and end in buffers
(use-package beginend
  :ensure t
  :hook ((dired-mode . beginend-global-mode)
         (text-mode . beginend-global-mode)
         (prog-mode . beginend-global-mode))
  :diminish ((beginend-global-mode . "")
             (beginend-prog-mode . ""))
  :config
  (beginend-global-mode))

;; moving across marks
(use-package back-button
  :ensure t
  :commands
  (back-button-local-backward
   back-button-local-forward
   back-button-global-backward
   back-button-global-forward))

;; dash documentation
(use-package dash-at-point
  :ensure t
  :commands
  (dash-at-point-with-docset))

;; dumb jumping
(use-package dumb-jump
  :ensure t
  :ensure-system-package ("ag")
  :commands
  (dumb-jump-go
   dumb-jump-goto-file-line)
  :config
  (dumb-jump-mode))

;;;;;;;;;;;;;;;;;;;;;;;;
;;    Key bindings    ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; immutable bindings
(bind-keys*
 ("C-j"   . electric-newline-and-maybe-indent)
 ("C-w"   . sk/kill-region-or-backward-word)
 ("M-w"   . sk/copy-region-or-line)
 ("M-c"   . sk/toggle-letter-case)
 ("M-h"   . sk/remove-mark)
 ("C-x k" . sk/kill-buffer))

;; mutable bindings
(bind-keys
 ("C-o"     . sk/open-line-above)
 ("M-o"     . sk/open-line-below)
 ("C-x C-b" . ibuffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Reduce GC threshold    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 1 MB now
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold (* 1 1024 1024))))

