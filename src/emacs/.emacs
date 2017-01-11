;; DO NOT DELETE
(eval-after-load "warnings"
  '(setq display-warning-minimum-level :error))
(load "std.el")
(load "std_comment.el")
(add-to-list 'load-path "~/.emacs.d/")

(setq emacs-lisp-dir "~/.emacs.d/"
      my-elmode-dir (concat emacs-lisp-dir "elmodes/"))
(setq load-path
      (append load-path (list my-elmode-dir)))

(add-to-list 'load-path "~/.emacs.d/")

;; MELPA
(require 'package)
(add-to-list 'package-archives
                          '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Affichage des lignes
(global-linum-mode 1)
(setq linum-format "%4d \u2502 ")

;; 80 char wide lines
(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)

;; Parentheses
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode highlight-parentheses-mode
  (lambda nil (highlight-parentheses-mode t)))

(global-highlight-parentheses-mode t)

;; Suppression des espaces en fin de ligne dans les fichiers C et C++
(add-hook 'c-mode-hook '(lambda () (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook 'c++-mode-hook '(lambda () (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))

;; Deplacement auto des fichier~ dans le dossier ~/.emacs.d/backup
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 5
      kept-old-versions 5
      )

;; Auto-completion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)


;; Config pour le web dev
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("blade"  . "\\.blade\\."))
      )

;; OCaml mode
(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)

;; Tab width
(customize-variable (quote tab-stop-list))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Mode-line theme
(setq sml/no-confirm-load-theme t)
(sml/setup)

;; Map Crystal files to Ruby syntax
(add-to-list 'auto-mode-alist '("\\.cr\\'" . ruby-mode))

;; CUSTOM SET VARS
;; This really should be on top of the file, but it breaks EVERYTHING to move it
;; So, fuck this.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2D2D2D" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (smart-mode-line-powerline monokai)))
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "d14c0b70b955a3f124c55418668408e2a5b9d7d8b9f12fda92e45913d3143a2c" default)))
 '(fci-rule-color "#3E3D31")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3E3D31" . 0)
     ("#67930F" . 20)
     ("#349B8D" . 30)
     ("#21889B" . 50)
     ("#968B26" . 60)
     ("#A45E0A" . 70)
     ("#A41F99" . 85)
     ("#3E3D31" . 100))))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (vala-mode dockerfile-mode yaml-mode xterm-color stylus-mode smart-mode-line-powerline-theme scss-mode pkgbuild-mode pkg-info nhexl-mode monokai-theme markdown-preview-mode lorem-ipsum highlight-parentheses gitignore-mode fish-mode dash csharp-mode coffee-mode cmake-mode caml auto-complete ascii 2048-game)))
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#2D2D2D")
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(vc-annotate-background nil)
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
   (unspecified "#2D2D2D" "#3E3D31" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
