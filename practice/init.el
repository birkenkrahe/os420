(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; suggestions from Udemy Emacs course
;; https://www.udemy.com/course/learning-to-work-with-emacs/learn/lecture/13551146#overview
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages") t)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages") t)
(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/") t)

;; remove startup screen - get it back with M-x about-emacs
(setq inhibit-startup-screen t)

;; remove menu bar - to bring it back: M-x menu-bar-mode (toggles)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; re-indenting of whole buffer according to mode
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  )

;; require org-tempo so that <s <TAB> self-insert works
(require 'org-tempo)

;; require ob-sqlite and ob-sql (for compilation in org src blocks) & tangle
(require 'ob-sqlite)
(require 'ob-sql)
(require 'ob-tangle)
(require 'ob-calc)
(require 'ob-octave)
(require 'ob-emacs-lisp)
(require 'ob-R)
(require 'ob-shell)

;; Syntax highlight code in your SRC blocks The last variable removes
;; the annoying “Do you want to execute” your code when you type:
;; C-c C-c
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

;; enables Babel to process source blocks
(org-babel-do-load-languages
 'org-babel-load-languages '((python . t)
                             (ruby . t)
                             (C . t)
                             (js . t)
                             (perl . t)
                             (emacs-lisp . t)
                             (shell . t)
                             (css . t)
                             (R . t)
                             (sql . t)
                             ))

;; babel R skeleton code
;; source: https://orgmode.org/worg/org-contrib/babel/how-to-use-Org-Babel-for-R.html
;; BABEL header settings:
;; session *R* - all R code in the same session (access blocks from other code blocks)
;; cache yes - avoid reevaluating unchanged code blocks
;; results output graphics / exports both - R code, text and graphics output in one document
;; tangle: yes - pure code can be extracted with C-c C-v t
;; "-------" generates a horizontal line in HTML
;; invoke skeleton quickly with C-S-f4
(define-skeleton org-skeleton
  "Header info for a emacs-org file."
  "Title: "  
  "#+TITLE:" str " \n"
  "#+AUTHOR:" str " \n"
  "#+SUBTITLE:" str " \n"
  "#+STARTUP:overview hideblocks\n"
  "#+OPTIONS: toc:nil num:nil ^:nil\n"
                                        ;  "#+AUTHOR: Your Name\n"
                                        ;  "#+email: your-email@server.com\n"
                                        ;  "#+INFOJS_OPT: :view:info \n"
                                        ;  "#+BABEL: :session *R* :cache yes :results output graphics :exports both :tangle yes \n"
                                        ;  "-----"
  )
(global-set-key [C-S-f4] 'org-skeleton)

;; frame size 100 x 60 - position top right.
;;(add-to-list 'default-frame-alist '(height . 58))
;;(add-to-list 'default-frame-alist '(width . 116))
;;(add-to-list 'default-frame-alist '(user-position . t))

;; unfill region
(defun unfill-region (beg end)
  "Unfill the region, joining text paragraphs into a single
    logical line.  This is useful, e.g., for use with
    `visual-line-mode'."
  (interactive "*r")
  (let ((fill-column (point-max)))
    (fill-region beg end)))

;; Handy key definition
(define-key global-map "\C-\M-Q" 'unfill-region)

;; inditate sequential work progress states see orgguide 9.3 sect. 5.2 p.11
(setq org-todo-keywords
      '((sequence "NEXT" "TODO" "IN PROGRESS" "READ" "WAITING" "SOMEDAY" "PROJECT" "FEEDBACK" "VERIFY" "|" "DONE" "CANCELLED")))

;; set faces for org-mode keywords
(setq org-todo-keyword-faces
      '(("TODO" . "red")
        ("DONE" . "green")
        ("UPDATE" . "orange")
        ("CANCELED" . (:foreground "blue" :weight bold))))

;; set default target for notes orgguide 9.3 sec.9
(setq org-default-notes-file (concat org-directory "/OneDrive/org/notes.org"))
(put 'downcase-region 'disabled nil)

;; display inline images by default
(setq org-display-inline-images t)
(setq org-redisplay-inline-images t)
;;(setq org-startup-with-inline-images "inlineimages")

;; set font
;; Set default font
(set-face-attribute 'default nil
                    :family "Hack"
                    ;; :family "Source Code Pro"
                    :height 140
                    :weight 'normal
                    :width 'normal)

;; new with emacs 27 - to see PDF files
(push '("\\.pdf\\'" . emacs) org-file-apps)

;; enable global line numbers display
;;(global-display-line-numbers-mode)

;; allow region to be narrowed (buffer better to draw in)
(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

;; enable global line highlighting
;;(global-hl-line-mode 1)

;; fixes the "failed to download gnu archive" error
;; when running package-refresh-contents
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
