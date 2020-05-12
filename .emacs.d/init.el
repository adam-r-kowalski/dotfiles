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


(set-face-attribute 'default nil
                    :family "Fira Code"
                    :height 160
                    :weight 'normal
                    :width 'normal)


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
  (load-theme 'adam-nord t)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))


(use-package doom-modeline
  :init
  (setq doom-modeline-icon (display-graphic-p)
	doom-modeline-buffer-file-name-style 'truncate-with-project
	doom-modeline-buffer-encoding nil
	doom-modeline-lsp nil
	doom-modeline-minor-modes nil)
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


(use-package treemacs :commands treemacs)


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
  :hook (dap-stopped . (lambda (&rest _) (call-interactively #'dap-hydra)))
  :init (setq dap-auto-show-output nil)
  :config
  (require 'dap-python)
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1))


(dap-register-debug-provider
 "cppdbg"
 (lambda (conf)
   (plist-put conf
              :dap-server-path
              '("/Users/adamkowalski/.vscode-insiders/extensions/ms-vscode.cpptools-0.28.0-insiders/debugAdapters/OpenDebugAD7"))
   conf))


(dap-register-debug-template
 "C++ Debug Test"
 (list :type "cppdbg"
       :cwd "/Users/adamkowalski/code/omega/build/bin"
       :request "launch"
       :program "/Users/adamkowalski/code/omega/build/bin/test_omega"
       :externalTerminal :json-false
       :MIMode "lldb"
       :name "Debug Test"))



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
 "T" 'switch-theme)


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
 "n" 'dap-python--debug-test-at-point)


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
   ["#2e3340" "#bf6069" "#a3be8b" "#eacb8a" "#81a1c1" "#b48dac" "#88c0d0" "#d8dee8"])
 '(custom-safe-themes
   '("8e845243c9bc1a8d77be2e0567cb89a450118689e831a802ab9013093f6efd1a" default))
 '(fci-rule-color "#4c556a")
 '(jdee-db-active-breakpoint-face-colors (cons "#3b4251" "#81a1c1"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#3b4251" "#a3be8b"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#3b4251" "#4c556a"))
 '(objed-cursor-color "#bf6069")
 '(pdf-view-midnight-colors (cons "#d8dee8" "#2e3340"))
 '(rustic-ansi-faces
   ["#2e3340" "#bf6069" "#a3be8b" "#eacb8a" "#81a1c1" "#b48dac" "#88c0d0" "#d8dee8"])
 '(vc-annotate-background "#2e3340")
 '(vc-annotate-color-map
   (list
    (cons 20 "#a3be8b")
    (cons 40 "#bac28a")
    (cons 60 "#d2c68a")
    (cons 80 "#eacb8a")
    (cons 100 "#dba77f")
    (cons 120 "#cd8373")
    (cons 140 "#bf6069")
    (cons 160 "#bb6f7f")
    (cons 180 "#b77e95")
    (cons 200 "#b48dac")
    (cons 220 "#b77e95")
    (cons 240 "#bb6f7f")
    (cons 260 "#bf6069")
    (cons 280 "#a25d69")
    (cons 300 "#855a69")
    (cons 320 "#685769")
    (cons 340 "#4c556a")
    (cons 360 "#4c556a")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
