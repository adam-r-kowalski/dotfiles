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
  (load-theme 'doom-challenger-deep t)
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
 '(ansi-color-names-vector
   ["#5a5475" "#CC6666" "#C2FFDF" "#FFEA00" "#55b3cc" "#FFB8D1" "#96CBFE" "#F8F8F0"])
 '(custom-safe-themes
   '("7d708f0168f54b90fc91692811263c995bebb9f68b8b7525d0e2200da9bc903c" "fa3bdd59ea708164e7821574822ab82a3c51e262d419df941f26d64d015c90ee" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "d5f8099d98174116cba9912fe2a0c3196a7cd405d12fa6b9375c55fc510988b5" "7f791f743870983b9bb90c8285e1e0ba1bf1ea6e9c9a02c60335899ba20f3c94" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "e964832f274625fa45810c688bdbe18caa75a5e1c36b0ca5ab88924756e5667f" "c83c095dd01cde64b631fb0fe5980587deec3834dc55144a6e78ff91ebc80b19" "1ed5c8b7478d505a358f578c00b58b430dde379b856fbcb60ed8d345fc95594e" "6231254e74298a1cf8a5fee7ca64352943de4b495e615c449e9bb27e2ccae709" "56911bd75304fdb19619c9cb4c7b0511214d93f18e566e5b954416756a20cc80" "4e764943cc022ba136b80fa82d7cdd6b13a25023da27528a59ac61b0c4f1d16f" "6bacece4cf10ea7dd5eae5bfc1019888f0cb62059ff905f37b33eec145a6a430" "24132f7b6699c6e0118d742351b74141bac3c4388937e40db9207554eaae78c9" "1526aeed166165811eefd9a6f9176061ec3d121ba39500af2048073bea80911e" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "d71aabbbd692b54b6263bfe016607f93553ea214bc1435d17de98894a5c3a086" "3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "9b01a258b57067426cc3c8155330b0381ae0d8dd41d5345b5eddac69f40d409b" "8a0c35b74b0407ca465dd8db28c9136d5f539868d4867565ee214ac85ceb0d3a" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" "7f6d4aebcc44c264a64e714c3d9d1e903284305fd7e319e7cb73345a9994f5ef" default))
 '(fci-rule-color "#B8A2CE")
 '(jdee-db-active-breakpoint-face-colors (cons "#464258" "#C5A3FF"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#464258" "#C2FFDF"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#464258" "#656565"))
 '(objed-cursor-color "#CC6666")
 '(package-selected-packages
   '(doom-themes damage-doom-themes treemacs-evil auto-package-update cmake-mode posframe dap-mode spinner evil-magit magit flycheck key-chord modern-cpp-font-lock lsp-ivy lsp-ui lsp-mode which-key general counsel-projectile projectile ivy exec-path-from-shell company evil doom-modeline all-the-icons use-package))
 '(pdf-view-midnight-colors (cons "#F8F8F0" "#5a5475"))
 '(rustic-ansi-faces
   ["#5a5475" "#CC6666" "#C2FFDF" "#FFEA00" "#55b3cc" "#FFB8D1" "#96CBFE" "#F8F8F0"])
 '(vc-annotate-background "#5a5475")
 '(vc-annotate-color-map
   (list
    (cons 20 "#C2FFDF")
    (cons 40 "#d6f894")
    (cons 60 "#eaf14a")
    (cons 80 "#FFEA00")
    (cons 100 "#f6dc00")
    (cons 120 "#eece00")
    (cons 140 "#E6C000")
    (cons 160 "#eebd45")
    (cons 180 "#f6ba8b")
    (cons 200 "#FFB8D1")
    (cons 220 "#ee9cad")
    (cons 240 "#dd8189")
    (cons 260 "#CC6666")
    (cons 280 "#b26565")
    (cons 300 "#986565")
    (cons 320 "#7e6565")
    (cons 340 "#B8A2CE")
    (cons 360 "#B8A2CE")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
