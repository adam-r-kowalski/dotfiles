(setq read-process-output-max (* 1024 1024))

(set-face-attribute 'default nil :height 160 :font "RobotoMono Nerd Font")


(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(eval-when-compile
  (require 'use-package))


(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq frame-resize-pixelwise t
      make-backup-files nil
      auto-save-default nil
      inhibit-startup-screen t
      ring-bell-function 'ignore)

(menu-bar--display-line-numbers-mode-relative)
(global-display-line-numbers-mode)


(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))


(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t
	evil-want-integration t
	evil-want-keybinding nil)
  :config (evil-mode 1))


(use-package evil-collection
  :after evil
  :ensure t
  :init (setq evil-collection-company-use-tng nil)
  :config (evil-collection-init))


(use-package doom-themes
  :ensure t
  :init
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t
	doom-themes-treemacs-theme "doom-colors")
  :config
  (load-theme 'doom-nord t)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))


(use-package doom-modeline
  :ensure t
  :config (doom-modeline-mode 1))


(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))


(use-package all-the-icons
  :ensure t)


(use-package company
  :ensure t
  :init
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0)
  :config
  (global-company-mode))



(use-package company-box
  :hook (company-mode . company-box-mode)
  :init (setq company-box-icons-alist 'company-box-icons-all-the-icons))


(use-package key-chord
  :ensure t
  :config (key-chord-mode 1))


(use-package general
  :ensure t
  :config (general-evil-setup))


(use-package swiper
  :ensure t
  :init (setq ivy-use-virtual-buffers t
	      ivy-count-format "(%d/%d) ")
  :config (ivy-mode 1))


(use-package ivy-posframe
  :ensure t
  :init (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  :config (ivy-posframe-mode 1))


(use-package which-key
  :ensure t
  :config (which-key-mode))


(use-package lsp-mode
  :ensure t
  :init (setq lsp-auto-guess-root t)
  :hook (c++-mode . lsp-deferred))


(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)


(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

(use-package company-lsp
  :ensure t
  :init (setq company-lsp-cache-candidates 'auto
	      company-lsp-async t
	      company-lsp-enable-snippet t
	      company-lsp-enable-recompletion t)
  :config (push 'company-lsp company-backends))


(use-package treemacs
  :ensure t)


(use-package lsp-treemacs
  :ensure t
  :config (lsp-treemacs-sync-mode 1))


(use-package posframe
  :ensure t)


(use-package dap-mode
  :ensure t
  :config
  (require 'dap-lldb)
  (require 'dap-python)
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1))


(use-package projectile
  :ensure t
  :init (setq projectile-project-search-path '("~/code/"))
  :config (projectile-mode +1))


(use-package counsel-projectile
  :ensure t)


(use-package flycheck
  :ensure t)


(use-package magit
  :ensure t)


(use-package avy
  :ensure t)


(use-package beacon
  :ensure t
  :config (beacon-mode 1))


(defun c++-mode-before-save-hook ()
  (when (eq major-mode 'c++-mode)
    (lsp-format-buffer)))


(add-hook 'before-save-hook #'c++-mode-before-save-hook)


(general-define-key
 :keymaps 'evil-insert-state-map
 (general-chord "jk") 'evil-normal-state)


(general-swap-key nil 'motion
  ";" ":")


(defun find-user-init-file ()
  (interactive)
  (find-file user-init-file))
 

(general-define-key
 :keymaps '(normal emacs visual)
 :prefix "SPC"
 "." 'find-file
 "f" 'counsel-projectile-find-file
 "p" 'counsel-projectile-switch-project
 "g" 'counsel-projectile-rg
 "b" 'counsel-switch-buffer
 "x" 'execute-extended-command
 "i" 'find-user-init-file
 "h" '(nil :which-key "help")
 "t" 'treemacs
 "E" 'compile
 "e" 'recompile
 "m" 'magit
 "SPC" 'avy-goto-char
 "d" 'dap-hydra
 "l" 'dap-debug-last
 "L" 'dap-debug
 "s" 'eshell)


(general-define-key
 :keymaps '(normal emacs)
 :prefix "SPC"
 "c" 'comment-line)


(general-define-key
 :keymaps '(visual emacs)
 :prefix "SPC"
 "c" 'comment-or-uncomment-region)


(general-define-key
 :keymaps '(normal emacs visual)
 :prefix "SPC h"
 "k" 'describe-key
 "v" 'describe-variable)


(general-define-key
 :states '(normal insert emacs visual)
 "C-h" 'evil-window-left
 "C-j" 'evil-window-down
 "C-k" 'evil-window-up
 "C-l" 'evil-window-right)


(general-define-key
 :keymaps '(normal emacs visual)
 :prefix "g"
 "d" 'lsp-ui-peek-find-definitions
 "r" 'lsp-ui-peek-find-references
 "i" 'lsp-ui-peek-find-implementation
 "s" 'lsp-ivy-workspace-symbol
 "b" 'evil-jump-backward)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "229c5cf9c9bd4012be621d271320036c69a14758f70e60385e87880b46d60780" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" default))
 '(package-selected-packages
   '(beacon magit ivy-posframe doom-modeline dap-lldb posframe flycheck yasnippet all-the-icons company-box counsel-projectile projectile lsp-ivy company-lsp lsp-ui dap-mode lsp-mode sublimity exec-path-from-shell vterm which-key company swiper key-chord general use-package evil)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
