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
      inhibit-startup-screen t)


(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))


(use-package evil
  :ensure t
  :init (setq evil-want-C-u-scroll t)
  :config (evil-mode 1))


(use-package nord-theme
  :ensure t
  :config (load-theme 'nord t))


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


(use-package dap-mode
  :ensure t
  :config
  (require 'dap-gdb-lldb)
  (dap-gdb-lldb-setup))


(use-package projectile
  :ensure t
  :init (setq projectile-project-search-path '("~/code/"))
  :config (projectile-mode +1))


(use-package counsel-projectile
  :ensure t)


(use-package flycheck
  :ensure t)


(general-define-key
 :keymaps 'evil-insert-state-map
 (general-chord "jk") 'evil-normal-state)


(general-swap-key nil 'motion
  ";" ":")


(defun find-user-init-file ()
  (interactive)
  (find-file user-init-file))
 

(general-define-key
 :keymaps '(normal emacs)
 :prefix "SPC"
 "." 'find-file
 "f" 'counsel-projectile-find-file
 "p" 'counsel-projectile-switch-project
 "g" 'counsel-projectile-rg
 "b" 'counsel-buffer-or-recentf
 "x" 'execute-extended-command
 "i" 'find-user-init-file
 "h" '(nil :which-key "help")
 "t" 'treemacs)


(general-define-key
 :keymaps '(normal emacs)
 :prefix "SPC h"
 "k" 'describe-key
 "v" 'describe-variable)


(general-define-key
 :states '(normal insert emacs)
 "C-h" 'evil-window-left
 "C-j" 'evil-window-down
 "C-k" 'evil-window-up
 "C-l" 'evil-window-right)


(general-define-key
 :keymaps '(normal emacs)
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
 '(package-selected-packages
   '(dap-gdb-lldb flycheck yasnippet all-the-icons company-box counsel-projectile projectile lsp-ivy company-lsp lsp-ui dap-mode lsp-mode sublimity exec-path-from-shell vterm which-key company swiper key-chord general nord-theme use-package evil)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
