;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
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
   dotspacemacs-enable-lazy-installation nil ;; Prevent install of ansible layer
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

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
     ;; ansible  ;; Must disable ansible for now https://github.com/syl20bnr/spacemacs/issues/8027
     auto-completion
     ;; better-defaults
     clojure
     csv
     deft
     emacs-lisp
     ess
     (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     git
     ;; Github processing is too slow with the Console repo
     ;; github
     (go :variables
         go-tab-width 2
         go-use-golangci-lint t
         )
     helm
     html
     (javascript :variables
                 javascript-backend 'lsp
                 javascript-fmt-tool 'prettier
                 javascript-fmt-on-save t)
     latex
     lsp
     lua
     (markdown :variables
               markdown-list-indent-width 2
               markdown-live-preview-engine 'vmd)
     nginx
     (org :variables
          org-enable-github-support t)
     ;; Not available until next Spacemacs release
     ;; parinfer
     ;; perl5
     php
     (python :variables
             python-enable-yapf-format-on-save t
             python-auto-set-local-pyenv-version 'on-project-switch)
     react
     (ruby :variables
           ruby-insert-encoding-magic-comment nil
           ruby-version-manager 'rbenv)
     ruby-on-rails
     rust
     (shell :variables
            shell-default-position 'bottom
            shell-enable-smart-eshell t
            shell-default-shell 'multi-term)
     spell-checking
     sql
     syntax-checking
     (typescript :variables
                 typescript-fmt-on-save t
                 typescript-fmt-tool 'prettier)
     ;; For a git-gutter style indicator
     ;; (version-control :variables
     ;;                  version-control-diff-tool 'diff-hl
     ;;                  version-control-diff-side 'left)
     yaml
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(ob-clojurescript org-web-tools atomic-chrome yasnippet-snippets)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(adaptive-wrap)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update t
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

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
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode nil

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(monokai
                         ;; spacemacs-dark
                         ;; dichromacy
                         ;; spacemacs-light
                         solarized-light
                         ;; solarized-dark
                         ;; hc-zenburn
                         ;; zenburn
                         )
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
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
   ;; I don't use this and I need M-RET to work in org-mode
   ;; See https://github.com/syl20bnr/spacemacs/issues/9603
   dotspacemacs-major-mode-emacs-leader-key "C-S-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
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
   dotspacemacs-auto-resume-layouts t
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

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
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

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but lines are only visual lines are counted. For example, folded lines
   ;; will not be counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers '(:relative t
                                         :size-limit-kb 200)
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "develop: %f"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfer with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

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
    (browse-url "http://platform.civis.test:3000"))

  (defun private/open-local-platform-in-browser ()
    "Open a browser window to local civis"
    (interactive)
    (browse-url "http://platform.civis.test:3000"))

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
  (defun private/align-colons (beg end)
    "Align the given region for key: value content"
    (interactive)
    (align-regexp beg end ":\\(\\s-*\\)" 1 1 nil))
  (defun private/evil-select-pasted ()
    "Visually select last pasted text."
    (interactive)
    (evil-goto-mark ?\[)
    (evil-visual-char)
    (evil-goto-mark ?\]))
  ;; The semantic package in Spacemacs wants to parse every buffer, which is no good!
  (defun private/reformat-lisp ()
    "Use srefactor to format lisp code"
    (interactive)
    (unless (package-installed-p 'srefactor)
      (package-install 'srefactor)
      (require 'srefactor)
      (require 'srefactor-lisp))
    (srefactor-lisp-format-buffer))
  (defun private/insert-datestamp ()
    "Insert RFC 3339 timestamp into current buffer"
    (interactive)
    (insert (shell-command-to-string "echo -n $(gdate --rfc-3339=seconds)")))
  (setq-default evil-snipe-use-vim-sneak-bindings t))


(defun dotspacemacs/user-config ()
  "Configuration function for user code.
 This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  (setq-default
   evil-escape-delay 0.2
   evil-escape-unordered-key-sequence t
   multi-term-program "/usr/local/bin/zsh")

  (spacemacs/set-leader-keys
    "SPC" 'evil-avy-goto-word-or-subword-1)
  (spacemacs/set-leader-keys "of" 'make-frame)
  (spacemacs/set-leader-keys "ob" 'spacemacs/new-empty-buffer)
  (spacemacs/set-leader-keys "ot" 'private/insert-datestamp)
  (spacemacs/set-leader-keys "o'" 'private/projectile-eshell-in-root)
  (spacemacs/set-leader-keys "oy" 'private/show-and-copy-buffer-filename-from-root)
  (spacemacs/set-leader-keys "oc" 'private/open-local-platform-in-browser)
  (spacemacs/set-leader-keys "ov" 'private/evil-select-pasted)
  (spacemacs/set-leader-keys "o/" 'clone-indirect-buffer-other-window)
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
  ;; Fix Coffeescript indentation per https://github.com/syl20bnr/spacemacs/issues/7682#issuecomment-314691091
  ;; Remove spacemacs hook for coffee-mode
  (remove-hook 'coffee-mode-hook '(lambda ()
                                    (setq indent-line-function 'javascript/coffee-indent
                                          evil-shift-width coffee-tab-width)))

  ;; For atomic-chrome
  (atomic-chrome-start-server)
  (setq atomic-chrome-default-major-mode 'markdown-mode)
  (setq atomic-chrome-url-major-mode-alist
        '(
	  ;; ("mail\\.google\\.com" . ham-mode)
          ("github\\.com" . gfm-mode)))

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
                                           try-expand-line-all-buffers
                                           try-expand-dabbrev-all-buffers
                                           try-expand-dabbrev-from-kill
                                           try-expand-list
                                           try-complete-file-name-partially
                                           try-complete-file-name
                                           try-expand-all-abbrevs
                                           try-complete-lisp-symbol-partially
                                           try-complete-lisp-symbol))
  ;; Enable autocompletion everywhere
  (global-company-mode)
  (setq company-idle-delay 0.1)
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

  ;; Use emacs virtualenv
  (pyvenv-workon "emacs")

  ;; Fix for org-mode easy templates moved into their own package
  (when (version<= "9.2" (org-version))
    (require 'org-tempo))

  ;; Fix for git blame micro state in Spacemacs 0.2x
  (spacemacs/set-leader-keys "gb" 'magit-blame-addition)

  ;; Fix for Emacs url package issue with HTTPS urls
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

  ;; Deft settings
  (setq deft-extensions '("md" "org" "txt")
        deft-new-file-format "%FT%T%z"
        deft-auto-save-interval 60.0
        deft-markdown-mode-title-level 1
        deft-use-filename-as-title nil
        deft-use-filter-string-for-filename nil)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-disable-faces nil)
 '(avy-subword-extra-word-chars nil)
 '(coffee-indent-like-python-mode t)
 '(compilation-message-face (quote default))
 '(deft-directory
    "~/Box Sync/Notes (skomanduri@civisanalytics.com)/Notes/deft")
 '(doc-view-scale-internally nil)
 '(eshell-buffer-shorthand nil t)
 '(eshell-history-size 10000 t)
 '(evil-ex-visual-char-range t)
 '(evil-want-Y-yank-to-eol t)
 '(evil-want-fine-undo t)
 '(flycheck-coffeelintrc "coffeelint.json")
 '(flycheck-disabled-checkers (quote (haml)))
 '(font-latex-fontify-sectioning (quote color))
 '(frame-resize-pixelwise t)
 '(global-subword-mode t)
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "log" "vendor")))
 '(helm-ag-command-option "-S --ignore=vendor --ignore=reveal.js")
 '(helm-grep-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" ".gvfs" "log" "vendor" "reveal.js")))
 '(hippie-expand-try-functions-list
   (quote
    (try-expand-whole-kill yas-hippie-try-expand try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-line try-complete-lisp-symbol-partially try-complete-lisp-symbol)))
 '(magit-diff-use-overlays nil)
 '(multi-term-dedicated-close-back-to-open-buffer-p t)
 '(multi-term-scroll-to-bottom-on-output t)
 '(multi-term-switch-after-close nil)
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
    (vmd-mode esxml parseedn parseclj a yasnippet-snippets atomic-chrome websocket flycheck-golangci-lint transient lv org-web-tools flycheck-gometalinter ob-clojurescript treepy graphql sql-indent deft sesman toml-mode racer flycheck-rust cargo rust-mode wgrep smex org-mime ivy-hydra parent-mode flyspell-correct-ivy flx ghub let-alist goto-chg counsel-projectile counsel swiper ivy eval-sexp-fu pkg-info epl popup org-category-capture nlinum-relative nlinum undo-tree phpunit phpcbf php-extras php-auto-yasnippets drupal-mode php-mode diminish f s winum fuzzy flymd company-ansible git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter diff-hl jinja2-mode ansible-doc ansible lua-mode nginx-mode evil avy packed evil-snipe bind-key bind-map powerline hydra seq spinner request pcre2el csv-mode pcache highlight async projectile go-guru iedit hc-zenburn-theme solarized-theme anzu helm helm-core dash sublime-themes minitest hide-comnt auctex-latexmk smartparens ox-reveal rake org alert log4e gntp skewer-mode simple-httpd json-snatcher json-reformat js2-mode haml-mode ham-mode markdown-mode html-to-markdown gitignore-mode flyspell-correct pos-tip flycheck magit magit-popup git-commit with-editor ctable ess julia-mode web-completion-data dash-functional tern go-mode company inflections edn multiple-cursors paredit peg cider queue clojure-mode inf-ruby yasnippet auctex anaconda-mode pythonic auto-complete evil-search-highlight-persist yapfify yaml-mode xterm-color ws-butler window-numbering which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toggle-quotes toc-org tagedit spacemacs-theme spaceline smeargle slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode ruby-refactor rubocop rspec-mode robe restart-emacs rbenv ranger rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-isort pug-mode projectile-rails popwin pip-requirements persp-mode paradox ox-jira ox-gfm orgit org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree multi-term move-text monokai-theme mmm-mode markdown-toc magit-gitflow macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode json-mode js2-refactor js-doc jira-markup-mode jade-mode info+ indent-guide ido-vertical-mode hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio go-eldoc gnuplot gmail-message-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md flyspell-correct-helm flycheck-pos-tip flx-ido fill-column-indicator feature-mode fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu ess-smart-equals ess-R-object-popup ess-R-data-view eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav edit-server dumb-jump define-word cython-mode company-web company-tern company-statistics company-go company-auctex company-anaconda column-enforce-mode coffee-mode clojure-snippets clj-refactor clean-aindent-mode cider-eval-sexp-fu chruby bundler auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(projectile-enable-caching t)
 '(scroll-margin 5)
 '(sh-basic-offset 2)
 '(shell-file-name "bash")
 '(split-height-threshold nil)
 '(split-width-threshold 0)
 '(standard-indent 2)
 '(tramp-default-method "scp")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil))

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
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
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("1e3b2c9e7e84bb886739604eae91a9afbdfb2e269936ec5dd4a9d3b7a943af7f" default)))
 '(deft-directory
    "~/Box Sync/Notes (skomanduri@civisanalytics.com)/Notes/deft")
 '(doc-view-scale-internally nil)
 '(eshell-buffer-shorthand nil t)
 '(eshell-history-size 10000 t)
 '(evil-ex-visual-char-range t)
 '(evil-want-Y-yank-to-eol t)
 '(evil-want-fine-undo t)
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
 '(magit-diff-use-overlays nil)
 '(markdown-command "pandoc")
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
     (clojurescript . t)
     (R . t))))
 '(org-blank-before-new-entry (quote ((heading) (plain-list-item))))
 '(org-confirm-babel-evaluate nil)
 '(org-export-headline-levels 1)
 '(org-startup-folded nil)
 '(org-startup-indented t)
 '(org-use-sub-superscripts (quote {}))
 '(package-selected-packages
   (quote
    (edit-indirect sqlformat org-web-tools flycheck-clojure org-category-capture nlinum-relative nlinum undo-tree phpunit phpcbf php-extras php-auto-yasnippets drupal-mode php-mode diminish f s winum fuzzy flymd company-ansible git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter diff-hl jinja2-mode ansible-doc ansible lua-mode nginx-mode evil avy packed evil-snipe bind-key bind-map powerline hydra seq spinner request pcre2el csv-mode pcache highlight async projectile go-guru iedit hc-zenburn-theme solarized-theme anzu helm helm-core dash sublime-themes minitest hide-comnt auctex-latexmk smartparens ox-reveal rake org alert log4e gntp skewer-mode simple-httpd json-snatcher json-reformat js2-mode haml-mode ham-mode markdown-mode html-to-markdown gitignore-mode flyspell-correct pos-tip flycheck magit magit-popup git-commit with-editor ctable ess julia-mode web-completion-data dash-functional tern go-mode company inflections edn multiple-cursors paredit peg cider queue clojure-mode inf-ruby yasnippet auctex anaconda-mode pythonic auto-complete evil-search-highlight-persist yapfify yaml-mode xterm-color ws-butler window-numbering which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toggle-quotes toc-org tagedit spacemacs-theme spaceline smeargle slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode ruby-refactor rubocop rspec-mode robe restart-emacs rbenv ranger rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-isort pug-mode projectile-rails popwin pip-requirements persp-mode paradox ox-jira ox-gfm orgit org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree multi-term move-text monokai-theme mmm-mode markdown-toc magit-gitflow macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode json-mode js2-refactor js-doc jira-markup-mode jade-mode info+ indent-guide ido-vertical-mode hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio go-eldoc gnuplot gmail-message-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md flyspell-correct-helm flycheck-pos-tip flx-ido fill-column-indicator feature-mode fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu ess-smart-equals ess-R-object-popup ess-R-data-view eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav edit-server dumb-jump define-word cython-mode company-web company-tern company-statistics company-go company-auctex company-anaconda column-enforce-mode coffee-mode clojure-snippets clj-refactor clean-aindent-mode cider-eval-sexp-fu chruby bundler auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(projectile-enable-caching t)
 '(scroll-margin 5)
 '(sh-basic-offset 2)
 '(shell-file-name "bash")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(split-height-threshold nil)
 '(split-width-threshold 0)
 '(standard-indent 2)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tramp-default-method "scp")
 '(typescript-indent-level 2)
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
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 257)) (:foreground "#F8F8F2" :background "#272822")) (((class color) (min-colors 89)) (:foreground "#F5F5F5" :background "#1B1E1C")))))
