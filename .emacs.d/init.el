(defvar bootstrap-version
  (let ((bootstrap-file
	 (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
	(bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
	(goto-char (point-max))
	(eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage)))

(straight-use-package 'use-package)

(setq straight-use-package-by-default t
      frame-resize-pixelwise t
      ring-bell-function 'ignore
      display-line-numbers-type 'relative
      gc-cons-threshold (* 1024 1024 100)
      read-process-output-max (* 1024 1024)
      inhibit-splash-screen t
      auto-save-default nil
      make-backup-files nil
      org-latex-compiler "xelatex")

(global-display-line-numbers-mode 1)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(display-battery-mode 1)
(display-time-mode 1)

(set-face-attribute 'default nil :font "Cascadia Code PL" :height 160)

(use-package evil
  :custom
  (evil-want-C-u-scroll t)
  (evil-want-C-d-scroll t)
  (evil-want-keybinding nil)
  (evil-echo-state nil)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

(use-package evil-multiedit)

(use-package magit)

(use-package company
  :custom
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 1)
  :config
  (global-company-mode))

(use-package company-box
  :hook ((company-mode . company-box-mode)))

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(use-package general)

(general-evil-setup)

(use-package which-key
  :config (which-key-mode))

(general-imap "j"
  (general-key-dispatch 'self-insert-command
    :timeout 0.2
    "k" 'evil-normal-state))

(use-package avy
  :custom (avy-timeout-seconds 0.2))

(use-package helpful)

(general-nmap
  ";" 'evil-ex
  "s" 'avy-goto-char-timer
  "? k" 'helpful-key
  "? v" 'helpful-variable
  "? c" 'helpful-callable
  "? f" 'helpful-function
  "? m" 'helpful-macro
  "? p" 'helpful-at-point
  "? C" 'helpful-command
  "C-h" 'evil-window-left
  "C-j" 'evil-window-down
  "C-k" 'evil-window-up
  "C-l" 'evil-window-right)

(use-package counsel)

(use-package projectile
  :custom (projectile-project-search-path '("~/code/"))
  :config (projectile-mode 1))

(use-package counsel-projectile)

(defun goto-user-init-file ()
  (interactive)
  (find-file user-init-file))

(use-package yasnippet
  :config (yas-global-mode))

(use-package flycheck
  :config (flycheck-mode))

(use-package lsp-mode
  :custom
  (lsp-idle-delay 0.1)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-completion-provider :capf)
  (lsp-semantic-highlighting t)
  (lsp-signature-auto-activate t)
  (lsp-modeline-diagnostics-enable t))

(use-package lsp-ui :commands lsp-ui-mode)

(use-package all-the-icons)

(use-package treemacs-evil)

(use-package treemacs
  :custom (treemacs-position 'right))

(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(defun compile-example ()
  (interactive)
  (compile "cd ~/code/lang; zig build run -Drelease-fast -- examples/main.lang; echo \"\nrunning program\n\" && temp/code; echo \"\nexit code $?\""))

(general-nmap
  :prefix "SPC"
  "p" 'counsel-projectile-switch-project
  "f" 'counsel-projectile-find-file
  "g" 'counsel-projectile-git-grep
  "." 'counsel-find-file
  "i" 'goto-user-init-file
  "b" 'counsel-switch-buffer
  "x" 'counsel-M-x
  "e" 'treemacs
  "v" 'magit
  "s" 'eshell
  "T" 'counsel-load-theme
  "t" '(nil :which-key "test")
  "r" 'lsp-rename
  "d" 'dap-hydra
  "z" 'compile-example
  "c" 'recompile
  "C" 'compile)

(general-define-key
 :keymaps 'normal
 :prefix "g"
 "b" 'evil-jump-backward
 "d" 'lsp-ui-peek-find-definitions
 "r" 'lsp-ui-peek-find-references
 "c" 'comment-line)

(general-define-key
 :keymaps 'visual
 :prefix "g"
 "c" 'comment-or-uncomment-region)

(general-define-key
 :keymaps 'company-active-map
 "C-n" 'company-select-next-or-abort
 "C-p" 'company-select-previous-or-abort)

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package evil-cleverparens
  :custom
  (evil-cleverparens-use-s-and-S nil)
  (evil-cleverparens-use-additional-movement-keys nil)
  :hook ((emacs-lisp-mode . evil-cleverparens-mode)))

(use-package adjust-parens
  :hook ((emacs-lisp-mode . adjust-parens-mode)))

(general-define-key
 :keymaps 'emacs-lisp-mode-map
 "TAB" 'list-indent-adjust-parens
 "<backtab>" 'lisp-dedent-adjust-parens)

(use-package ivy
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t)
  :config (ivy-mode 1))

(use-package ivy-rich
  :init (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  :config (ivy-rich-mode 1))

(use-package ivy-posframe
  :custom
  (ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
  :config (ivy-posframe-mode 1))

(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

(use-package vterm)

(use-package xterm-color
  :custom (compilation-environment '("TERM=xterm-256color"))
  :config (advice-add 'compilation-filter :around
		      (lambda (f proc string)
			(funcall f proc (xterm-color-filter string)))))

(use-package rust-mode
  :hook ((rust-mode . lsp))
  :config
  (add-hook 'before-save-hook
	    (lambda () (when (eq 'rust-mode major-mode) (lsp-format-buffer)))))

(general-nmap
  :prefix "SPC t"
  :keymaps 'rust-mode-map
  "l" 'recompile)

(use-package zig-mode
  :hook ((zig-mode . lsp))
  :custom (zig-format-on-save nil)
  :init
  (add-to-list 'lsp-language-id-configuration '(zig-mode . "zig"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "zls")
    :major-modes '(zig-mode)
    :server-id 'zls))
  :config 
  (add-hook 'before-save-hook
	    (lambda () (when (eq 'zig-mode major-mode) (lsp-format-buffer)))))

(defun zig-test-suite ()
  (interactive)
  (compile (concat "cd " (lsp-workspace-root) " && zig build test")))

(defun zig-test-file-string ()
  (let* ((root (lsp-workspace-root))
	 (name (file-name-nondirectory root))
	 (test-name (file-relative-name (buffer-file-name) root)))
    (concat "cd " root " && zig test -femit-bin=temp/output --pkg-begin " name " src/" name ".zig " test-name)))

(defun zig-test-file ()
  (interactive)
  (compile (zig-test-file-string)))

(defun zig-test-nearest ()
  (interactive)
  (let* ((symbols (lsp--get-document-symbols))
	 (line-number (line-number-at-pos))
	 (nearest-test (->> symbols
			    (-filter
			     (lambda (symbol)
			       (let* ((range (gethash "range" symbol))
				      (start-line (->> range (gethash "start") (gethash "line")))
				      (end-line (->> range (gethash "end") (gethash "line"))))
				 (<= start-line line-number end-line))))
			    (car))))
    (if nearest-test
	(let ((name (gethash "name" nearest-test)))
	  (setq zig-last-run-test-file (buffer-file-name)
		zig-last-run-test-line line-number)
	  (compile (concat (zig-test-file-string) " --test-filter \"" name "\"")))
      (message "Cursor is not in a test block"))))

(defun zig-test-visit ()
  (interactive)
  (find-file zig-last-run-test-file)
  (goto-line zig-last-run-test-line))

(general-nmap
  :prefix "SPC t"
  :keymaps 'zig-mode-map
  "s" 'zig-test-suite
  "f" 'zig-test-file
  "n" 'zig-test-nearest
  "l" 'recompile
  "v" 'zig-test-visit)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
			 (lsp))))

(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  (doom-themes-treemacs-theme "doom-colors")
  :config
  (load-theme 'doom-moonlight t)
  (doom-themes-org-config)
  (doom-themes-treemacs-config))

(use-package doom-modeline
  :custom (doom-modeline-project-detection 'relative-from-project)
  :config (doom-modeline-mode 1))

(use-package org-bullets
  :hook ((org-mode . org-bullets-mode)))

(use-package clojure-mode)

(use-package dired-single)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(general-nmap
  :keymaps 'dired-mode-map
  "h" 'dired-single-up-directory
  "l" 'dired-single-buffer)

(use-package dap-mode
  :init
  (add-hook 'dap-stopped-hook
    (lambda (arg) (call-interactively #'dap-hydra)))
  :config (dap-auto-configure-mode 1))


(require 'dap-codelldb)


(dap-register-debug-template "Debug Zig"
  (list :type "codelldb"
        :request "launch"
        :program "temp/output"
        :args '("/Users/adamkowalski/zig/build/zig")
        :cwd "/Users/adamkowalski/code/lang"
        :externalConsole nil
        :name "Debug Zig"))
