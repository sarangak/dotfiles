;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     ;; better-defaults
     chrome
     clojure
     emacs-lisp
     ess
     (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     git
     ;; Github processing is too slow with the Console repo
     ;; github
     go
     helm
     html
     javascript
     latex
     lua
     markdown
     (org :variables
          org-enable-reveal-js-support t
          org-enable-github-support t)
     (python :variables
             python-enable-yapf-format-on-save t
             python-auto-set-local-pyenv-version 'on-project-switch)
     (ruby :variables ruby-version-manager 'rbenv)
     ruby-on-rails
     (shell :variables
            shell-default-position 'bottom
            shell-enable-smart-eshell t
            shell-default-shell 'multi-term)
     spell-checking
     syntax-checking
     ;; version-control
     yaml
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(ruby-refactor toggle-quotes jira-markup-mode ox-jira)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(evil-search-highlight-persist)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')

   ;; For some reason Spacemacs won't install ox-reveal and then with this switch it wants to delete it on startup :(
   dotspacemacs-install-packages 'used-but-keep-unused))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update t
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(monokai
                         ;; spacemacs-dark
                         dichromacy
                         ;; spacemacs-light
                         solarized-light
                         solarized-dark
                         ;; hc-zenburn
                         ;; zenburn
                         )
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key ":"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab t
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ t
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "All"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout t
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state t
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers 'relative
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (defun private/projectile-eshell-in-root ()
    "Invoke `eshell' in the project's root."
    (interactive)
    (projectile-with-default-dir (projectile-project-root) (eshell)))
  (defun private/open-local-platform-in-browser ()
    "Open a browser window to local civis"
    (interactive)
    (browse-url "http://platform.civis.dev:3000")
    )
  (defun private/show-and-copy-buffer-filename-from-root ()
    "Show the relative path to the current file in the minibuffer."
    (interactive)
    (let ((file-name (buffer-file-name)))
      (if (and file-name (projectile-project-root))
          (let ((file-name (file-relative-name file-name (projectile-project-root))))
            (progn
              (message file-name)
              (kill-new file-name)))
        (error "Buffer not visiting a file or no project root"))))
  (defun align-colons (beg end)
    "Align the given region for key: value content"
    (interactive)
    (align-regexp beg end ":\\(\\s-*\\)" 1 1 nil))
  (defun private/evil-select-pasted ()
    "Visually select last pasted text."
    (interactive)
    (evil-goto-mark ?[)
    (evil-visual-char)
    (evil-goto-mark ?]))
  (setq-default evil-snipe-use-vim-sneak-bindings t)
)

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
 This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  (setq-default
   evil-escape-delay 0.2
   multi-term-program "/usr/local/bin/zsh"
   )
  (spacemacs/set-leader-keys
    "SPC" 'evil-avy-goto-word-or-subword-1)
  (evil-leader/set-key "of" 'make-frame)
  (evil-leader/set-key "ob" 'spacemacs/new-empty-buffer)
  (evil-leader/set-key "ot" 'private/projectile-eshell-in-root)
  (evil-leader/set-key "oy" 'private/show-and-copy-buffer-filename-from-root)
  (evil-leader/set-key "oc" 'private/open-local-platform-in-browser)
  (evil-leader/set-key "ov" 'private/evil-select-pasted)
  (evil-leader/set-key "o/" 'clone-indirect-buffer-other-window)
  (global-set-key (kbd "C-'") 'toggle-quotes)
  (global-unset-key (kbd "s-w"))
  ;; Replicate visual line move commands from
  ;; https://github.com/syl20bnr/spacemacs/pull/6207/files#diff-0549c70ccafb60245919132b5952d64f
  ;; using org-mode keys
  (define-key evil-visual-state-map (kbd "M-j") (concat ":m '>+1" (kbd "RET") "gv=gv"))
  (define-key evil-visual-state-map (kbd "M-k") (concat ":m '<-2" (kbd "RET") "gv=gv"))
  ;; Wrap lines in text modes (including Org mode)
  (add-hook 'text-mode-hook 'turn-on-visual-line-mode)
  ;; Treat underscore as a symbol in Ruby so autocomplete includes whole identifiers
  (add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "_")))
  (add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)
  ;; Fix Coffeescript indentation - NOTE: doesn't work
  ;; (add-hook 'coffee-mode-hook (lambda () (setq indent-line-function 'coffee-indent-line)))
  ;; (setq frame-inherited-parameters '(left top width height))
  ;; For edit-with-chrome
  (setq edit-server-url-major-mode-alist
        '(("github\\.com" . gfm-mode)
          ;; gmail-message-mode package is supposed to add the following hook
          ;; but it doesn't work. Possibly because of interaction issue with how
          ;; Spacemacs loads this layer
          ("mail\\.google\\." . gmail-message-edit-server-mode)
          ("atlassian\\.net" . jira-markup-mode)))
  (add-hook 'edit-server-done-hook (lambda () (shell-command "open -a \"Google Chrome\"")))
  ;; For haml-lint
  ;; From https://gist.github.com/mbreit/229d2528604af2f8db37
  (flycheck-def-config-file-var flycheck-haml-lintrc haml-lint ".haml-lint.yml"
    :safe #'stringp)
  (flycheck-define-checker haml-lint
    "A haml-lint syntax checker"
    :command ("haml-lint"
              (config-file "--config" flycheck-haml-lintrc)
              source)
    :error-patterns
    ((warning line-start
              (file-name) ":" line " [W] "  (message)
              line-end))
    :modes (haml-mode))
  (add-to-list 'flycheck-checkers 'haml-lint)
  ;; So hippie-expand will try elements from the kill ring
  (setq hippie-expand-try-functions-list '(try-expand-whole-kill
                                           yas-hippie-try-expand
                                           try-expand-dabbrev
                                           try-expand-line
                                           try-expand-dabbrev-all-buffers
                                           try-expand-dabbrev-from-kill
                                           try-expand-list
                                           try-complete-file-name-partially
                                           try-complete-file-name
                                           try-expand-all-abbrevs
                                           try-complete-lisp-symbol-partially
                                           try-complete-lisp-symbol))
  ;; (define-key evil-motion-state-map [C-i] 'evil-jump-forward)
  ;; (with-eval-after-load 'org
  ;;   (progn
  ;;     ;; Originally used the following but it is overwritten by ox-reveal for speaker notes blocks
  ;;     ;; (add-to-list 'org-structure-template-alist '("n" "#+NAME: ?"))
  ;;     (require 'ox-reveal)
  ;;     ))
  ;; Enable autocompletion everywhere
  (global-company-mode)
  (evil-visual-mark-mode)
  ;; Add current point to jump list when using a count jump which is often used with relative numbering.
  (defun my-evil-set-jump (&rest args)
    (if (and (car args) (< 1 (car args))) (evil-set-jump)))
  (advice-add 'evil-previous-line :before 'my-evil-set-jump)
  (advice-add 'evil-next-line :before 'my-evil-set-jump)

  ;; From
  ;; https://github.com/syohex/evil-textobj-line/blob/master/evil-textobj-line.el
  ;; which doesn't seem to be in MELPA :(
  (defgroup evil-textobj-line nil
    "Text object line for Evil"
    :group 'evil)

  (defcustom evil-textobj-line-i-key "l"
    "Keys for evil-inner-line"
    :type 'string
    :group 'evil-textobj-line)

  (defcustom evil-textobj-line-a-key "l"
    "Keys for evil-a-line"
    :type 'string
    :group 'evil-textobj-line)

  (defun evil-line-range (count beg end type &optional inclusive)
    (if inclusive
        (evil-range (line-beginning-position) (line-end-position))
      (let ((start (save-excursion
                     (back-to-indentation)
                     (point)))
            (end (save-excursion
                   (goto-char (line-end-position))
                   (skip-syntax-backward " " (line-beginning-position))
                   (point))))
        (evil-range start end))))

  (evil-define-text-object evil-a-line (count &optional beg end type)
    "Select range between a character by which the command is followed."
    (evil-line-range count beg end type t))
  (evil-define-text-object evil-inner-line (count &optional beg end type)
    "Select inner range between a character by which the command is followed."
    (evil-line-range count beg end type))

  (define-key evil-outer-text-objects-map evil-textobj-line-a-key 'evil-a-line)
  (define-key evil-inner-text-objects-map evil-textobj-line-i-key 'evil-inner-line)
  ;; END evil-textobj-line
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-disable-faces nil)
 '(ansi-color-names-vector
   ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(avy-subword-extra-word-chars nil)
 '(coffee-indent-like-python-mode t)
 '(company-idle-delay 0)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("1e3b2c9e7e84bb886739604eae91a9afbdfb2e269936ec5dd4a9d3b7a943af7f" default)))
 '(doc-view-scale-internally nil)
 '(eshell-buffer-shorthand nil t)
 '(eshell-history-size 10000 t)
 '(evil-ex-visual-char-range t)
 '(evil-want-Y-yank-to-eol t)
 '(exec-path-from-shell-shell-name "/usr/local/bin/zsh")
 '(fci-rule-color "#49483E" t)
 '(flycheck-coffeelintrc "coffeelint.json")
 '(flycheck-disabled-checkers (quote (haml)))
 '(font-latex-fontify-sectioning (quote color))
 '(frame-resize-pixelwise t)
 '(global-subword-mode t)
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "log" "vendor")))
 '(helm-ag-command-option "-S --ignore=vendor")
 '(helm-grep-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" ".gvfs" "log" "vendor")))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hippie-expand-try-functions-list
   (quote
    (try-expand-whole-kill yas-hippie-try-expand try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-line try-complete-lisp-symbol-partially try-complete-lisp-symbol)))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(linum-format " %7i ")
 '(magit-diff-use-overlays nil)
 '(multi-term-dedicated-close-back-to-open-buffer-p t)
 '(multi-term-scroll-to-bottom-on-output t)
 '(multi-term-switch-after-close nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(ns-alternate-modifier (quote meta))
 '(ns-command-modifier (quote super))
 '(org-M-RET-may-split-line (quote ((default))))
 '(org-babel-load-languages
   (quote
    ((emacs-lisp . t)
     (shell . t)
     (python . t)
     (ruby . t)
     (R . t))))
 '(org-blank-before-new-entry (quote ((heading) (plain-list-item))))
 '(org-confirm-babel-evaluate nil)
 '(org-export-headline-levels 1)
 '(org-startup-folded nil)
 '(org-startup-indented t)
 '(org-use-sub-superscripts (quote {}))
 '(package-selected-packages
   (quote
    (lua-mode winum parent-mode fuzzy flymd flx goto-chg undo-tree diminish eval-sexp-fu pkg-info epl f s popup evil avy packed evil-snipe bind-key bind-map powerline hydra seq spinner request pcre2el csv-mode pcache highlight async projectile go-guru iedit hc-zenburn-theme solarized-theme anzu helm helm-core dash sublime-themes minitest hide-comnt auctex-latexmk smartparens ox-reveal rake org alert log4e gntp skewer-mode simple-httpd json-snatcher json-reformat js2-mode haml-mode ham-mode markdown-mode html-to-markdown gitignore-mode flyspell-correct pos-tip flycheck magit magit-popup git-commit with-editor ctable ess julia-mode web-completion-data dash-functional tern go-mode company inflections edn multiple-cursors paredit peg cider queue clojure-mode inf-ruby yasnippet auctex anaconda-mode pythonic auto-complete evil-search-highlight-persist yapfify yaml-mode xterm-color ws-butler window-numbering which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toggle-quotes toc-org tagedit spacemacs-theme spaceline smeargle slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode ruby-refactor rubocop rspec-mode robe restart-emacs rbenv ranger rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-isort pug-mode projectile-rails popwin pip-requirements persp-mode paradox ox-jira ox-gfm orgit org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree multi-term move-text monokai-theme mmm-mode markdown-toc magit-gitflow macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode json-mode js2-refactor js-doc jira-markup-mode jade-mode info+ indent-guide ido-vertical-mode hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio go-eldoc gnuplot gmail-message-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md flyspell-correct-helm flycheck-pos-tip flx-ido fill-column-indicator feature-mode fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu ess-smart-equals ess-R-object-popup ess-R-data-view eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav edit-server dumb-jump define-word cython-mode company-web company-tern company-statistics company-go company-auctex company-anaconda column-enforce-mode coffee-mode clojure-snippets clj-refactor clean-aindent-mode cider-eval-sexp-fu chruby bundler auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(projectile-enable-caching t)
 '(shell-file-name "bash")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(split-height-threshold nil)
 '(split-width-threshold 0)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tramp-default-method "scp")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#20240E" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 257)) (:foreground "#F8F8F2" :background "#272822")) (((class color) (min-colors 89)) (:foreground "#F5F5F5" :background "#1B1E1C")))))
