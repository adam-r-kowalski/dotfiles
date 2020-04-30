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
	doom-themes-enable-italic t)
  :config (load-theme 'doom-one t))


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
	company-backends '(company-capf))
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


(defun find-user-init-file ()
  (interactive)
  (find-file user-init-file))


(add-hook 'c++-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "cd %s/build && conan build .." (projectile-project-root)))))


(general-swap-key nil 'motion
  ";" ":")


(general-define-key :keymaps 'evil-insert-state-map
                    (general-chord "jk") 'evil-normal-state)


(general-define-key
 :states '(normal emacs)
 :keymaps 'override
 :prefix "SPC"
 "." 'find-file
 "x" 'execute-extended-command
 "b" 'switch-to-buffer
 "p" 'counsel-projectile-switch-project
 "f" 'counsel-projectile-find-file
 "g" 'counsel-projectile-rg
 "i" 'find-user-init-file
 "d" 'recompile
 "D" 'compile
 "m" 'magit
 "s" 'eshell)


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
 "s" 'lsp-ui-peek-find-workspace-symbol
 "b" 'evil-jump-backward)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#222222" "#fc618d" "#7bd88f" "#fce566" "#5ad4e6" "#5ad4e6" "#5ad4e6" "#f7f1ff"])
 '(custom-safe-themes
   '("7c4cfa4eb784539d6e09ecc118428cd8125d6aa3053d8e8413f31a7293d43169" "d71aabbbd692b54b6263bfe016607f93553ea214bc1435d17de98894a5c3a086" "d74c5485d42ca4b7f3092e50db687600d0e16006d8fa335c69cf4f379dbd0eee" "24132f7b6699c6e0118d742351b74141bac3c4388937e40db9207554eaae78c9" "8a0c35b74b0407ca465dd8db28c9136d5f539868d4867565ee214ac85ceb0d3a" "58c3313b4811ed8b30239b1d04816f74d438bcb72626d68181f294b115b7220d" "d5f8099d98174116cba9912fe2a0c3196a7cd405d12fa6b9375c55fc510988b5" "f2b56244ecc6f4b952b2bcb1d7e517f1f4272876a8c873b378f5cf68e904bd59" "f9cae16fd084c64bf0a9de797ef9caedc9ff4d463dd0288c30a3f89ecf36ca7e" "e964832f274625fa45810c688bdbe18caa75a5e1c36b0ca5ab88924756e5667f" "1ed5c8b7478d505a358f578c00b58b430dde379b856fbcb60ed8d345fc95594e" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "fa3bdd59ea708164e7821574822ab82a3c51e262d419df941f26d64d015c90ee" "845103fcb9b091b0958171653a4413ccfad35552bc39697d448941bcbe5a660d" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" default))
 '(fci-rule-color "#585858")
 '(jdee-db-active-breakpoint-face-colors (cons "#131313" "#fce566"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#131313" "#7bd88f"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#131313" "#525053"))
 '(modern-c++-font-lock-global-mode t)
 '(objed-cursor-color "#fc618d")
 '(package-selected-packages
   '(evil-magit magit flycheck key-chord modern-cpp-font-lock lsp-ivy lsp-ui lsp-mode counsel-projectile general which-key ivy use-package exec-path-from-shell evil doom-themes doom-modeline dashboard company))
 '(pdf-view-midnight-colors (cons "#f7f1ff" "#222222"))
 '(rustic-ansi-faces
   ["#222222" "#fc618d" "#7bd88f" "#fce566" "#5ad4e6" "#5ad4e6" "#5ad4e6" "#f7f1ff"])
 '(vc-annotate-background "#222222")
 '(vc-annotate-color-map
   (list
    (cons 20 "#7bd88f")
    (cons 40 "#a6dc81")
    (cons 60 "#d1e073")
    (cons 80 "#fce566")
    (cons 100 "#fcc95f")
    (cons 120 "#fcae59")
    (cons 140 "#fd9353")
    (cons 160 "#c6a884")
    (cons 180 "#90beb5")
    (cons 200 "#5ad4e6")
    (cons 220 "#90adc8")
    (cons 240 "#c687aa")
    (cons 260 "#fc618d")
    (cons 280 "#d15c7e")
    (cons 300 "#a75870")
    (cons 320 "#7c5461")
    (cons 340 "#585858")
    (cons 360 "#585858")))
 '(vc-annotate-very-old-color nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
