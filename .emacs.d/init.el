(setq gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024)
      auto-save-default nil
      make-backup-files nil
      create-lockfiles nil
      frame-resize-pixelwise t
      display-line-numbers-type 'relative
      ring-bell-function 'ignore)


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
(global-display-line-numbers-mode)


(set-face-attribute 'default nil
                    :family "MesloLGS NF"
                    :height 160
                    :weight 'normal
                    :width 'normal)


(use-package all-the-icons
  :ensure t)


(use-package doom-themes
  :ensure t
  :init
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t
	doom-themes-treemacs-theme "doom-colors")
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))


(use-package doom-modeline
  :ensure t
  :config (doom-modeline-mode 1))


(use-package evil
  :ensure t
  :init (setq evil-want-C-u-scroll t)
  :config (evil-mode 1))


(use-package company
  :ensure t
  :init
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.0
	company-backends '(company-capf company-files))
  :config (global-company-mode 1))


(use-package company-capf
  :ensure t)


(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))


(use-package ivy
  :ensure t
  :config (ivy-mode 1))


(use-package projectile
  :ensure t
  :init (setq projectile-project-search-path '("~/code/"))
  :config (projectile-mode))


(use-package counsel-projectile
  :after '(ivy projectile)
  :ensure t)


(use-package general
  :ensure t
  :config (general-override-mode))


(use-package which-key
  :ensure t
  :config (which-key-mode))


(use-package lsp-mode
  :ensure t
  :hook ((c++-mode . lsp-deferred))
  :commands (lsp lsp-deferred)
  :init (setq lsp-prefer-capf t))


(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)


(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)


(use-package lsp-treemacs
  :ensure t)


(use-package modern-cpp-font-lock
  :ensure t
  :hook ((c++-mode . modern-c++-font-lock-mode)))


(use-package key-chord
  :ensure t
  :config (key-chord-mode 1))


(use-package flycheck
  :ensure t)


(use-package magit
  :ensure t)


(use-package evil-magit
  :ensure t)


(use-package treemacs
  :ensure t)


(use-package treemacs-evil
  :ensure t)


(use-package avy
  :ensure t)


(defun find-user-init-file ()
  (interactive)
  (find-file user-init-file))


(add-hook 'c++-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "cd %s/build && conan build .." (projectile-project-root)))))


(general-define-key
 :states 'motion
 ";" 'evil-ex
 ":" 'avy-goto-char)


(general-define-key :keymaps 'evil-insert-state-map
                    (general-chord "jk") 'evil-normal-state)


(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 :prefix "SPC"
 "." 'find-file
 "x" 'execute-extended-command
 "b" 'switch-to-buffer
 "p" 'counsel-projectile-switch-project
 "f" 'counsel-projectile-find-file
 "g" 'counsel-projectile-rg
 "i" 'find-user-init-file
 "t" 'treemacs
 "d" 'recompile
 "D" 'compile
 "m" 'magit
 "s" 'eshell)


(general-define-key
 :states '(visual emacs)
 :keymaps 'override
 :prefix "SPC"
 "c" 'comment-or-uncomment-region)


(general-define-key
 :states '(normal emacs)
 :keymaps 'override
 :prefix "SPC"
 "c" 'comment-line)


(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 :prefix ","
 "d" 'dap-hydra
 "p" 'dap-debug)


(general-define-key
 :states '(normal visual insert emacs)
 :keymaps 'override
 "C-h" 'evil-window-left
 "C-j" 'evil-window-down
 "C-k" 'evil-window-up
 "C-l" 'evil-window-right)
 

(general-define-key
 :states '(normal emacs)
 :keymaps 'override
 :prefix "g"
 "d" 'lsp-ui-peek-find-definitions
 "r" 'lsp-ui-peek-find-references
 "s" 'lsp-ivy-global-workspace-symbol
 "b" 'evil-jump-backward)


(use-package posframe
  :ensure t)


(use-package dap-mode
  :ensure t
  :config
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1))


(use-package cmake-mode
  :ensure t)


(use-package auto-package-update
  :ensure t)


(defun my-c++-mode-before-save-hook ()
  (when (eq major-mode 'c++-mode)
    (lsp-format-buffer)))


(add-hook 'before-save-hook #'my-c++-mode-before-save-hook)


(dap-register-debug-provider
 "cppdbg"
 (lambda (conf)
   (plist-put conf
              :dap-server-path
              '("/Users/adamkowalski/.vscode-insiders/extensions/ms-vscode.cpptools-0.28.0-insiders/debugAdapters/OpenDebugAD7"))
   conf))


(dap-register-debug-template "C++ Run Configuration"
                             (list :type "cppdbg"
                                   :cwd "/Users/adamkowalski/code/omega/build/bin"
                                   :request "launch"
                                   :program "/Users/adamkowalski/code/omega/build/bin/test_omega"
				   :externalTerminal :json-false
				   :MIMode "lldb"
				   :name "Debug Test"))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7f6d4aebcc44c264a64e714c3d9d1e903284305fd7e319e7cb73345a9994f5ef" default))
 '(package-selected-packages
   '(doom-themes damage-doom-themes treemacs-evil auto-package-update cmake-mode posframe dap-mode spinner evil-magit magit flycheck key-chord modern-cpp-font-lock lsp-ivy lsp-ui lsp-mode which-key general counsel-projectile projectile ivy exec-path-from-shell company evil doom-modeline all-the-icons use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
