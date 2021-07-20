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
					:font "mononoki Nerd Font" 
					:height 140)



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


;; ivy
(use-package ivy
			 :diminish
			 :config (ivy-mode 1))


;; evil-collection-issue #60 (Refer github)
(setq evil-want-keybinding nil)
;; evil
(use-package evil
			 :config (evil-mode 1))
;; evil-collection
(use-package evil-collection
			 :after evil
			 :init (evil-collection-init))


;; magit
(use-package magit)
