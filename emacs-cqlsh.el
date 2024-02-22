;;; emacs-cqlsh.el emacs cqlsh extension -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 ivan
;;
;; Author: ivan <ivan@ivan>
;; Maintainer: ivan <ivan@ivan>
;; Created: february 22, 2024
;; Modified: february 22, 2024
;; Version: 0.0.1
;; Keywords: extensions help terminals tools
;; Homepage: https://github.com/Prikaz98/emacs-cqlsh
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;  Description:
;;; It is an extension for emacs to do cql query using cqlsh from emacs buffer
;;
;;; Code:


(setq url "localhost")
(setq port "9042")
(setq cassandra-name "cassandra")
(setq cassandra-pass "cassandra")

(require 'evil)

;;;###autoload
(defun emacs-cqlsh-query (command &optional output-buffer error-buffer)
  (interactive
   (list
    (read-shell-command "Cqlsh query cmd: " nil nil
			(let ((filename
			       (cond
				(buffer-file-name)
				((eq major-mode 'dired-mode)
				 (dired-get-filename nil t)))))
			  (and filename (file-relative-name filename))))
    current-prefix-arg
    shell-command-default-error-buffer))
  (unless (string-match "&[ \t]*\\'" command)
    (setq command (concat "cqlsh -u " cassandra-name " -p " cassandra-pass " " url " " port " -e \"" command "\" &")))
  (message command)
  (shell-command command output-buffer error-buffer)
  (other-window 1)
  (toggle-truncate-lines)
  (evil-force-normal-state))


;;;###autoload
(defun emacs-cqlsh-query-keyspaces (output-buffer error-buffer)
  (interactive
   (list
    current-prefix-arg
    shell-command-default-error-buffer))
  (shell-command (concat "cqlsh -u " cassandra-name " -p " cassandra-pass " " url  " " port " -e \"SELECT * FROM system_schema.keyspaces;\" &" output-buffer error-buffer))
  (other-window 1)
  (toggle-truncate-lines)
  (evil-force-normal-state))

;;SELECT * FROM system_schema.keyspaces;

;;;###autoload
(defun emacs-cqlsh-query-region (output-buffer error-buffer)
  (interactive
   (list
    current-prefix-arg
    shell-command-default-error-buffer))
  (let (cmd)
    (setq cmd (buffer-substring-no-properties (region-beginning) (region-end)))
    (message cmd)
    (shell-command (concat "cqlsh -u " cassandra-name " -p " cassandra-pass " " url " " port " -e \"" cmd "\" &" output-buffer error-buffer)))
  (other-window 1)
  (toggle-truncate-lines)
  (evil-force-normal-state))

(provide 'emacs-cqlsh)
;;; emacs-cqlsh.el ends here
