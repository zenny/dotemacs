;;; sk-ivy-modalka.el --- Global settings -*- lexical-binding: t; -*-

;;; Commentary:

;; Modal bindings for ivy commands

;;; Code:

;; Resume
(modalka-define-kbd "B" "C-S-s")

;; imenu
(modalka-define-kbd "t" "C-r")

;; Locate
(modalka-define-kbd "SPC R" "C-x l")

;; change to wgrep mode
(modalka-define-kbd "g e" "C-M-S-r")

;; Help
(modalka-define-kbd "SPC x" "C-h f")
(modalka-define-kbd "SPC v" "C-h v")

;; Pt
(modalka-define-kbd "g s" "M-s")

;; descbinds
(modalka-define-kbd "SPC ," "C-c ,")

;; theme
(modalka-define-kbd "SPC c" "C-c c")

;; Spotlight
(modalka-define-kbd "SPC r" "C-c d")

;; Projecile
(modalka-define-kbd "SPC p" "C-c P")

;; search
(modalka-define-kbd "SPC SPC" "C-s")
(modalka-define-kbd "/" "C-s")

;; bibtex
(modalka-define-kbd "SPC b" "C-c b")

;; modal bindings
(require 'sk-ivy-modalka-which-key)

(provide 'sk-ivy-modalka)
;;; sk-ivy-modalka.el ends here