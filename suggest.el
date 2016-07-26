;;; suggest.el --- suggest elisp functions that give the output requested  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  

;; Author:  <wilfred@boogie>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Suggest.el will find functions that give the output requested. It's
;; a great way of exploring list, string and arithmetic functions.

;;; Code:

;; TODO: support arbitrary orderings of arguments?
(defvar suggest-functions
  '(identity
    car
    cdr
    cadr
    +
    -
    *
    /)
  "Functions that suggest will consider.
These functions must not produce side effects.")

(defface suggest-heading
  '((((class color) (background light)) :foreground "DarkGoldenrod4" :weight bold)
    (((class color) (background dark)) :foreground "LightGoldenrod2" :weight bold))
  "Face for headings."
  :group 'suggest)

(defvar suggest--inputs-heading "Inputs (one per line):")
(defvar suggest--outputs-heading "Desired output:")
(defvar suggest--results-heading "Suggestions:")

;; TODO: make headings read-only (see
;; http://stackoverflow.com/a/7415021/509706).
(defun suggest--heading (text)
  "Format TEXT as a heading."
  (propertize text 'face 'suggest-heading))

(defun suggest ()
  "Open a Suggest buffer that provides suggestions for the inputs
and outputs given."
  (interactive)
  (let ((buf (get-buffer-create "*suggest*")))
    (switch-to-buffer buf)
    (erase-buffer)
    (suggest-mode)
    (insert (suggest--heading suggest--inputs-heading)
            "\nnil\n\n"
            (suggest--heading suggest--outputs-heading)
            "\nnil\n\n"
            (suggest--heading suggest--results-heading)
            "\n(identity nil) ;=> nil")))

(define-derived-mode suggest-mode fundamental-mode "Suggest"
  "A major mode for finding functions that provide the output requested.")

(provide 'suggest)
;;; suggest.el ends here
