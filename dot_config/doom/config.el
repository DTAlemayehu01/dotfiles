;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "MesloLGS NF" :size 14 :weight 'light)
;;      ;; can specify :family ""
;;      doom-variable-pitch-font (font-spec :size 14))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
                                        ;(setq org-directory "~/org/")
                                        ;(setq org-roam-directory "~/Documents/roamweb/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! org
  (setq org-directory "~/Org-Sync/")
  ;;(setq org-agenda-files '("")')
  (setq org-log-done 'note)
  (setq org-roam-directory "~/Org-Sync/org-roam")
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n\n* Dailies\n** Meditate\n** Outside\n** Workout\n** Relationship\n** Drink a gallon\n** Read\n** Leetcode\n** Volunteering"))))
  (org-roam-db-autosync-mode)
  (setq org-agenda-files (directory-files-recursively "~/Org-Sync/" "\\.org$"))
  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-todo-log-states)   ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

  (add-hook 'org-after-todo-statistics-hook #'org-summary-todo)
  (setq org-agenda-span 10)
  (setq org-agenda-start-on-weekday nil))

(setq org-capture-templates
      '(("a" "Agenda" entry (file "~/Org-Sync/org-agenda/tenative_events.org")
         "* TODO %?\n %i \n %a")
        ("r" "Refile" entry (file "~/Org-Sync/refile.org")
         "* %?\n %i \n %a")))

(after! projectile
  (setq projectile-project-root-files-bottom-up
        (remove ".git"
                projectile-project-root-files-bottom-up)))

(use-package emojify
  :config
  (setq emojify-display-style 'unicode)
  (setq emojify-emoji-styles '(unicode)))
;;(bind-key* (kbd "C-c .") #'emojify-insert-emoji)) ; override binding in any mode

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))


;; dapy
(require 'dap-python)
(after! dap-mode
  (setq dap-python-debugger 'debugpy))

(defun create-png-xournal-file (&optional only-export)
  "Creates a png from a xournal file and inserts it into the buffer."
  (interactive "P")
  (let ((file-name (expand-file-name
                    (file-name-sans-extension
                     (read-file-name ".xopp file to convert: ")))))
    (shell-command (format "xournalpp --create-img=%s.png %s.xopp"
                           file-name file-name))
    (unless only-export
      (kill-new (concat "[[" file-name ".png" "]]"))
      (yank)
      (org-display-inline-images))
    (org-redisplay-inline-images)))

(bind-key "C-ö" 'create-png-xournal-file)

(require 'org-caldav)

;; Org filename where new entries from calendar stored
(setq org-caldav-inbox "~/Org-Sync/org-inbox/etc-inbox.org")

;; Additional Org files to check for calendar events
(setq org-caldav-files nil)

;; Usually a good idea to set the timezone manually
(setq org-icalendar-timezone "America/Denver")

(setq org-icalendar-include-todo t)

;; Exporters
(with-eval-after-load 'ox
  (require 'ox-hugo))
(require 'ox-ipynb)

(load-file "~/Org-Sync/org-calendars/calendars.el")

;; Latex
(map! :map cdlatex-mode-map :i "TAB" #'cdlatex-tab)

(setq lsp-tex-server 'digestif)

(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

(add-hook 'LaTeX-mode-hook 'global-auto-revert-mode)

(setq org-latex-src-block-backend 'listings)

(defun thanos/wtype-text (text)
  "Process TEXT for wtype, handling newlines properly."
  (let* ((has-final-newline (string-match-p "\n$" text))
         (lines (split-string text "\n"))
         (last-idx (1- (length lines))))
    (string-join
     (cl-loop for line in lines
              for i from 0
              collect (cond
                       ;; Last line without final newline
                       ((and (= i last-idx) (not has-final-newline))
                        (format "wtype \"%s\""
                                (replace-regexp-in-string "\"" "\\\\\"" line)))
                       ;; Any other line
                       (t
                        (format "wtype \"%s\" && wtype -k Return"
                                (replace-regexp-in-string "\"" "\\\\\"" line)))))
     " && ")))

(define-minor-mode thanos/type-mode
  "Minor mode for inserting text via wtype."
  :keymap `((,(kbd "C-c C-c") . ,(lambda () (interactive)
                                   (call-process-shell-command
                                    (thanos/wtype-text (buffer-string))
                                    nil 0)
                                   (delete-frame)))
            (,(kbd "C-c C-k") . ,(lambda () (interactive)
                                   (kill-buffer (current-buffer))))))

(defun thanos/type ()
  "Launch a temporary frame with a clean buffer for typing."
  (interactive)
  (let ((frame (make-frame '((name . "emacs-float")
                             (fullscreen . 0)
                             (undecorated . t)
                             (width . 70)
                             (height . 20))))
        (buf (get-buffer-create "emacs-float")))
    (select-frame frame)
    (switch-to-buffer buf)
    (with-current-buffer buf
      (erase-buffer)
      (org-mode)
      (flyspell-mode)
      (thanos/type-mode)
      (setq-local header-line-format
                  (format " %s to insert text or %s to cancel."
                          (propertize "C-c C-c" 'face 'help-key-binding)
			  (propertize "C-c C-k" 'face 'help-key-binding)))
      ;; Make the frame more temporary-like
      (set-frame-parameter frame 'delete-before-kill-buffer t)
      (set-window-dedicated-p (selected-window) t))))

(require 'calfw-org)

;; elfeed
(defun concatenate-authors (authors-list)
  "Given AUTHORS-LIST, list of plists; return string of all authors concatenated."
  ;;(if (> (length authors-list) 1)
  ;;    (format "%s et al." (plist-get (nth 0 authors-list) :name))
  ;;  (plist-get (nth 0 authors-list) :name)))
  (mapconcat
   (lambda (author) (plist-get author :name))
   authors-list ", "))


(defun my-search-print-fn (entry)
  "Print ENTRY to the buffer."
  (let* ((date (elfeed-search-format-date (elfeed-entry-date entry)))
         (title (or (elfeed-meta entry :title)
                    (elfeed-entry-title entry) ""))
         (title-faces (elfeed-search--faces (elfeed-entry-tags entry)))
         (entry-score (elfeed-format-column (number-to-string (elfeed-score-scoring-get-score-from-entry entry)) 10 :left))
         (entry-authors (concatenate-authors
                         (elfeed-meta entry :authors)))
         (title-width (- (window-width) 10
                         elfeed-search-trailing-width))
         (title-column (elfeed-format-column
                        title 100
                        :left))
         (authors-column (elfeed-format-column entry-authors 40 :left)))
    (insert (propertize date 'face 'elfeed-search-date-face) " ")

    (insert entry-score " ")

    (insert (propertize title-column
                        'face title-faces 'kbd-help title) " ")
    (insert (propertize authors-column
                        'kbd-help entry-authors) " ")))

(use-package! elfeed
  :config
  ;;(setq elfeed-search-filter "@2months")
  ;;(setq elfeed-search-filter "@2-week-ago +unread")
  (setq elfeed-search-print-entry-function #'my-search-print-fn)
  (setq elfeed-search-date-format '("%a %b %d, %Y" 20 :left))
  (setq elfeed-search-title-max-width 110))

(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

;;elfeed-score
(require 'elfeed-score)
(use-package! elfeed-score
  ;;:ensure t
  :after elfeed
  :config
  (setq elfeed-score-serde-score-file "~/Org-Sync/elfeed.score")
  (progn
    ;;(elfeed-score-load-score-file)
    (elfeed-score-enable)
    (define-key elfeed-search-mode-map "=" elfeed-score-map)))
