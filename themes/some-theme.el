;;; some-theme.el --- just some theme -*- lexical-binding: t; no-byte-compile: t; -*-
;;

(require 'doom-themes)


;;
;;; Variables

(defgroup some-theme nil
  "Options for the `some' theme."
  :group 'doom-themes)

(defcustom some-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'some-theme
  :type 'boolean)

(defcustom some-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'some-theme
  :type 'boolean)

(defcustom some-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'some-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme some
  "A dark theme inspired by Atom One Dark."

  ;; name        default   256           16
  ((bg         '("#232523" "black"       "black"  ))
   ;; (fg         '("#bbc2cf" "#bfbfbf"     "brightwhite"  ))
   (fg         '("#b2c0b0" "#f9f0c1"     "brightwhite"  ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#292b29" "black"       "black"        ))
   (fg-alt     '("#5B6268" "#2d2d2d"     "white"        ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#1B2229" "black"       "black"        ))
   (base1      '("#1c1f24" "#1e1e1e"     "brightblack"  ))
   (base2      '("#202328" "#2e2e2e"     "brightblack"  ))
   (base3      '("#23272e" "#262626"     "brightblack"  ))
   (base4      '("#3f444a" "#3f3f3f"     "brightblack"  ))
   (base5      '("#5B6268" "#525252"     "brightblack"  ))
   (base6      '("#73797e" "#6b6b6b"     "brightblack"  ))
   (base7      '("#9ca0a4" "#979797"     "brightblack"  ))
   (base8      '("#DFDFDF" "#dfdfdf"     "white"        ))

   (grey       base4)
   (red        '("#ff6c6b" "#ff6655" "red"          ))
   (orange     '("#da8548" "#dd8844" "brightred"    ))
   (green      '("#66ae84" "#99bb66" "green"        ))
   (teal       '("#4db5bd" "#44b9b1" "brightgreen"  ))
   (yellow     '("#dcbe6b" "#ECBE7B" "yellow"       ))
   (blue       '("#51afef" "#51afef" "brightblue"   ))
   (dark-blue  '("#2257A0" "#2257A0" "blue"         ))
   (magenta    '("#c678dd" "#c678dd" "brightmagenta"))
   (violet     '("#a9a1e1" "#a9a1e1" "magenta"      ))
   (cyan       '("#46D9FF" "#46D9FF" "brightcyan"   ))
   (dark-cyan  '("#5699AF" "#5699AF" "cyan"         ))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      green)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        fg)
   (comments       base6)
   (doc-comments   teal)
   (constants      fg)
   (functions      fg)
   (keywords       yellow)
   (methods        fg)
   (operators      fg)
   (type           fg)
   (strings        green)
   (variables      fg)
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;;;;;;;;;; TODO delete unused rules below... this is supposed to be a very simple theme anyway

   ;; These are extra color variables used only in this theme; i.e. they aren't
   ;; mandatory for derived themes.
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if some-brighter-modeline
                                 (doom-darken blue 0.45)
                               (doom-darken bg-alt 0.1)))
   (modeline-bg-alt          (if some-brighter-modeline
                                 (doom-darken blue 0.475)
                               `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when some-padded-modeline
      (if (integerp some-padded-modeline) some-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base6)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if some-brighter-comments (doom-lighten bg 0.05)))
   ((font-lock-type-face &override) :slant 'italic)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if some-brighter-modeline base8 highlight))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if some-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal))

  ;;;; Base theme variable overrides-
  ())

;;; some-theme.el ends here
