(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t))

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar my/packages '(
	       ;; --- Auto-completion ---
	       company
	       ;; --- Better Editor ---
	       hungry-delete
	       swiper
	       counsel
	       smartparens
	       ;; --- Major Mode ---
	       js2-mode
	       ;; --- Minor Mode ---
	       nodejs-repl
	       exec-path-from-shell
	       ;; --- Themes ---
	       monokai-theme
	       ;; solarized-theme
	       ) "Default packages")

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
    (loop for pkg in my/packages
	  when (not (package-installed-p pkg)) do (return nil)
	  finally (return t)))

(unless (my/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg my/packages)
      (when (not (package-installed-p pkg))
	(package-install pkg))))

;; Find Executable Path on OS X
;;(when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize))



(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)

;;(setq cursor-type 'bar)

(setq inhibit-splash-screen 1)
(set-face-attribute 'default nil :height 130)

(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)

;;(global-company-mode 1)
(setq make-backup-files nil)

(global-hl-line-mode 1)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)


;;(add-to-list my/packages 'monokai-theme)
;; (load-theme 'monokai 1)




;; Enable company globally for all mode
(global-company-mode)

;; Reduce the time after which the company auto completion popup opens
(setq company-idle-delay 0.2)

;; Reduce the number of characters before company kicks in
(setq company-minimum-prefix-length 1)
;; Set path to racer binary
(setq racer-cmd "/Users/bookeezhou/.cargo/bin/racer")

;; Set path to rust src directory
(setq racer-rust-src-path "/Users/bookeezhou/work/program/rust/src")

;; Load rust-mode when you open `.rs` files
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; Setting up configurations when you load rust-mode
;;(add-hook 'rust-mode-hook

;;     '(lambda ()
     ;; Enable racer
;;     (racer-activate)

     ;; Hook in racer with eldoc to provide documentation
;;     (racer-turn-on-eldoc)

     ;; Use flycheck-rust in rust-mode
;;     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
     
     ;; Use company-racer in rust mode
     ;;(set (make-local-variable 'company-backends) '(company-racer))

     ;; Key binding to jump to method definition
     ;;(local-set-key (kbd "M-.") #'racer-find-definition)

     ;; Key binding to auto complete and indent
(global-set-key (kbd "TAB") #'racer-complete-or-indent)

(setq company-tooltip-align-annotations t)
