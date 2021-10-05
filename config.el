;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ho Young Jhoo"
      user-mail-address "starvessel@naver.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-pakckage'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'M-m c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'M-m c d') to jump to their definition and see how
;; they are implemented.
(setq doom-font (font-spec :family "Fira Code" :size 12))
(global-set-key (kbd "M-m") nil)
(setq doom-leader-key "M-n")
(setq doom-leader-alt-key "M-m")
;; (setq doom-localleader-key "M-n")
;; (setq doom-localleader-alt-key "M-m")
;; (setq doom-leader-alt-key "M-m")

(setq default-frame-alist '((left . 10) (top . 35) (width . 141) (height . 65)))
(setq c-basic-offset 2)
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq confirm-kill-emacs nil)
(setq proof-three-window-mode-policy 'hybrid)

(map! "C-x h" 'windmove-left
      "C-x j" 'windmove-down
      "C-x k" 'windmove-up
      "C-x l" 'windmove-right)
;(map! "" 'ccls-reload)

(map! :map c-mode-map "C-c C-r" 'ccls-reload
      :map cpp-mode-map "C-c C-r" 'ccls-reload)

(require 'multiple-cursors)
(map! "C-c m" 'mc/edit-lines
      "C->" 'mc/mark-next-like-this
      "C-<" 'mc/mark-previous-like-this
      "C-c C-<" 'mc/mark-all-like-this)

(require 'math-symbol-lists)
(quail-define-package "math" "UTF-8" "Ω" t)
(quail-define-rules ; whatever extra rules you want to define...
 ("\\from"    #X2190)
 ("\\to"      #X2192)
 ("\\lhd"     #X22B2)
 ("\\rhd"     #X22B3)
 ("\\unlhd"   #X22B4)
 ("\\unrhd"   #X22B5))
(mapc (lambda (x)
        (if (cddr x)
            (quail-defrule (cadr x) (car (cddr x)))))
      (append math-symbol-list-basic math-symbol-list-extended))

(defun activate-math-symbol ()
  (interactive)
  (activate-input-method "math"))
(add-hook! company-coq-mode 'activate-math-symbol)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-hook 'company-coq-mode-hook
          (lambda ()
                  (set-face-attribute 'company-coq-comment-h1-face nil :height 1.2)
                  (set-face-attribute 'company-coq-comment-h2-face nil :height 1.1)
                  (set-face-attribute 'company-coq-comment-h3-face nil :height 1.0)))
(after! rustic
  (setq rustic-lsp-server 'rls))

(setq lsp-haskell-formatting-provider "stylish-haskell")
(setq haskell-stylish-on-save t)
