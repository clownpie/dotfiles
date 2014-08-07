(add-to-list 'load-path "~/.emacs.d") ; set default emacs loadpath
(add-to-list 'load-path "~/.emacs.d/pymacs") ; set default emacs loadpath


(tool-bar-mode -1)      ; remove tool bar
(scroll-bar-mode -1)    ; remove scroll bar
(menu-bar-mode -1)      ; remove menu bar

;;;; Show column numbers when editing file.
(setq column-number-mode t)

;;;; Font size.
(set-face-attribute 'default nil :height 115)

;(global-set-key (kbd "C-x C-*") (set-frame-width (selected-frame) 100))

;;; ido
(ido-mode t)
(setq-default
 ido-enable-flex-matching t
 ido-create-new-buffer 'always
 ido-everywhere t)

;; use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

;; Hilight the current line
(global-hl-line-mode t)

;;; whitespace-mode
(global-whitespace-mode t)                              ; show whitespace
(add-hook 'before-save-hook 'whitespace-cleanup)        ; cleanup whitespace on exit
(setq-default
 whitespace-line-column 100                             ; column width
 whitespace-style                                       ; whitespace to highlight
 '(trailing lines-tail empty indentation
	    space-before-tab space-after-tab))


;;; packages
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; install packages
(let ((ensure-installed
       (lambda (name)
	 (unless (package-installed-p name) (package-install name))))
      (packages '(auto-complete solarized-theme python-mode)))
  (mapc ensure-installed packages))


;;; python-mode setup
;;; Required python packages(use pip): rope, ropemode, ropemacs
;;; Pymacs is also required, but it's best to install from source.
(require 'python-mode)
; configure python mode
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
; set ipython as the default shell.
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")

; taken from http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
; don't split windows
(setq py-split-windows-on-execute-p nil)
; try to automagically figure out indentation
(setq py-smart-indentation t)

; pymacs config
(require 'pymacs)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

; ropemacs
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;;; color-theme
(setq-default
 custom-safe-themes
 '("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4"
   "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default))
(load-theme 'solarized-dark)

;;; Set the mode line color to something noticable.
;; see http://www.gnu.org/software/emacs/manual/html_node/emacs/Standard-Faces.html
(set-face-background 'mode-line "Gray42")
(set-face-foreground 'mode-line "Cyan")
(set-face-background 'mode-line-inactive "Gray42")
(set-face-foreground 'mode-line-inactive "Wheat1")


(require 'auto-complete-config)
;;;; Autocomplete.
(global-auto-complete-mode t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(global-set-key (kbd "M-/") 'auto-complete)
