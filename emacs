(require 'package)
;(push '("marmalade" . "http://marmalade-repo.org/packages/")
	;package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
	package-archives)
(package-initialize)

(package-install 'evil)
(package-install 'evil-leader)
(package-install 'powerline-evil)
(package-install 'flycheck)
(package-install 'flycheck-pos-tip)
(package-install 'base16-theme)
(package-install 'linum-relative)

(package-initialize)

;; evil-Mode, vim bindings
(require 'evil-leader)
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

(require 'evil)
(evil-mode 1)

(require 'powerline)
(powerline-evil-vim-color-theme)
(display-time-mode t)

;;Colors
(require 'base16-monokai-dark-theme)
(load-theme 'base16-monokai-dark t)

(defun on-frame-open (frame)
  (when (not (display-graphic-p frame))
    (set-face-background 'default "unspecified-bg" frame)
    (set-face-background 'mode-line "unspecified-bg" frame)))
(on-frame-open (selected-frame))
(add-hook 'after-make-frame-functions 'on-frame-open)


;;Pretty font
(set-face-attribute 'default nil :family "Anonymous Pro" :height 130)

;; Syntax checking
(require 'flycheck)
(flycheck-mode t)
(evil-leader/set-key "c" 'flycheck-buffer)

;; Common Options
;; Relative line numbering
(require 'linum-relative)
(linum-mode)
(linum-relative-global-mode)

;; Key Bindings
;; Window switching
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Relative linum toggle
(define-key evil-normal-state-map (kbd "C-n") 'linum-relative-toggle)
