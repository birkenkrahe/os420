(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)

;; package management
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/") t)

;; remove startup screen - get it back with M-x about-emacs
;; (setq inhibit-startup-screen t)

;; remove menu bar - to bring it back: M-x menu-bar-mode (toggles)
(menu-bar-mode 1)
(tool-bar-mode 1)

;; require org-tempo so that <s <TAB> self-insert works
;; this will give an error unless you install Org from the org repo
;; run M-x package-list-packages to do this
;;(require 'org-tempo)

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
;; invoke skeleton quickly with C-S-f4
(define-skeleton org-skeleton
  "Header info for a emacs-org file."
  "Title: "  
  "#+TITLE:" str " \n"
  "#+AUTHOR:" str " \n"
  "#+SUBTITLE:" str " \n"
  "#+STARTUP:overview hideblocks\n"
  "#+OPTIONS: toc:nil num:nil ^:nil\n"
  "#+PROPERTY: header-args:C :main yes"
  "#+PROPERTY: header-args:C :includes <stdio.h> <math.h>"
  "#+PROPERTY: header-args:C :comments both :exports both"
  "#+PROPERTY: header-args:R :session :results output"
  "#+PROPERTY: header-args:R :exports both :comments both"
  "#+PROPERTY: header-args:sqlite :exports both :db sqlite.db"  
  "#+PROPERTY: header-args:bash :exports both :comments both"
                                        ;  "#+AUTHOR: Your Name\n"
                                        ;  "#+email: your-email@server.com\n"
                                        ;  "#+INFOJS_OPT: :view:info \n"
                                        ;  "#+BABEL: :session *R* :cache yes :results output graphics :exports both :tangle yes \n"
                                        ;  "-----"
  )
(global-set-key [C-S-f4] 'org-skeleton)

;; display inline images by default
(setq org-display-inline-images t)
(setq org-redisplay-inline-images t)
;;(setq org-startup-with-inline-images "inlineimages")

;; new with emacs 27 - to see PDF files
(push '("\\.pdf\\'" . emacs) org-file-apps)

;; enable global line numbers display
;;(global-display-line-numbers-mode)

;; allow region to be narrowed (buffer better to draw in)
(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

;; fixes the "failed to download gnu archive" error
;; when running package-refresh-contents
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

