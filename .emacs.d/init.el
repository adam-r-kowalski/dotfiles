(setq gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024)
      auto-save-default nil
      make-backup-files nil
      create-lockfiles nil
      frame-resize-pixelwise t
      display-line-numbers-type 'relative
      ring-bell-function 'ignore
      straight-use-package-by-default t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode)
(display-time-mode)
(show-paren-mode 1)

(let ((family "FiraMono Nerd Font")
      (height 160))
  (set-face-attribute 'default nil :family family :height height :weight 'normal :width 'normal)
  (set-face-attribute 'mode-line nil :family family :height height)
  (set-face-attribute 'mode-line-inactive nil :family family :height height))

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

(use-package evil
  :init
  (setq evil-want-C-u-scroll t
	evil-echo-state nil
	evil-want-keybinding nil)
  :config (evil-mode))

(use-package evil-collection
  :config (evil-collection-init))

(use-package company
  :init
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.0
	company-backends '(company-capf company-files))
  :config (global-company-mode 1))

(use-package all-the-icons)

(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t
	doom-themes-treemacs-theme "doom-colors")
  :config
  (load-theme 'gruvbox-material t)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :init
  (setq doom-modeline-icon (display-graphic-p)
	doom-modeline-buffer-file-name-style 'truncate-with-project
	doom-modeline-buffer-encoding nil
	doom-modeline-lsp nil
	doom-modeline-minor-modes nil
	doom-modeline-height 25)
  :config
  (display-battery-mode)
  (doom-modeline-mode 1))

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(use-package ivy :config (ivy-mode 1))

(use-package projectile
  :init (setq projectile-project-search-path '("~/code/"))
  :config (projectile-mode))

(use-package counsel-projectile
  :after (counsel projectile)
  :commands (counsel-projectile-find-file
	     counsel-projectile-switch-project
	     counsel-projectile-rg))

(use-package general :config (general-override-mode))

(use-package which-key :config (which-key-mode))

(use-package treemacs
  :init (setq treemacs-lock-width nil
	      treemacs--width-is-locked nil)
  :commands treemacs)

(use-package lsp-mode
  :commands lsp-deferred
  :init
  (setq lsp-prefer-capf t
	lsp-semantic-highlighting 'immediate))

(use-package lsp-ui :commands lsp-ui-mode)

(use-package lsp-ivy
  :after ivy
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-treemacs :after treemacs)

(defun lsp-python-mode-hook ()
  (require 'lsp-python-ms)
  (lsp-deferred))

(use-package lsp-python-ms
  :hook (python-mode . lsp-python-mode-hook))

(defun lsp-c++-mode-hook ()
  (set (make-local-variable 'compile-command)
       (format "cd %s/build && conan build .." (projectile-project-root)))
  (lsp-deferred))

(defun c++-mode-before-save-hook ()
  (when (eq major-mode 'c++-mode)
    (lsp-format-buffer)))

(add-hook 'c++-mode-hook 'lsp-c++-mode-hook)
(add-hook 'before-save-hook #'c++-mode-before-save-hook)

(use-package posframe)

(use-package dap-mode
  :straight (dap-mode :type git :host github :repo "emacs-lsp/dap-mode"
                      :fork (:host github
                             :repo "adam-r-kowalski/dap-mode"))
  :init (setq dap-auto-show-output nil)
  :config
  (require 'dap-python)
  (require 'dap-cppdbg)
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1))

(use-package key-chord :config (key-chord-mode 1))

(use-package flycheck)

(use-package magit :commands magit)

(use-package evil-magit :after magit)

(use-package treemacs-icons-dired
  :after (treemacs all-the-icons)
  :config (treemacs-icons-dired-mode 1))

(use-package treemacs-evil :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :config (add-hook 'projectile-after-switch-project-hook
		      'treemacs-display-current-project-exclusively))

(use-package avy)

(use-package cmake-mode)

(use-package dashboard
  :init
  (setq dashboard-set-file-icons t
	dashboard-set-heading-icons t
	dashboard-set-navigator t
	dashboard-set-init-info t
	dashboard-items '((projects . 5)
			  (recents .5)
			  (agenda . 5)))
  :config (dashboard-setup-startup-hook))

(defun find-user-init-file ()
  (interactive)
  (find-file user-init-file))

(general-define-key :states 'motion ";" 'evil-ex)

(general-define-key :keymaps 'evil-insert-state-map
                    (general-chord "jk") 'evil-normal-state)

(defun disable-all-themes ()
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

(defun switch-theme ()
  (interactive)
  (disable-all-themes)
  (call-interactively 'load-theme))

(defun colorize-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(use-package ansi-color
  :config (add-hook 'compilation-filter-hook 'colorize-compilation-buffer))

(use-package rainbow-delimiters
  :config (rainbow-delimiters-mode 1))

(use-package evil-cleverparens
  :hook ((emacs-lisp-mode . evil-cleverparens-mode)))

(use-package adjust-parens
  :straight (adjust-parens :type git :host github :repo "emacs-straight/adjust-parens"))

(general-define-key
 :states '(insert normal visual emacs)
 :keymaps 'emacs-lisp-mode-map
 "TAB" 'lisp-indent-adjust-parens
 "<backtab>" 'lisp-dedent-adjust-parens)

(defun gitter-irc ()
  (interactive)
  (erc-tls :server "irc.gitter.im"
	   :port 6697
	   :nick "adam-r-kowalski"
	   :full-name "Adam Kowalski"
	   :password (read-string "Enter your password:")))

(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 :prefix "SPC"
 "SPC" 'avy-goto-char
 "." 'find-file
 "x" 'execute-extended-command
 "b" 'switch-to-buffer
 "p" 'counsel-projectile-switch-project
 "f" 'counsel-projectile-find-file
 "g" 'counsel-projectile-rg
 "i" 'find-user-init-file
 "e" 'treemacs
 "t" '(nil :which-key "test")
 "d" 'recompile
 "D" 'compile
 "m" 'magit
 "s" 'eshell
 "T" 'switch-theme
 "G" 'gitter-irc)

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
 :keymaps 'python-mode-map
 :prefix "SPC t"
 "n" 'dap-python--debug-test-at-point
 "f" 'dap-python--debug-test-buffer)

(general-define-key
 :states '(normal visual emacs)
 :keymaps 'c++-mode-map
 :prefix "SPC t"
 "n" 'dap-cppdbg--debug-test-at-point)

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
 "D" 'elpy-goto-definition-or-rgrep
 "r" 'lsp-ui-peek-find-references
 "s" 'lsp-ivy-global-workspace-symbol
 "b" 'evil-jump-backward)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282828" "#ea6962" "#a9b665" "#d8a657" "#7daea3" "#d3869b" "#89b482" "#d4be98"])
 '(custom-safe-themes
   '("5ee2e93e9365f82c1d446ab65b3281a78936f7245f83fe5efee1f5de736d6bdf" default))
 '(fci-rule-color "#45403d")
 '(jdee-db-active-breakpoint-face-colors (cons "#32302f" "#d8a657"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#32302f" "#a9b665"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#32302f" "#d4be98"))
 '(objed-cursor-color "#ea6962")
 '(pdf-view-midnight-colors (cons "#d4be98" "#282828"))
 '(rustic-ansi-faces
   ["#282828" "#ea6962" "#a9b665" "#d8a657" "#7daea3" "#d3869b" "#89b482" "#d4be98"])
 '(vc-annotate-background "#282828")
 '(vc-annotate-color-map
   (list
    (cons 20 "#a9b665")
    (cons 40 "#b8b060")
    (cons 60 "#c8ab5b")
    (cons 80 "#d8a657")
    (cons 100 "#dd9c54")
    (cons 120 "#e29351")
    (cons 140 "#e78a4e")
    (cons 160 "#e08867")
    (cons 180 "#d98781")
    (cons 200 "#d3869b")
    (cons 220 "#da7c88")
    (cons 240 "#e27275")
    (cons 260 "#ea6962")
    (cons 280 "#e47e6f")
    (cons 300 "#df937d")
    (cons 320 "#d9a88a")
    (cons 340 "#45403d")
    (cons 360 "#45403d")))
 '(vc-annotate-very-old-color nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
