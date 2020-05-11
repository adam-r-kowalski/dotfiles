(setq gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024)
      auto-save-default nil
      make-backup-files nil
      create-lockfiles nil
      frame-resize-pixelwise t
      display-line-numbers-type 'relative
      ring-bell-function 'ignore
      truncate-lines 1)


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
(display-time-mode)
(show-paren-mode 1)


(set-face-attribute 'default nil
                    :family "Source Code Pro for Powerline"
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
  (load-theme 'adam-nord t)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))


(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-icon (display-graphic-p)
	doom-modeline-buffer-file-name-style 'truncate-with-project
	doom-modeline-buffer-encoding nil
	doom-modeline-lsp nil
	doom-modeline-minor-modes nil)
  :config
  (display-battery-mode)
  (doom-modeline-mode 1))


(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t
	evil-echo-state nil
	evil-want-keybinding nil)
  :config (evil-mode 1))


(use-package evil-collection
  :ensure t
  :config (evil-collection-init))


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
  :init (setq lsp-prefer-capf t
	      lsp-semantic-highlighting 'immediate))


(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)


(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)


(use-package lsp-treemacs
  :ensure t)


(use-package lsp-python-ms
  :ensure t
  :hook (python-mode . (lambda ()
			 (require 'lsp-python-ms)
			 (lsp))))


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


(use-package treemacs-icons-dired
  :ensure t
  :config (treemacs-icons-dired-mode 1))


(use-package treemacs-evil
  :ensure t)


(use-package treemacs-projectile
  :ensure t
  :config (add-hook 'projectile-after-switch-project-hook
		    (lambda ()
		      (treemacs-display-current-project-exclusively))))


(use-package ranger
  :ensure t
  :config (ranger-override-dired-mode t))


(use-package avy
  :ensure t)


(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  (setq elpy-test-runner 'elpy-test-pytest-runner
	elpy-test-pytest-runner-command '("python" "-m" "pytest" "-p" "no:warnings" "-s")
	elpy-rpc-virtualenv-path 'current)
  :config
  (flymake-mode)
  (remove-hook 'elpy-modules 'elpy-module-flymake))


(defun elpy-goto-definition-or-rgrep ()
    (interactive)
    (ring-insert find-tag-marker-ring (point-marker))
    (condition-case nil (elpy-goto-definition)
        (error (elpy-rgrep-symbol
                   (concat "\\(def\\|class\\)\s" (thing-at-point 'symbol) "(")))))


(defun find-user-init-file ()
  (interactive)
  (find-file user-init-file))


(add-hook 'c++-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "cd %s/build && conan build .." (projectile-project-root)))))


(general-define-key
 :states 'motion
 ";" 'evil-ex)


(general-define-key :keymaps 'evil-insert-state-map
                    (general-chord "jk") 'evil-normal-state)


(defun disable-all-themes ()
  (dolist (i custom-enabled-themes)
    (disable-theme i)))


(defun switch-theme ()
  (interactive)
  (disable-all-themes)
  (call-interactively 'load-theme))


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
 :keymaps 'override
 :prefix "SPC t"
 "n" 'elpy-test
 "l" 'recompile)


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


(use-package posframe
  :ensure t)


(use-package dap-mode
  :ensure t
  :config
  (require 'dap-python)
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1))


(use-package cmake-mode
  :ensure t)


(use-package auto-package-update
  :ensure t)


(defun colorize-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))


(use-package ansi-color
  :ensure t
  :config (add-hook 'compilation-filter-hook 'colorize-compilation-buffer))


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


(dap-register-debug-template
 "C++ Debug Test"
 (list :type "cppdbg"
       :cwd "/Users/adamkowalski/code/omega/build/bin"
       :request "launch"
       :program "/Users/adamkowalski/code/omega/build/bin/test_omega"
       :externalTerminal :json-false
       :MIMode "lldb"
       :name "Debug Test"))


(dap-register-debug-template
 "Python Debug Test"
 (list :type "python"
       :args ""
       :cwd "/Users/adamkowalski/code/mount_hood/"
       :program nil
       :module "pytest"
       :request "launch"
       :name "Debug Test"))


(defun dap-python--test-at-point (conf)
  "Populate CONF with the required arguments."
  (let* ((host "localhost")
         (debug-port (dap--find-available-port))
         (python-executable (dap-python--pyenv-executable-find dap-python-executable))
         (python-args (or (plist-get conf :args) ""))
         (program (concat (buffer-file-name) (test-at-point)))
         (module (plist-get conf :module)))

    (plist-put conf :program-to-start
               (format "%s%s -m ptvsd --wait --host %s --port %s %s %s %s"
                       (or dap-python-terminal "")
                       (shell-quote-argument python-executable)
                       host
                       debug-port
                       (if module (concat "-m " (shell-quote-argument module)) "")
                       (shell-quote-argument program)
                       python-args))
    (plist-put conf :program program)
    (plist-put conf :debugServer debug-port)
    (plist-put conf :port debug-port)
    (plist-put conf :hostName host)
    (plist-put conf :host host)
    conf))

(dap-register-debug-provider "python-test-at-point" 'dap-python--test-at-point)


(dap-register-debug-template
 "Python Debug Test At Point"
 (list :type "python-test-at-point"
       :args ""
       :module "pytest"
       :request "launch"
       :name "Python Debug Test At Point"))


(use-package dash
  :ensure t)


(use-package dash-functional
  :ensure t)


(cl-defstruct point
  (line (:type integer) :named)
  (character (:type integer) :named))


(cl-defstruct location
  (start (:type point) :named)
  (end (:type point) :named))


(cl-defstruct lsp-symbol
  (name (:type string) :named)
  (type (:type string) :named)
  (location (:type location) :named))


(cl-defgeneric == (lhs rhs)
  (:documentation "Check if lhs and rhs are equal"))


(cl-defmethod == ((lhs symbol) (rhs symbol))
  (eq lhs rhs))


(cl-defmethod == ((lhs integer) (rhs integer))
  (eq lhs rhs))
  

(cl-defmethod == ((lhs string) (rhs string))
  (string-equal lhs rhs))


(cl-defmethod == ((lhs list) (rhs list))
  (-reduce (lambda (x y) (and x y)) (-zip-with '== lhs rhs)))


(cl-defmethod == ((lhs point) (rhs point))
  (and (== (point-line lhs) (point-line rhs))
       (== (point-character lhs) (point-character rhs))))


(cl-defmethod == ((lhs location) (rhs location))
  (and (== (location-start lhs) (location-start rhs))
       (== (location-end lhs) (location-end rhs))))


(cl-defmethod == ((lhs lsp-symbol) (rhs lsp-symbol))
  (and (== (lsp-symbol-name lhs) (lsp-symbol-name rhs))
       (== (lsp-symbol-type lhs) (lsp-symbol-type rhs))
       (== (lsp-symbol-location lhs) (lsp-symbol-location rhs))))


(defun parse-lsp-symbol (symbol)
  (-let* (((&hash "name" "kind" "location") symbol)
	  ((&hash "range") location)
	  ((&hash "start" "end") range))
    (make-lsp-symbol
     :name name
     :type (alist-get kind lsp--symbol-kind)
     :location (make-location
		:start (make-point :line (gethash "line" start)
				   :character (gethash "character" start))
		:end (make-point :line (gethash "line" end)
				 :character (gethash "character" end))))))


(defun lsp-symbol-before-point (point lsp-symbol)
  (let ((lsp-symbol-line (-> lsp-symbol
			     lsp-symbol-location
			     location-start
			     point-line)))
    (< lsp-symbol-line (point-line point))))


(defun lsp-symbols-before-point (point lsp-symbols)
  (-filter (-partial 'lsp-symbol-before-point point) lsp-symbols))


(defun test-p (lsp-symbol)
  (let ((name (lsp-symbol-name lsp-symbol)))
    (and (== (lsp-symbol-type lsp-symbol) "Function")
	 (>= (length name) 5)
	 (== (substring name 0 5) "test_"))))


(defun test-class-p (test-symbol lsp-symbol)
  (if (== (lsp-symbol-type lsp-symbol) "Class")
      (let* ((class-location (lsp-symbol-location lsp-symbol))
	     (class-start-line (-> class-location location-start point-line))
	     (class-end-line (-> class-location location-end point-line))
	     (test-start-line (-> test-symbol lsp-symbol-location location-start point-line)))
	(and (> test-start-line class-start-line)
	     (< test-start-line class-end-line)))
	nil))


(defun nearest-test (lsp-symbols)
  (let* ((reversed (reverse lsp-symbols))
	 (test-symbol (-first 'test-p reversed))
	 (class-symbol (-first (-partial 'test-class-p test-symbol) reversed)))
    (if (eq nil class-symbol)
	(concat "::" (lsp-symbol-name test-symbol))
        (concat "::" (lsp-symbol-name class-symbol) "::" (lsp-symbol-name test-symbol)))))


(defun cursor-position ()
  (make-point :line (line-number-at-pos)
	      :character (current-column)))


(defun test-at-point ()
  (->> (lsp--get-document-symbols)
       (mapcar 'parse-lsp-symbol)
       (lsp-symbols-before-point (cursor-position))
       nearest-test))


(defun store-symbols-at-point ()
  (interactive)
  (setq document-symbols-at-point (lsp--get-document-symbols)))


(setq document-symbols-with-class
      (list
       #s(lsp-symbol "dataclass" "Function" #s(location #s(point 0 0) #s(point 0 33)))
       #s(lsp-symbol "Foo" "Class" #s(location #s(point 4 0) #s(point 6 0)))
       #s(lsp-symbol "value" "Variable" #s(location #s(point 5 4) #s(point 5 14)))
       #s(lsp-symbol "Bar" "Class" #s(location #s(point 9 0) #s(point 11 0)))
       #s(lsp-symbol "value" "Variable" #s(location #s(point 10 4) #s(point 10 14)))
       #s(lsp-symbol "TestClass" "Class" #s(location #s(point 13 0) #s(point 21 0)))
       #s(lsp-symbol "test_foo" "Function" #s(location #s(point 14 4) #s(point 17 0)))
       #s(lsp-symbol "foo" "Variable" #s(location #s(point 15 8) #s(point 15 24)))
       #s(lsp-symbol "test_bar" "Function" #s(location #s(point 18 4) #s(point 21 0)))
       #s(lsp-symbol "bar" "Variable" #s(location #s(point 19 8) #s(point 19 24)))))


(setq symbols-before-point-with-class
      (list 
       #s(lsp-symbol "dataclass" "Function" #s(location #s(point 0 0) #s(point 0 33)))
       #s(lsp-symbol "Foo" "Class" #s(location #s(point 4 0) #s(point 6 0)))
       #s(lsp-symbol "value" "Variable" #s(location #s(point 5 4) #s(point 5 14)))
       #s(lsp-symbol "Bar" "Class" #s(location #s(point 9 0) #s(point 11 0)))
       #s(lsp-symbol "value" "Variable" #s(location #s(point 10 4) #s(point 10 14)))
       #s(lsp-symbol "TestClass" "Class" #s(location #s(point 13 0) #s(point 21 0)))
       #s(lsp-symbol "test_foo" "Function" #s(location #s(point 14 4) #s(point 17 0)))
       #s(lsp-symbol "foo" "Variable" #s(location #s(point 15 8) #s(point 15 24)))))


(== (lsp-symbols-before-point #s(point 15 4) document-symbols-with-class)
    symbols-before-point-with-class)


(== (nearest-test symbols-before-point-with-class) "::TestClass::test_foo")


(setq document-symbols
      (list
       #s(lsp-symbol "dataclass" "Function" #s(location #s(point 0 0) #s(point 0 33)))
       #s(lsp-symbol "Foo" "Class" #s(location #s(point 4 0) #s(point 6 0)))
       #s(lsp-symbol "value" "Variable" #s(location #s(point 5 4) #s(point 5 14)))
       #s(lsp-symbol "Bar" "Class" #s(location #s(point 9 0) #s(point 11 0)))
       #s(lsp-symbol "value" "Variable" #s(location #s(point 10 4) #s(point 10 14)))
       #s(lsp-symbol "test_foo" "Function" #s(location #s(point 13 0) #s(point 16 0)))
       #s(lsp-symbol "foo" "Variable" #s(location #s(point 14 4) #s(point 14 20)))
       #s(lsp-symbol "test_bar" "Function" #s(location #s(point 18 0) #s(point 21 0)))
       #s(lsp-symbol "bar" "Variable" #s(location #s(point 19 4) #s(point 19 20)))))


(setq symbols-before-point
      (list
       #s(lsp-symbol "dataclass" "Function" #s(location #s(point 0 0) #s(point 0 33)))
       #s(lsp-symbol "Foo" "Class" #s(location #s(point 4 0) #s(point 6 0)))
       #s(lsp-symbol "value" "Variable" #s(location #s(point 5 4) #s(point 5 14)))
       #s(lsp-symbol "Bar" "Class" #s(location #s(point 9 0) #s(point 11 0)))
       #s(lsp-symbol "value" "Variable" #s(location #s(point 10 4) #s(point 10 14)))
       #s(lsp-symbol "test_foo" "Function" #s(location #s(point 13 0) #s(point 16 0)))
       #s(lsp-symbol "foo" "Variable" #s(location #s(point 14 4) #s(point 14 20)))))


(== (lsp-symbols-before-point #s(point 15 4) document-symbols)
    symbols-before-point)


(== (nearest-test symbols-before-point) "::test_foo")
