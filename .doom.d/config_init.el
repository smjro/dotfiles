(eval-and-compile
  (package-initialize)
    (unless (package-installed-p 'leaf)
      (package-refresh-contents)
      (package-install 'leaf))

    ;; Leaf keywords
    (leaf leaf-keywords
      :init
      (leaf el-get :ensure t)
      :config
      ;; initialize leaf-keywords.el
      (leaf-keywords-init)))

(leaf *encoding
  :doc "It's time to use UTF-8"
  :config
  (set-language-environment "Japanese")
  (prefer-coding-system 'utf-8))

(leaf *large-file
  :doc "Adjust large file threshold"
  :custom
  (large-file-warning-threshold . 1000000))

(leaf *global-bindings
  :init
  (define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
  :bind
  (("C-j" . set-mark-command)))

(leaf *hydra-goto
  :doc "Search and move cursor"
  :bind ("M-j" . *hydra-goto/body)
  :pretty-hydra
  ((:title " Goto" :color blue :quit-key "q" :foreign-keys warn :separator "-")
   ("Goto"
    (("i" avy-goto-char       "char")
     ("t" avy-goto-char-timer "timer")
     ("w" avy-goto-word-1     "word")
     ("j" avy-resume "resume"))
    "Line"
    (("h" avy-goto-line        "head")
     ("e" avy-goto-end-of-line "end")
     ("n" consult-goto-line    "number"))
    "Topic"
    (("o"  consult-outline      "outline")
     ("m"  consult-imenu        "imenu")
     ("gm" consult-global-imenu "global imenu"))
    "Error"
    ((","  flycheck-previous-error "previous" :exit nil)
     ("."  flycheck-next-error "next" :exit nil)
     ("l" consult-flycheck "list"))
    "Spell"
    ((">"  flyspell-goto-next-error "next" :exit nil)
     ("cc" flyspell-correct-at-point "correct" :exit nil)))))

(leaf *hydra-search
  :doc "Search functions"
  :bind
  ("M-s" . *hydra-search/body)
  :pretty-hydra
  ((:title " Search" :color blue :quit-key "q" :foreign-keys warn :separator "-")
   ("Buffer"
    (("l" consult-line "line")
     ("o" consult-outline "outline")
     ("m" consult-imenu "imenu"))
    "Project"
    (("f" affe-find "find")
     ("r" affe-grep "grep")))))

(leaf *hydra-toggle
  :doc "Toggle functions"
  :bind ("M-t" . *hydra-toggle/body)
  :pretty-hydra
  ((:title " Toggle" :color blue :quit-key "q" :foreign-keys warn :separator "-")
   ("Basic"
    (("v" view-mode "view mode" :toggle t)
     ("w" whitespace-mode "whitespace" :toggle t)
     ("W" whitespace-cleanup "whitespace cleanup")
     ("r" rainbow-mode "rainbow" :toggle t)
     ("b" beacon-mode "beacon" :toggle t))
    "Line & Column"
    (("l" toggle-truncate-lines "truncate line" :toggle t)
     ("n" display-line-numbers-mode "line number" :toggle t)
     ("f" display-fill-column-indicator-mode "column indicator" :toggle t)
     ("c" visual-fill-column-mode "visual column" :toggle t))
    "Highlight"
    (("h" highlight-symbol "highligh symbol" :toggle t)
     ("L" hl-line-mode "line" :toggle t)
     ("t" hl-todo-mode "todo" :toggle t)
     ("g" git-gutter-mode "git gutter" :toggle t)
     ("i" highlight-indent-guides-mode "indent guide" :toggle t))
    "Window"
    (("t" toggle-window-transparency "transparency" :toggle t)))))

(leaf *hydra-shortcuts
  :doc "General Shortcuts"
  :bind ("M-o" . *hydra-shortcuts/body)
  :pretty-hydra
  ((:title " Shortcuts" :color blue :quit-key "q" :foreign-keys warn :separator "-")
   ("Size"
    (("<left>" (shrink-window-horizontally 3) "←" :exit nil)
     ("<up>"   (shrink-window 3) "↑" :exit nil)
     ("<down>" (enlarge-window 3) "↓" :exit nil)
     ("<right>"(enlarge-window-horizontally 3) "→" :exit nil))
    "Split"
    (("-" split-window-vertically "vertical")
     ("/" split-window-horizontally "horizontal"))
    "Window"
    (("o" other-window "other" :exit nil)
     ("d" kill-current-buffer "close")
     ("D" kill-buffer-and-window "kill")
     ("O" delete-other-windows "close others")
     ("s" ace-swap-window "swap")
     ("<SPC>" rotate-layout "rotate" :exit nil))
    "Buffer"
    (("b" consult-buffer "open")
     ("B" consult-buffer-other-window "open other")
     ("R" (switch-to-buffer (get-buffer-create "*scratch*")) "scratch")
     ("," previous-buffer "previous" :exit nil)
     ("." next-buffer "next" :exit nil))
    "File"
    (("r" consult-buffer "recent")
     ("f" consult-find "find")
     ("p" consult-ghq-find "ghq")
     ("@" projectile-run-shell-command-in-root "$run")
     ("!" projectile-run-async-shell-command-in-root "$async"))
    "Org"
    (("c" org-capture "capture")
     ("a" org-agenda "agenda")
     ("j" org-journal-new-entry "journal")
     ("t" (org-open-file org-task-file) "private")
     ("z" (org-open-file org-work-file) "work")
     ("l" calendar)))))

(leaf *hydra-git
  :bind
  ("M-g" . *hydra-git/body)
  :pretty-hydra
  ((:title " Git" :color blue :quit-key "q" :foreign-keys warn :separator "-")
   ("Basic"
    (("w" magit-checkout "checkout")
     ("s" magit-status "status")
     ("b" magit-branch "branch")
     ("F" magit-pull "pull")
     ("f" magit-fetch "fetch")
     ("A" magit-apply "apply")
     ("c" magit-commit "commit")
     ("P" magit-push "push"))
    ""
    (("d" magit-diff "diff")
     ("l" magit-log "log")
     ("r" magit-rebase "rebase")
     ("z" magit-stash "stash")
     ("!" magit-run "run shell command")
     ("y" magit-show-refs "references"))
    "Hunk"
    (("," git-gutter:previous-hunk "previous" :exit nil)
     ("." git-gutter:next-hunk "next" :exit nil)
     ("g" git-gutter:stage-hunk "stage")
     ("v" git-gutter:revert-hunk "revert")
     ("p" git-gutter:popup-hunk "popup"))
    " GitHub"
    (("C" checkout-gh-pr "checkout PR")
     ("O" +vc/browse-at-remote "browse repository")))))

(leaf *cursor-color-ime
  :preface
  (defun mac-selected-keyboard-input-source-change-hook-func ()
    ;; 入力モードが英語の時はカーソルの色をcyanに、日本語の時はyellowにする
    (set-cursor-color (if (string-match "\\.US$" (mac-input-source))
                          "cyan" "yellow")))

  (add-hook 'mac-selected-keyboard-input-source-change-hook
            'mac-selected-keyboard-input-source-change-hook-func))

(leaf *cursor-style
  :doc "Set cursor style and color"
  :if (window-system)
  :config
  (set-cursor-color "cyan")
  (add-to-list 'default-frame-alist '(cursor-type . bar)))

(leaf migemo
  :doc "Japanese increment search with 'Romanization of Japanese'"
  :url "https://github.com/emacs-jp/migemo"
  :if (executable-find "cmigemo")
  :require migemo
  :custom
  (migemo-options          . '("-q" "--nonewline" "--emacs"))
  (migemo-command          . "/opt/homebrew/bin/cmigemo")
  (migemo-dictionary       . "/opt/homebrew/Cellar/cmigemo/HEAD-9a1cec4/share/migemo/utf-8/migemo-dict")
  (migemo-user-dictionary  . nil)
  (migemo-regex-dictionary . nil)
  (migemo-coding-system    . 'utf-8)
  :hook (after-init-hook . migemo-init))

(leaf anzu
  :doc "Displays current match and total matches information"
  :url "https://github.com/emacsorphanage/anzu"
  :config (global-anzu-mode +1)
  :custom (anzu-use-migemo  . t)
  :bind ("M-r" . anzu-query-replace-regexp))

(leaf highlight-indent-guides
  :doc "Display structure for easy viewing"
  :url "https://github.com/DarthFennec/highlight-indent-guides"
  :hook (prog-mode-hook . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled . t)
  (highlight-indent-guides-responsive   . t)
  (highlight-indent-guides-method . 'bitmap)
  :config
  (highlight-indent-guides-auto-set-faces))

(leaf beacon
  :doc "A light that follows your cursor around so you don't lose it!"
  :url "https://github.com/Malabarba/beacon"
  :config (beacon-mode 1)
  :custom (beacon-color . "#f1fa8c"))

(leaf volatile-highlights
  :doc "Hilight the pasted region"
  :url "https://github.com/k-talo/volatile-highlights.el"
  :global-minor-mode volatile-highlights-mode
  :custom-face
  (vhl/default-face . '((nil (:foreground "#FF3333" :background "#FFCDCD")))))

(leaf highlight-symbol
  :doc "Automatic & Manual symbol highlighting"
  :url "https://github.com/nschum/highlight-symbol.el"
  :hook (prog-mode-hook . highlight-symbol-mode)
  :bind
  (("M-p"   . highlight-symbol-prev)
   ("M-n"   . highlight-symbol-next)))

(leaf neotree
  :doc "Sidebar for dired"
  :url "https://github.com/jaypei/emacs-neotree"
  :bind
  ("<f9>" . neotree-projectile-toggle)
  :custom
  (neo-theme             . 'nerd)
  (neo-cwd-line-style    . 'button)
  (neo-autorefresh       . t)
  (neo-show-hidden-files . t)
  (neo-mode-line-type    . nil)
  (neo-window-fixed-size . nil)
  :hook (neotree-mode-hook . neo-hide-nano-header)
  :preface
  (defun neo-hide-nano-header ()
    "Hide nano header."
    (interactive)
    (setq header-line-format ""))
  (defun neotree-projectile-toggle ()
    "Toggle function for projectile."
    (interactive)
    (let ((project-dir
	   (ignore-errors
	     (projectile-project-root)))
	  (file-name (buffer-file-name)))
      (if (and (fboundp 'neo-global--window-exists-p)
	       (neo-global--window-exists-p))
	  (neotree-hide)
	(progn
	  (neotree-show)
	  (if project-dir
	      (neotree-dir project-dir))
	  (if file-name
	      (neotree-find file-name))))))
  :config
  ;; Use nerd font in terminal.
  (unless (window-system)
    (advice-add
     'neo-buffer--insert-fold-symbol
     :override
     (lambda (name &optional node-name)
       (let ((n-insert-symbol (lambda (n)
				(neo-buffer--insert-with-face
				 n 'neo-expand-btn-face))))
	 (or (and (equal name 'open)  (funcall n-insert-symbol " "))
	     (and (equal name 'close) (funcall n-insert-symbol " "))
	     (and (equal name 'leaf)  (funcall n-insert-symbol ""))))))))

(leaf imenu-list
  :doc "Show the current buffer's imenu entries in a seperate buffer"
  :url "https://github.com/Ladicle/imenu-list"
  :el-get "Ladicle/imenu-list"
  :bind ("<f10>" . imenu-list-smart-toggle)
  :hook (imenu-list-major-mode-hook . neo-hide-nano-header)
  :custom
  (imenu-list-auto-resize . t)
  (imenu-list-focus-after-activation . t)
  (imenu-list-entry-prefix   . "•")
  (imenu-list-subtree-prefix . "•")
  :custom-face
  (imenu-list-entry-face-1          . '((t (:foreground "white"))))
  (imenu-list-entry-subalist-face-0 . '((nil (:weight normal))))
  (imenu-list-entry-subalist-face-1 . '((nil (:weight normal))))
  (imenu-list-entry-subalist-face-2 . '((nil (:weight normal))))
  (imenu-list-entry-subalist-face-3 . '((nil (:weight normal)))))

(leaf *hydra-theme
  :doc "Make emacs bindings that stick around"
  :url "https://github.com/abo-abo/hydra"
  :custom-face
  (hydra-face-red      . '((t (:foreground "#bd93f9"))))
  (hydra-face-blue     . '((t (:foreground "#8be9fd"))))
  (hydra-face-pink     . '((t (:foreground "#ff79c6"))))
  (hydra-face-teal     . '((t (:foreground "#61bfff"))))
  (hydra-face-amaranth . '((t (:foreground "#f1fa8c")))))
(leaf major-mode-hydra
  :doc "Use pretty-hydra to define template easily"
  :url "https://github.com/jerrypnz/major-mode-hydra.el"
  :require pretty-hydra)
(leaf hydra-posframe
  :doc "Show hidra hints on posframe"
  :url "https://github.com/Ladicle/hydra-posframe"
  :if (window-system)
  :el-get "Ladicle/hydra-posframe"
  :global-minor-mode hydra-posframe-mode
  :custom
  (hydra-posframe-border-width . 5)
  (hydra-posframe-parameters   . '((left-fringe . 8) (right-fringe . 8)))
  :custom-face
  (hydra-posframe-border-face . '((t (:background "#323445")))))

(leaf visual-fill-column
  :doc "Centering & Wrap text visually"
  :url "https://codeberg.org/joostkremers/visual-fill-column"
  :hook ((markdown-mode-hook org-mode-hook) . visual-fill-column-mode)
  :custom
  (visual-fill-column-width . 100)
  (visual-fill-column-center-text . t))

(leaf rainbow-mode
  :doc "Color letter that indicate the color"
  :url "https://elpa.gnu.org/packages/rainbow-mode.html"
  :hook (emacs-lisp-mode-hook . rainbow-mode))

;; flyspell + UI
(leaf flyspell
  :doc "Spell checker"
  :url "https://www.emacswiki.org/emacs/FlySpell"
  :hook
  (prog-mode-hook . flyspell-prog-mode)
  ((org-mode-hook markdown-mode-hook git-commit-mode-hook) . flyspell-mode)
  :custom
  (ispell-program-name . "aspell")
  (ispell-extra-args   . '("--sug-mode=ultra" "--lang=en_US" "--run-together"))
  :custom-face
  (flyspell-incorrect  . '((t (:underline (:color "#f1fa8c" :style wave)))))
  (flyspell-duplicate  . '((t (:underline (:color "#50fa7b" :style wave))))))
(leaf flyspell-correct
  :doc "Correcting misspelled words with flyspell using favourite interface"
  :url "https://github.com/d12frosted/flyspell-correct"
  :bind*
  ("C-M-i" . flyspell-correct-at-point)
  :custom
  (flyspell-correct-interface . #'flyspell-correct-completing-read))

(leaf python
  :doc "Python development environment"
  :url "https://wiki.python.org/moin/EmacsPythonMode"
  :mode ("\\.py\\'" . python-mode)
  :preface
  (defun hack-open-browser () (interactive) (shell-command "hack o"))
  (defun hack-add-sample   () (interactive) (shell-command "hack add sample"))
  (defun hack-print-output () (interactive) (async-shell-command "hack t -CIDE --submit=false"))
  (defun hack-print-diff   () (interactive) (async-shell-command "hack t -CIOE --submit=false"))
  (defun hack-test-all     () (interactive) (async-shell-command "hack t -C"))
  (defun hack-test-one-sample ()
    (interactive)
    (let ((sample-id (read-string "sample ID: ")))
      (async-shell-command (concat "hack t -C " sample-id))))
  (defun go-abc-quiz ()
    "Initialize and go contest directory"
    (interactive)
    (let ((contest-id (read-string "Contest ID: "))
          (quiz-id (read-string "Quiz ID: ")))
      (progn
        (unless (file-exists-p
                 (shell-command-to-string (concat "hack g " contest-id)))
          (shell-command (concat "hack i " contest-id)))
        (find-file (concat
                    (shell-command-to-string
                     (concat "hack g " contest-id " " quiz-id))
                    "/main.py")))))
  (defun init-abc ()
    "Initialize and go contest directory"
    (interactive)
    (let ((contest-id (read-string "Contest ID: ")))
      (progn
        (shell-command (concat "hack i -l py " contest-id))
        (find-file (concat
                    (shell-command-to-string
                     (concat "hack g " contest-id " a"))
                    "/main.py"))
        (shell-command (concat "hack o " contest-id "a")))))
  :bind
  (:python-mode-map
   ("C-c C-n" . quickrun)
   ("C-c C-a" . quickrun-with-arg)
   ("C-c C-o" . hack-open-browser)
   ("C-c C-d" . hack-print-output)
   ("C-c C-l" . hack-print-diff)
   ("C-c RET" . hack-test-all)
   ("C-c t"   . hack-test-one-sample)))

(leaf markdown-mode
  :doc "Mafor mode for editing Markdown-formatted text"
  :mode
  (("README\\.md\\'" . gfm-mode)
   ("\\.md\\'"       . markdown-mode))
  :bind
  ((:markdown-mode-map
    ("M-t u" . markdown-toggle-url-hiding)
    ("M-t m" . markdown-toggle-markup-hiding)))
  :custom
  (markdown-hide-urls . nil)  ;; URLの記載を隠すかどうか
  (markdown-hide-markup . nil)  ;; 見出しの#やboldの*などを隠すかどうか
  (markdown-list-item-bullets . '("★"))  ;; bulletsの表示を変更
  (markdown-fontify-code-blocks-natively . t)  ;; コードブロックに色をつける
  :custom-face
  (markdown-header-face-1 . '((t (:inherit outline-1 :weight bold :height 1.5))))
  (markdown-header-face-2 . '((t (:inherit outline-1 :weight normal :height 1.2))))
  (markdown-header-face-3 . '((t (:inherit outline-1 :weight normal :height 1.1))))
  (markdown-header-face-4 . '((t (:inherit outline-1 :weight normal))))
  (markdown-bold-face . '((t (:foreground "#f8f8f2" :weight bold))))
  (markdown-italic-face . '((t (:foreground "#f8f8f2" :slant italic))))
  (markdown-header-delimiter-face . '((t (:foreground "#6272a4" :weight normal))))  ;; 見出しの#の色
  (markdown-link-face . '((t (:foreground "#f1fa8c"))))
  (markdown-url-face . '((t (:foreground "#6272a4"))))
  (markdown-list-face . '((t (:foreground "#6272a4"))))
  (markdown-gfm-checkbox-face . '((t (:foreground "#6272a4"))))
  (markdown-metadata-value-face . '((t (:foreground "#8995ba"))))
  (markdown-metadata-key-face . '((t (:foreground "#6272a4"))))
  (markdown-pre-face . '((t (:foreground "#8be9fd"))))  ;; シングルクォートによるコード表示の色
  )

(leaf avy
  :doc "Jump to things in tree-style"
  :url "https://github.com/abo-abo/avy"
  :bind* ("C-;" . avy-goto-char-timer))

(leaf avy-zap
  :doc "Zap to char using avy"
  :url "https://github.com/cute-jumper/avy-zap"
  :bind
  (("M-z" . avy-zap-to-char-dwim)
   ("M-z" . avy-zap-up-to-char-dwim)))

(leaf *smart-kill
  :bind*
  (("M-d" . kill-word-at-point)
   ("C-w" . backward-kill-word-or-region))
  :init
  (defun kill-word-at-point ()
    (interactive)
    (let ((char (char-to-string (char-after (point)))))
      (cond
       ((string= " " char) (delete-horizontal-space))
       ((string-match "[\t\n -@\[-`{-~],.、。" char) (kill-word 1))
       (t (forward-char) (backward-word) (kill-word 1)))))
  (defun backward-kill-word-or-region (&optional arg)
    (interactive "p")
    (if (region-active-p)
        (call-interactively #'kill-region)
      (backward-kill-word arg))))

(leaf *adjust-frame-position
  :doc "Place frame on the right side of the screen"
  :if (window-system)
  :config
  (set-frame-position nil (/ (display-pixel-width) 2) 0)
  (if (< (display-pixel-width) 1800)
      (set-frame-size nil 100 63)))

(leaf rotate
  :doc "Rotate the layout like tmux panel"
  :url "https://github.com/daichirata/emacs-rotate"
  :el-get "daichirata/emacs-rotate"
  :require t)

(leaf ace-window
  :doc "Select window like tmux"
  :url "https://github.com/abo-abo/ace-window"
  :bind
  ("C-o" . ace-window)
  :custom
  (aw-keys . '(?j ?k ?l ?i ?o ?h ?y ?u ?p))
  :custom-face
  (aw-leading-char-face . '((t (:height 4.0 :foreground "#f1fa8c")))))

(leaf *window-transparency
  :doc "Set window transparency level"
  :if (window-system)
  :hook (after-init-hook . toggle-window-transparency)
  :custom
  (window-transparency . 88)
  :preface
  (defun toggle-window-transparency ()
    "Cycle the frame transparency from default to transparent."
    (interactive)
    (let ((transparency window-transparency)
          (opacity 100))
      (if (and (not (eq (frame-parameter nil 'alpha) nil))
               (< (frame-parameter nil 'alpha) opacity))
          (set-frame-parameter nil 'alpha opacity)
        (set-frame-parameter nil 'alpha transparency)))))

(leaf org-theme
  :doc "Theme for org-mode"
  :custom
  (org-todo-keyword-faces
   . '(("WAIT" . (:foreground "#6272a4" :weight bold :width condensed))
       ("NEXT" . (:foreground "#f1fa8c" :weight bold :width condensed))))
  :custom-face
  (org-level-1         . '((t (:inherit outline-1 :height 1.2))))
  (org-level-2         . '((t (:inherit outline-2 :weight normal))))
  (org-level-3         . '((t (:inherit outline-3 :weight normal))))
  (org-level-4         . '((t (:inherit outline-4 :weight normal))))
  (org-level-5         . '((t (:inherit outline-5 :weight normal))))
  (org-level-6         . '((t (:inherit outline-6 :weight normal))))
  (org-link            . '((t (:foreground "#f1fa8c" :underline nil :weight normal))))
  (org-document-title  . '((t (:foreground "#f8f8f2"))))
  (org-list-dt         . '((t (:foreground "#bd93f9"))))
  (org-footnote        . '((t (:foreground "#76e0f3"))))
  (org-special-keyword . '((t (:foreground "#6272a4"))))
  (org-drawer          . '((t (:foreground "#44475a"))))
  (org-checkbox        . '((t (:foreground "#bd93f9"))))
  (org-tag             . '((t (:foreground "#6272a4"))))
  (org-meta-line       . '((t (:foreground "#6272a4"))))
  (org-date            . '((t (:foreground "#8995ba"))))
  (org-priority        . '((t (:foreground "#ebe087"))))
  (org-todo            . '((t (:foreground "#51fa7b" :weight bold :width condensed))))
  (org-done            . '((t (:background "#373844" :foreground "#216933" :strike-through nil :weight bold :width condensed)))))

(leaf org-bullets
  :doc "Change bullet icons"
  :url "https://github.com/sabof/org-bullets"
  :hook   (org-mode-hook . org-bullets-mode)
  :custom (org-bullets-bullet-list . '("" "" "" "" "" "" "" "" "" "")))

(leaf org-modern
  :doc "To Be Modern Looks"
  :url "https://github.com/minad/org-modern"
  :hook (org-mode-hook . org-modern-mode)
  :custom
  (org-modern-hide-stars     . nil)
  (org-modern-progress       . nil)
  (org-modern-todo           . nil)
  (org-modern-block          . nil)
  (org-modern-table-vertical . 1)
  (org-modern-timestamp      . t)
  ;; use nerd font icons
  (org-modern-star           . [""  "" "" "" "" "" "" "" "" ""])
  (org-modern-priority       . '((?A . "") (?B . "") (?C . "")))
  (org-modern-checkbox       . '((?X . "") (?- . "") (?\s . "")))
  :custom-face
  (org-modern-date-active   . '((t (:background "#373844" :foreground "#f8f8f2" :height 0.75 :weight light :width condensed))))
  (org-modern-time-active   . '((t (:background "#44475a" :foreground "#f8f8f2" :height 0.75 :weight light :width condensed))))
  (org-modern-date-inactive . '((t (:background "#373844" :foreground "#b0b8d1" :height 0.75 :weight light :width condensed))))
  (org-modern-time-inactive . '((t (:background "#44475a" :foreground "#b0b8d1" :height 0.75 :weight light :width condensed))))
  (org-modern-tag           . '((t (:background "#44475a" :foreground "#b0b8d1" :height 0.75 :weight light :width condensed))))
  (org-modern-statistics    . '((t (:foreground "#6272a4" :weight light :width condensed)))))
