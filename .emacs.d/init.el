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
  :custom
  (evil-want-C-u-scroll t)
  (evil-want-keybinding nil)
  :config (evil-mode))


(use-package company
  :straight t
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  :config
  (global-company-mode))


(use-package general :straight t)


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


(use-package company-box
  :straight t
  :hook (company-mode . company-box-mode))


(use-package all-the-icons-dired
  :straight t)


(use-package lsp-mode
  :straight t
  :custom
  (lsp-prefer-capf t)
  (lsp-semantic-highlighting t)
  (lsp-lens-auto-enable t)
  (lsp-headerline-breadcrumb-enable t)
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
  :config (lsp-treemacs-sync-mode 1)
  :commands lsp-treemacs-errors-list)


(use-package lsp-ivy
  :straight t
  :commands lsp-ivy-workspace-symbol)


(use-package lsp-python-ms
  :straight t
  :custom (lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                          (require 'lsp-python-ms)
                          (lsp))))



(use-package dap-mode
  :straight t)


(use-package exec-path-from-shell
  :straight t
  :custom (exec-path-from-shell-variables '("PATH" "MANPATH" "CC"))
  :config (exec-path-from-shell-initialize))


(use-package ivy
  :straight t
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t)
  (ivy-magic-slash-non-match-action nil)
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
  (load-theme 'doom-henna t)
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


(use-package evil-escape
  :straight t
  :custom (evil-escape-key-sequence "jk")
  :config (evil-escape-mode))


(use-package evil-collection
  :straight t
  :custom (evil-collection-company-use-tng nil)
  :config (evil-collection-init))


(use-package smartparens
  :straight t
  :config
  (smartparens-global-mode)
  (smartparens-strict-mode))


(use-package evil-cleverparens
  :straight t
  :hook (emacs-lisp-mode . evil-cleverparens-mode))


(use-package zig-mode
  :straight t
  :hook (zig-mode . (lambda () (lsp)))
  :config 
  (add-to-list 'lsp-language-id-configuration '(zig-mode . "zig"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "zls")
    :major-modes '(zig-mode)
    :server-id 'zls)))


(defun my-before-save-hook ()
  (when (eq major-mode 'c++-mode)
    (lsp-format-buffer)))


(add-hook 'before-save-hook #'my-before-save-hook)


(general-def 'motion ";" 'evil-ex)


(defun find-user-init ()
  (interactive)
  (find-file user-init-file))


(defun disable-all-themes ()
  (dolist (i custom-enabled-themes)
    (disable-theme i)))


(defun switch-theme ()
  (interactive)
  (disable-all-themes)
  (counsel-load-theme))


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
 "T" 'switch-theme
 "l" 'lsp-avy-lens
 "c" 'recompile 
 "C" 'compile 
 "d" '(nil :which-key "debug")
 "t" '(nil :which-key "test")
 "h" '(nil :which-key "help"))


(general-define-key
 :states '(normal emacs)
 :keymaps 'override
 :prefix "g"
 "c" 'comment-line)


(general-define-key
 :states '(visual emacs)
 :keymaps 'override
 :prefix "g"
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
 :prefix "g"
 "h" 'lsp-ui-doc-glance
 "H" 'lsp-ui-doc-focus-frame
 "d" 'lsp-ui-peek-find-definitions
 "r" 'lsp-ui-peek-find-references
 "s" 'lsp-ivy-global-workspace-symbol
 "b" 'evil-jump-backward)


(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 "C-h" 'evil-window-left
 "C-j" 'evil-window-down
 "C-k" 'evil-window-up
 "C-l" 'evil-window-right)


(general-define-key
 :keymaps 'company-active-map
 "C-n" 'company-select-next-or-abort
 "C-p" 'company-select-previous-or-abort
 "<tab>" 'company-select-next-or-abort
 "S-<tab>" 'company-select-previous-or-abort)


(defun dap-cppdbg--debug-test-at-point ()
  (interactive)
  (dap-debug (dap--template "cppdbg :: Debug test (at point)")))


(defun dap-cppdbg--populate-test-at-point (conf)
  "Populate CONF with the required arguments."
  (let ((cwd (lsp-workspace-root)))
    (plist-put conf :dap-server-path
	       '("/Users/adamkowalski/.vscode-insiders/extensions/ms-vscode.cpptools-0.28.3/debugAdapters/OpenDebugAD7"))
    (plist-put conf :cwd cwd)
    (plist-put conf :request "launch")
    (plist-put conf :program (concat cwd "/zig-cache/o/GmcdCX-JXuVXc1CpbdOb81ACFNuOWE8R9K2CkHnfgAAxMfVczhgcHpQbPdBqpUs6/test"))
    (plist-put conf :externalTerminal :json-false)
    (plist-put conf :MIMode "lldb")
    conf))


(dap-register-debug-provider "cppdbg" 'dap-cppdbg--populate-test-at-point)
(dap-register-debug-template "cppdgb :: Debug test (at point)"
			     (list :type "cppdbg"
				   :name "cppdbg :: Debug test (at point)"))

