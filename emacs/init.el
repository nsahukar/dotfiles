;; GENERAL

;; Inhibit startup message
(setq inhibit-startup-message t)

;; Disable menubar
(menu-bar-mode -1)

;; Disable toolbar
(tool-bar-mode -1)

;; Disable visible scrollbar
(scroll-bar-mode -1)

;; Disable tooltips
(tooltip-mode -1)

;; Font
(set-face-attribute 'default nil 
  :font "Jetbrains Mono" 
  :height 140)

;; Hack to get the background color in terminal same as terminal
(set-face-background 'default "undefined")

;; MELPA
;; Enable installation of pacakges from MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; use-package 
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


;; which-key
(use-package which-key
  :config (which-key-mode))


;; vertico
(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-cycle t))


;; evil-collection-issue #60 (Refer github)
(setq evil-want-keybinding nil)
;; evil
(use-package evil
  :config (evil-mode 1))
;; evil-collection
(use-package evil-collection
  :after evil
  :init (evil-collection-init))


;; modus-themes
(use-package modus-themes
  :init
  ;; Add all your customizations prior to laoding the themes
  (setq modus-themes-italic-constructs t
     modus-themes-bold-constructs nil
     modus-themes-region '(bg-only no-extend)
     modus-themes-mode-line '(moody accented borderless))
  
  ;; Load the theme files before enabling a theme (else you get an error)
  (modus-themes-load-themes)
  :config
  ;; Load the theme of your choice:
  (modus-themes-load-vivendi) ;; OR (modus-themes-load-operandi)
  :bind ("<f5>" . modus-themes-toggle))


;; magit
(use-package magit)


;; diminish
(use-package diminish
  :config
  (diminish 'auto-revert-mode)
  (diminish 'which-key-mode)
  (diminish 'evil-mode)
  (diminish 'evil-collection-unimpaired-mode))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(diminish vertico modus-themes which-key use-package magit evil evil-collection)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
