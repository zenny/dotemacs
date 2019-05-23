;; language client registration for clang
(defun sk/lsp-register-clang ()
  "Registers language client for clang"
  (interactive)
  (require 'lsp-mode)
  (require 'lsp-ui)
  (require 'dap-lldb)
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "clangd")
					:major-modes '(c++-mode)
					:server-id 'clangd))
  (lsp-mode)
  (lsp-ui-mode)
  (lsp)
  (dap-mode 1)
  (dap-ui-mode 1))

;; language client registration for python
(defun sk/lsp-register-python ()
  "Registers language client for python"
  (interactive)
  (require 'lsp-mode)
  (require 'lsp-ui)
  (require 'dap-python)
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection
  									 (concat (getenv "HOME") "/.local/bin/pyls"))
  					:major-modes '(python-mode)
  					:server-id 'pyls))
  (lsp-mode)
  (lsp-ui-mode)
  (lsp)
  (dap-mode 1)
  (dap-ui-mode 1))

(defun sk/lsp-clear-blacklist ()
  "clears the blacklist in LSP"
  (interactive)
  (setf (lsp-session-folders-blacklist (lsp-session)) nil)
  (lsp--persist-session (lsp-session)))

;; Microsoft Language Server Protocol (LSP)
(use-package lsp-mode
  :ensure t
  :hook (c++-mode python-mode)
  :hook ((python-mode . sk/lsp-register-python)
		 (c++-mode . sk/lsp-register-clang))

  :commands
  (lsp-register-client
   make-lsp-client
   lsp-stdio-connection
   lsp-workspace-folders-add
   lsp-format-buffer
   lsp-execute-command
   lsp-goto-type-definition
   lsp-execute-code-action
   lsp-find-declaration
   lsp-find-locations
   lsp-hover
   lsp-goto-definition
   lsp-describe-session
   lsp-rename
   lsp-find-definition
   lsp-find-implementation
   lsp-restart-workspace
   lsp-find-references
   lsp-find-session-folder
   lsp-find-type-definition
   lsp-workspace-folders-remove
   lsp-workspace-folders-switch
   lsp-find-workspace)

  :config
  (ryo-modal-major-mode-keys
   'c++-mode
   ("m k" sk/lsp-register-clang :name "lsp clang"))

  (ryo-modal-major-mode-keys
   'python-mode
   ("m k" sk/lsp-register-python :name "lsp python")))

;; LSP user interface
(use-package lsp-ui
  :ensure t
  :hook ((lsp-mode . lsp-ui-mode))
  :commands
  (lsp-ui-doc
   lsp-ui-peek-find-workspace-symbol
   lsp-ui-peek-find-definitions
   lsp-ui-peek-find-references
   lsp-ui-peek-find-implementation
   lsp-ui-imenu)
  :config
  (require 'lsp-mode)
  (require 'lsp-ui))

;; LSP debugging support
(use-package dap-mode
  :ensure t
  :after (lsp-mode)
  :hook ((lsp-mode . dap-mode)
		 (dap-mode . dap-ui-mode))
  :commands
  (dap-breakpoint-add
   dap-breakpoint-toggle
   dap-breakpoint-condition
   dap-breakpoint-delete
   dap-eval-thing-at-point
   dap-continue
   dap-go-to-output-buffer
   dap-breakpoint-hit-condition
   dap-ui-inspect-thing-at-point
   dap-step-in
   dap-step-out
   dap-breakpoint-log-message
   dap-ui-breakpoints
   dap-next
   dap-debug
   dap-switch-stack-frame
   dap-restart-frame
   dap-ui-repl
   dap-switch-session
   dap-switch-thread
   dap-stop-thread
   dap-ui-locals
   dap-debug-edit-template
   dap-disconnect
   dap-ui-inspect
   dap-eval
   dap-hydra)
  :config
  (dap-mode 1)
  (dap-ui-mode 1))

;; LSP for Java
(use-package lsp-java
  :ensure t
  :after (lsp-mode)
  :hook ((java-mode . lsp-mode)
		 (java-mode . lsp-ui-mode)
		 (java-mode . lsp))
  :config
  (require 'lsp-java))

;; provide the configuration
(provide 'sk-lsp)
