;; gruvbox-material-theme.el --- inspired by morhetz Gruvbox -*- no-byte-compile: t; -*-
(require 'doom-themes)

;; Compiler pacifier
(defvar modeline-bg)

;;
(defgroup gruvbox-material-theme nil
  "Options for gruvbox-material."
  :group 'doom-themes)

(defcustom gruvbox-material-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'gruvbox-material-theme
  :type 'boolean)

(defcustom gruvbox-material-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to determine the exact padding."
  :group 'gruvbox-material-theme
  :type '(choice integer boolean))

;;
(def-doom-theme gruvbox-material
  "Dark theme with pastel 'retro groove' colors."

  ;; name        gui       256       16
  ((bg         '("#282828" nil       nil            ))
   (bg-alt     '("#d4be98" nil       nil            ))
   (accent     '("#504945" "#504945" "brown"      ))

   (base0      '("#32302f" "#32302f" "black"        ))
   (base1      '("#32302f" "#32302f" "brightblack"  ))
   (base2      '("#45403d" "#45403d" "brightblack"  ))
   (base3      '("#45403d" "#45403d" "brightblack"  ))
   (base4      '("#45403d" "#45403d" "brightblack"  ))
   (base5      '("#45403d" "#45403d" "brightblack"  ))
   (base6      '("#5a524c" "#5a524c" "brightblack"  ))
   (base7      '("#5a524c" "#5a524c" "brightblack"  ))
   (base8      '("#5a524c" "#5a524c" "white"        ))
   (fg         '("#d4be98" "#d4be98" "white"        ))
   (fg-alt     '("#282828" "#282828" "brightwhite"  ))
   (grey       fg)
   (red        '("#ea6962" "#ea6962" "red"          )) 
   (magenta    '("#d3869b" "#d3869b" "magenta"      ))
   (violet     '("#d3869b" "#d3869b" "brightmagenta"))
   (orange     '("#e78a4e" "#e78a4e" "brightred"    ))
   (yellow     '("#d8a657" "#d8a657" "yellow"       ))
   (dark-green '("#a9b665" "#a9b665" "green"        ))
   (green      '("#a9b665" "#a9b665" "green"        ))
   (teal       green)
   (olive      '("#a9b665" "#a9b665" "green"        ))
   (blue       '("#7daea3" "#7daea3" "brightblue"   ))
   (dark-blue  '("#7daea3" "#7daea3" "blue"         ))
   (cyan       '("#89b482" "#89b482" "brightcyan"   ))
   (dark-cyan  '("#89b482" "#89b482" "cyan"         ))

   ;; face categories
   (highlight      yellow)
   (vertical-bar   grey)
   (selection      accent)
   (builtin        orange)
   (comments       magenta)
   (doc-comments   (doom-lighten magenta 0.2))
   (constants      yellow)
   (functions      orange)
   (keywords       red)
   (methods        orange)
   (operators      cyan)
   (type           green)
   (strings        yellow)
   (variables      blue)
   (numbers        violet)
   (region         accent)
   (error          red)
   (warning        yellow)
   (success        green)

   (vc-modified    accent)
   (vc-added       (doom-darken green 0.15))
   (vc-deleted     red)

   ;; custom categories
   (-modeline-pad nil)

   (org-quote `(,(doom-lighten (car bg) 0.05) "#1f1f1f")))

  ;; --- extra faces ------------------------
  (
   ;;;;;;;; Editor ;;;;;;;;
   (cursor :background "white")
   (hl-line :background selection)
   ((line-number-current-line &override) :background (doom-darken fg 0.3) :foreground bg :bold t)
   ((line-number &override) :foreground (doom-darken fg 0.3))

   ;; Vimish-fold
   ((vimish-fold-overlay &override) :inherit 'font-lock-comment-face :background accent :weight 'light)
   ((vimish-fold-mouse-face &override) :foreground "white" :background yellow :weight 'light)
   ((vimish-fold-fringe &override) :foreground magenta :background magenta)

   ;;;;;;;; Doom-modeline ;;;;;;;;
   (mode-line
    :background accent :foreground (doom-lighten fg 0.25)
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color fg)))

   (mode-line-inactive
    :background bg :foreground fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color fg)))

   ;; File-name
   (doom-modeline-project-dir :bold t :foreground cyan)
   (doom-modeline-buffer-path :inherit 'bold :foreground green)
   (doom-modeline-buffer-file :inherit 'bold :foreground fg)
   (doom-modeline-buffer-modified :inherit 'bold :foreground yellow)
   ;; Misc
   (doom-modeline-error :background bg)
   (doom-modeline-buffer-major-mode :foreground green :bold t)
   (doom-modeline-warning :foreground red :bold t)
   (doom-modeline-info :bold t :foreground cyan)
   (doom-modeline-bar :background dark-green)
   (doom-modeline-panel :background dark-green :foreground fg)

   ;;;;;;;; Search ;;;;;;;;
   ;; /find
   (isearch :foreground base0 :background yellow)
   (evil-search-highlight-persist-highlight-face :background orange)
   (lazy-highlight :background yellow :foreground base0 :distant-foreground base0 :bold bold)
   (evil-ex-substitute-replacement :foreground yellow :inherit 'evil-ex-substitute-matches)

   ;; evil-snipe
   (evil-snipe-first-match-face :foreground "white" :background yellow)
   (evil-snipe-matches-face     :foreground yellow :bold t :underline t)

   ;;;;;;;; Mini-buffers ;;;;;;;;
   (minibuffer-prompt :foreground green)
   (solaire-hl-line-face :background accent)

   ;; ivy
   (ivy-current-match :background accent)
   (ivy-subdir :background nil :foreground cyan)
   (ivy-action :background nil :foreground cyan)
   (ivy-grep-line-number :background nil :foreground cyan)
   (ivy-minibuffer-match-face-1 :background nil :foreground yellow)
   (ivy-minibuffer-match-face-2 :background nil :foreground yellow)
   (ivy-minibuffer-match-highlight :foreground olive)
   (counsel-key-binding :foreground green)

   ;; ivy-posframe
   (ivy-posframe :background bg-alt)
   (ivy-posframe-border :background base1)

   ;; neotree
   (neo-root-dir-face   :foreground green)
   (doom-neotree-dir-face :foreground cyan)
   (neo-dir-link-face   :foreground cyan)
   (doom-neotree-file-face :foreground fg)
   (doom-neotree-hidden-file-face :foreground (doom-lighten fg-alt 0.25))
   (doom-neotree-media-file-face :foreground (doom-lighten fg-alt 0.25))
   (neo-expand-btn-face :foreground magenta)

   ;; dired
   (dired-directory :foreground cyan)
   (dired-marked :foreground yellow)
   (dired-symlink :foreground green)

   ;; term
   (term-color-blue :background cyan :foreground cyan)
   (term-color-cyan :background green :foreground green)
   (term-color-green :background olive :foreground olive)

   ;;;;;;;; Brackets ;;;;;;;;
   ;; Rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground red)
   (rainbow-delimiters-depth-2-face :foreground yellow)
   (rainbow-delimiters-depth-3-face :foreground green)
   (rainbow-delimiters-depth-4-face :foreground red)
   (rainbow-delimiters-depth-5-face :foreground yellow)
   (rainbow-delimiters-depth-6-face :foreground green)
   (rainbow-delimiters-depth-7-face :foreground red)
   ;; Bracket pairing
   ((show-paren-match &override) :foreground nil :background fg-alt :bold t)
   ((show-paren-mismatch &override) :foreground nil :background "red")

   ;;;;;;;; which-key ;;;;;;;;
   (which-func :foreground green)
   (which-key-command-description-face :foreground fg)
   (which-key-group-description-face :foreground (doom-lighten fg-alt 0.25))
   (which-key-local-map-description-face :foreground cyan)

   ;;;;;;;; Company ;;;;;;;;
   (company-preview-common :foreground green)
   (company-tooltip-common :foreground green)
   (company-tooltip-common-selection :foreground green)
   (company-tooltip-annotation :foreground cyan)
   (company-tooltip-annotation-selection :foreground cyan)
   (company-scrollbar-bg :background fg)
   (company-scrollbar-fg :background green)
   (company-tooltip-selection :background accent)
   (company-tooltip-mouse :background accent :foreground nil)

   ;;;;;;;; Misc ;;;;;;;;
   (+workspace-tab-selected-face :background dark-green :foreground "white")

   ;; Undo tree
   (undo-tree-visualizer-active-branch-face :foreground green)
   (undo-tree-visualizer-current-face :foreground yellow)

   ;; General UI
   (button :foreground green :underline t :bold t)

   ;; ediff
   (ediff-fine-diff-A    :background (doom-blend red bg 0.3) :weight 'bold)
   (ediff-current-diff-A :background (doom-blend red bg 0.1))

   ;; flycheck
   (flycheck-error   :underline `(:style wave :color ,red)    :background base3)
   (flycheck-warning :underline `(:style wave :color ,yellow) :background base3)
   (flycheck-info    :underline `(:style wave :color ,green)  :background base3)

   ;; helm
   (helm-swoop-target-line-face :foreground magenta :inverse-video t)

   ;; magit
   (magit-section-heading             :foreground yellow :weight 'bold)
   (magit-branch-current              :underline cyan :inherit 'magit-branch-local)
   (magit-diff-hunk-heading           :background base3 :foreground fg-alt)
   (magit-diff-hunk-heading-highlight :background accent :foreground fg)
   (magit-diff-context                :foreground bg-alt :foreground fg-alt)


   ;;;;;;;; Major mode faces ;;;;;;;;
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground keywords)

   ;; elisp-mode
   (highlight-quoted-symbol :foreground dark-cyan)

   ;; LaTeX-mode
   (font-latex-math-face :foreground dark-cyan)

   ;; markdown-mode
   (markdown-blockquote-face :inherit 'italic :foreground cyan)
   (markdown-list-face :foreground red)
   (markdown-url-face :foreground red)
   (markdown-pre-face  :foreground green)
   (markdown-link-face :inherit 'bold :foreground cyan)
   ((markdown-code-face &override) :background (doom-lighten base2 0.045))

   ;; mu4e-view
   (mu4e-header-key-face :foreground red)

   ;; org-mode
   ((outline-1 &override) :foreground yellow)
   ((outline-2 &override) :foreground cyan)
   ((outline-3 &override) :foreground green)
   (org-ellipsis :underline nil :foreground orange)
   (org-tag :foreground yellow :bold nil)
   ((org-quote &override) :inherit 'italic :foreground base7 :background org-quote)
   (org-todo :foreground yellow :bold 'inherit)
   (org-list-dt :foreground yellow))

  ;; --- extra variables --------------------
  ;; ()
  )
;;; gruvbox-material-theme.el ends here
