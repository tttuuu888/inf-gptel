;;; inf-gptel.el --- Run an interactive Gptel shell -*- lexical-binding: t -*-

;; Copyright (C) 2025 Seungki Kim

;; Author: Seungki Kim <tttuuu888@gmail.com>
;; URL: https://github.com/tttuuu888/inf-gptel
;; Version: 0.3.0
;; Keywords: convenience tools
;; Package-Requires: ((emacs "29.1") (gptel "0.9.7"))

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

;; This package provides a `comint-mode' based interface to interact with Gptel.

;;; Code:

(require 'gptel)
(require 'comint)

(defvar inf-gptel-buffer-name "*inf-gptel*")
(defvar inf-gptel-prompt "> ")

(defun inf-gptel--send (proc input)
  "Send INPUT to Gptel and insert the response."
  (if (string-empty-p input)
      (comint-output-filter proc inf-gptel-prompt)
    (gptel-request input
      :callback
      (lambda (response _info)
        (when (stringp response)
          (comint-output-filter
           proc
           (concat response "\n\n" inf-gptel-prompt)))))))

(define-derived-mode inf-gptel-mode comint-mode "Inf-Gptel"
  "Major mode for interacting with LLM based on `comint-mode'."
  (let ((proc (start-process "inf-gptel" (current-buffer) "cat")))
    (set-process-query-on-exit-flag proc nil)
    (setq comint-input-sender #'inf-gptel--send
          comint-prompt-read-only t)
    (setq-local comint-input-ring (make-ring comint-input-ring-size))
    (setq-local comint-prompt-regexp
                (concat "^" (regexp-quote inf-gptel-prompt)))
    (comint-output-filter
     proc (concat "Gptel Comint Mode\n" inf-gptel-prompt))))

;;;###autoload
(defun inf-gptel ()
  "Run an inferior Gptel process."
  (interactive)
  (let ((buffer (get-buffer-create inf-gptel-buffer-name)))
    (with-current-buffer buffer
      (unless (comint-check-proc buffer)
        (inf-gptel-mode)))
    (pop-to-buffer buffer)))

;;;###autoload
(defalias 'run-gptel 'inf-gptel)

(provide 'inf-gptel)
;;; inf-gptel.el ends here
