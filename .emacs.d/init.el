(defvar bootstrap-version)
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
  (load bootstrap-file nil 'nomessage))


(straight-use-package 'use-package)


(menu-bar-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)


(setq frame-resize-pixelwise t
      make-backup-files nil
      auto-save-default nil
      ring-bell-function 'ignore
      create-lockfiles nil
      inhibit-splash-screen t
      gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024))


(setq-default display-line-numbers 'relative)


(defalias 'yes-or-no-p 'y-or-n-p)


(set-face-attribute 'default nil
    :family "RobotoMono Nerd Font"
    :height 160
    :weight 'normal
    :width 'normal)


(use-package evil
  :straight t
  :custom (evil-want-C-u-scroll t)
  :config (evil-mode))


(use-package company
  :straight t
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  :config
  (company-tng-configure-default)
  (global-company-mode))


(use-package general :straight t)


(use-package key-chord
  :straight t
  :config (key-chord-mode 1))


(use-package projectile
  :straight t
  :custom
  (projectile-project-search-path '("~/code/"))
  (projectile-completion-system 'ivy)
  :config (projectile-global-mode))


(use-package which-key
  :straight t
  :config (which-key-mode))


(use-package all-the-icons
  :straight t
  :hook (dired-mode . all-the-icons-dired-mode))


(use-package all-the-icons-dired
  :straight t)


(use-package lsp-mode
  :straight t
  :custom
  (lsp-prefer-capf t)
  (lsp-semantic-highlighting t)
  :commands lsp)


(use-package lsp-ui
  :straight t
  :custom (lsp-ui-doc-enable nil)
  :commands lsp-ui-mode)


(use-package treemacs
  :straight t)


(use-package treemacs-evil
  :straight t)


(use-package lsp-treemacs
  :straight t
  :config (lsp-treemacs-sync-mode 1))


(use-package dap-mode
  :straight t)


(use-package rustic
  :straight t
  :init
  (setq rustic-lsp-server 'rust-analyzer)
  :hook (rust-mode . lsp))


(use-package exec-path-from-shell
  :straight t
  :if (memq window-system '(mac ns))
  :config (exec-path-from-shell-initialize))


(use-package ivy
  :straight t
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t)
  :config (ivy-mode 1))


(use-package counsel-projectile
  :straight t)


(use-package flycheck
  :straight t)


(use-package doom-themes
  :straight t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  (doom-themes-treemacs-theme "doom-colors")
  :config
  (load-theme 'doom-gruvbox t)
  (doom-themes-org-config)
  (doom-themes-treemacs-config))


(use-package doom-modeline
  :straight t
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  :config
  (display-battery-mode 1)
  (display-time-mode 1)
  (doom-modeline-mode 1))


(use-package avy
  :straight t)


(use-package magit
  :straight t)


(use-package evil-magit
  :straight t)


(use-package vterm
  :straight t)


(defun my-before-save-hook ()
  (when (eq major-mode 'rustic-mode)
    (lsp-format-buffer)))


(add-hook 'before-save-hook #'my-before-save-hook)


(general-def 'motion ";" 'evil-ex)


(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)


(defun find-user-init ()
  (interactive)
  (find-file user-init-file))


(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 :prefix "SPC"
 "SPC" 'avy-goto-char
 "." 'find-file
 "i" 'find-user-init
 "p" 'projectile-switch-project
 "f" 'projectile-find-file
 "g" 'counsel-projectile-rg
 "b" 'switch-to-buffer
 "x" 'execute-extended-command
 "m" 'magit
 "s" 'eshell
 "S" 'vterm
 "e" 'treemacs
 "d" '(nil :which-key "debug")
 "t" '(nil :which-key "test")
 "h" '(nil :which-key "help"))


(general-define-key
 :states '(normal emacs)
 :keymaps 'override
 :prefix "SPC"
 "c" 'comment-line)


(general-define-key
 :states '(visual emacs)
 :keymaps 'override
 :prefix "SPC"
 "c" 'comment-or-uncomment-region)


(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 :prefix "SPC d"
 "h" 'dap-hydra
 "r" 'dap-debug-recent
 "l" 'dap-debug-last
 "d" 'dap-debug)


(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 :prefix "SPC h"
 "k" 'describe-key
 "v" 'describe-variable)


(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 :prefix "SPC t"
 "s" 'rustic-cargo-test
 "n" 'rustic-cargo-current-test
 "l" 'rustic-recompile
 "c" 'rustic-compile)


(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 :prefix "g"
 "h" 'lsp-ui-doc-glance
 "d" 'lsp-ui-peek-find-definitions
 "r" 'lsp-ui-peek-find-references
 "b" 'evil-jump-backward)


(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 "C-h" 'evil-window-left
 "C-j" 'evil-window-down
 "C-k" 'evil-window-up
 "C-l" 'evil-window-right)







(defun dap-cppdbg--debug-test-at-point ()
  (interactive)
  (dap-debug (dap--template "Rust :: Debug test (at point)")))


(defun dap-cppdbg--populate-test-at-point (conf)
  "Populate CONF with the required arguments."
  (let ((cwd (lsp-workspace-root)))
    (plist-put conf :dap-server-path
	       '("/Users/adamkowalski/.vscode-insiders/extensions/ms-vscode.cpptools-0.28.0-insiders/debugAdapters/OpenDebugAD7"))
    (plist-put conf :cwd cwd)
    (plist-put conf :request "launch")
    (plist-put conf :program (concat cwd "/target/debug/deps/test_parser-3aef394e7183e621"))
    (plist-put conf :externalTerminal :json-false)
    (plist-put conf :MIMode "lldb")
    (plist-put conf :args '("--test" "parse_local_define"))
    conf))


(dap-register-debug-provider "cppdbg" 'dap-cppdbg--populate-test-at-point)
(dap-register-debug-template "Rust :: Debug test (at point)"
			     (list :type "cppdbg"
				   :name "Rust :: Debug test (at point)"))
