;;; adam-nord-theme.el
(require 'doom-themes)

;;
(defgroup adam-nord-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom adam-nord-brighter-modeline t
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'adam-nord-theme
  :type 'boolean)

(defcustom adam-nord-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'adam-nord-theme
  :type 'boolean)

(defcustom adam-nord-comment-bg adam-nord-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'adam-nord-theme
  :type 'boolean)

(defcustom adam-nord-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'adam-nord-theme
  :type '(choice integer boolean))

(eval-and-compile
  (defcustom adam-nord-region-highlight 'frost
    "Determines the selection highlight style. Can be 'frost, 'snowstorm or t
(default)."
    :group 'adam-nord-theme
    :type 'symbol))

;;
(def-doom-theme adam-nord
  "A dark theme inspired by Nord."

  ;; name        default   256       16
  ((bg         '("#2e3340" nil       nil            ))
   (bg-alt     '("#2e3340" nil       nil            ))
   (base0      '("#3b4251" "3b4251"   "black"        ))
   (base1      '("#3b4251" "#3b4251" "brightblack"  ))
   (base2      '("#3b4251" "#3b4251" "brightblack"  ))
   (base3      '("#4c556a" "#4c556a" "brightblack"  ))
   (base4      '("#4c556a" "#4c556a" "brightblack"  ))
   (base5      '("#4c556a" "#4c556a" "brightblack"  ))
   (base6      '("#4c556a" "#4c556a" "brightblack"  ))
   (base7      '("#4c556a" "#4c556a" "brightblack"  ))
   (base8      '("#e5e9f0" "#e5e9f0" "white"        ))
   (fg         '("#d8dee8" "#d8dee8" "white"        ))
   (fg-alt     '("#d8dee8" "#d8dee8" "brightwhite"  ))

   (grey       base4)
   (red        '("#bf6069" "#bf6069" "red"          )) ;; Nord11
   (orange     '("#bf6069" "#bf6069" "brightred"    )) ;; Nord12
   (green      '("#a3be8b" "#a3be8b" "green"        )) ;; Nord14
   (teal       '("#a3be8b" "#a3be8b" "brightgreen"  )) ;; Nord7
   (yellow     '("#eacb8a" "#eacb8a" "yellow"       )) ;; Nord13
   (blue       '("#81a1c1" "#81a1c1" "brightblue"   )) ;; Nord9
   (dark-blue  '("#81a1c1" "#81a1c1" "blue"         )) ;; Nord10
   (magenta    '("#b48dac" "#b48dac" "magenta"      )) ;; Nord15
   (violet     '("#b48dac" "#b48dac" "brightmagenta")) ;; ??
   (cyan       '("#88c0d0" "#88c0d0" "brightcyan"   )) ;; Nord8
   (dark-cyan  '("#88c0d0" "#88c0d0" "cyan"         )) ;; ??

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.2))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if adam-nord-brighter-comments dark-cyan (doom-lighten base5 0.2)))
   (doc-comments   (doom-lighten (if adam-nord-brighter-comments dark-cyan base5) 0.25))
   (constants      cyan)
   (functions      cyan)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           cyan)
   (strings        green)
   (variables      cyan)
   (numbers        yellow)
   (region         (pcase adam-nord-region-highlight
                     (`frost cyan)
                     (`snowstorm base7)
                     (_ base4)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright adam-nord-brighter-modeline)
   (-modeline-pad
    (when adam-nord-padded-modeline
      (if (integerp adam-nord-padded-modeline) adam-nord-padded-modeline 4)))

   (region-fg
    (when (memq adam-nord-region-highlight '(frost snowstorm))
      bg-alt))

   (modeline-fg     nil)
   (modeline-fg-alt base6)

   (modeline-bg
    (if -modeline-bright
        (doom-blend bg base5 0.2)
      base1))
   (modeline-bg-l
    (if -modeline-bright
        (doom-blend bg base5 0.2)
      `(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  (((region &override) :foreground region-fg)

   ((line-number &override) :foreground (doom-lighten 'base5 0.2))
   ((line-number-current-line &override) :foreground cyan)
   ((paren-face-match &override) :foreground cyan :background base3 :weight 'ultra-bold)
   ((paren-face-mismatch &override) :foreground base3 :background red :weight 'ultra-bold)
   ((vimish-fold-overlay &override) :inherit 'font-lock-comment-face :background base3 :weight 'light)
   ((vimish-fold-fringe &override)  :foreground teal)

   (font-lock-comment-face
    :foreground comments
    :background (if adam-nord-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   (doom-modeline-project-root-dir :foreground base6)
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; ediff
   (ediff-fine-diff-A    :background violet :weight 'bold)
   (ediff-current-diff-A :background (doom-darken base0 0.25))

   ;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (solaire-org-hide-face :foreground hidden))


  ;; --- extra variables ---------------------
  ()
  )

;;; adam-nord-theme.el ends here
