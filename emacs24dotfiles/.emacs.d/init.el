;; init.el This is the first thing to get loaded.
;;
;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

(require 'package)

;;following line for elpa package needs to be uncommented to get rinari package working
;;(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar custom-packages '(
                      starter-kit
                      starter-kit-ruby
                      flymake-ruby
                      ruby-block
                      js2-mode
                      js-comint
                      rinari
                      yaml-mode
                      ruby-test-mode
                      starter-kit-lisp
                      starter-kit-bindings
                      fuzzy
                      auto-complete
                      haml-mode
                      apache-mode
                      crontab-mode
                      puppet-mode
                      memory-usage
                      clojure-mode
                      clojure-test-mode
                      clojurescript-mode
                      ac-slime)
  "A list of packages to ensure are installed at launch.")

(dolist (p custom-packages)
  (when (not (package-installed-p p))
    (package-install p)))



(setq js-rhino-path (concat "java -jar " (expand-file-name "~/.emacs.d/libs/rhinojs.jar")))

(setq inferior-js-program-command  js-rhino-path)
(add-hook 'js2-mode-hook '(lambda () 
			    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
			    (local-set-key "\C-cb" 'js-send-buffer)
			    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
			    (local-set-key "\C-cl" 'js-load-file-and-go)
			    ))

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(ac-config-default)

;;autocomplete for clojure
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

;;rsense not working with emacs24 test beta
(setq rsense-home  (expand-file-name "~/.emacs.d/libs/rsense-0.3"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

;; Complete by C-c .
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c .") 'ac-complete-rsense)))



(setq vendor-dir (concat (expand-file-name "~/.emacs.d") "/vendor"))
(add-to-list 'load-path vendor-dir)

(require 'grep-a-lot)
(grep-a-lot-setup-keys)

;;Path to gs(ghost script) to get view pdf work in emacs
(setq exec-path (append exec-path '("/opt/local/bin")))

(set-frame-position (selected-frame) 0 0)
;;(set-frame-size (selected-frame) 50000 50000)
