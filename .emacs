(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(set-face-attribute 'default nil :height 200 :font "RobotoMono Nerd Font")


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
(setq frame-resize-pixelwise t)


(use-package exec-path-from-shell
  :ensure t
  :config (when (memq window-system '(mac ns x))
	    (exec-path-from-shell-initialize)))


(use-package evil
  :ensure t
  :init (setq evil-want-C-u-scroll t)
  :config (evil-mode 1))


(use-package nord-theme
  :ensure t
  :config (load-theme 'nord t))


(use-package company
  :ensure t
  :config (global-company-mode))


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


(general-define-key
 :keymaps 'evil-insert-state-map
 (general-chord "jk") 'evil-normal-state)


(general-swap-key nil 'motion
  ";" ":")
 

(general-define-key
 :keymaps '(normal emacs)
 :prefix "SPC"
 "f" 'find-file
 "x" 'execute-extended-command)


(general-define-key
 :states '(normal insert emacs)
 "C-h" 'evil-window-left
 "C-j" 'evil-window-down
 "C-k" 'evil-window-up
 "C-l" 'evil-window-right)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(exec-path-from-shell vterm which-key company swiper key-chord general nord-theme use-package evil)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
