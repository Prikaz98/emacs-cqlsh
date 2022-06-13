(setq url "127.0.0.1")
(setq port "9042")
(setq cassandra-name "cassandra")
(setq cassandra-pass "cassandra")
(require 'evil)

;;;###autoload
(defun cqlsh-query (command &optional output-buffer error-buffer)
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
    (setq command (concat "bash ~/cqlsh -u " cassandra-name " -p " cassandra-pass " " url " " port " -e \"" command "\" &")))
  (message command)
  (shell-command command output-buffer error-buffer)
  (other-window 1)
  (toggle-truncate-lines)
  (evil-force-normal-state))


;;;###autoload
(defun cqlsh-query-keyspaces (output-buffer error-buffer)
  (interactive
   (list
    current-prefix-arg
    shell-command-default-error-buffer))
  (shell-command (concat "bash ~/cqlsh -u " cassandra-name " -p " cassandra-pass " " url  " " port " -e \"SELECT * FROM system_schema.keyspaces;\" &" output-buffer error-buffer))
  (other-window 1)
  (toggle-truncate-lines)
  (evil-force-normal-state))

;;SELECT * FROM system_schema.keyspaces;

;;;###autoload
(defun cqlsh-query-region (output-buffer error-buffer)
  (interactive
   (list
    current-prefix-arg
    shell-command-default-error-buffer))
  (let (cmd)
    (setq cmd (buffer-substring-no-properties (region-beginning) (region-end)))
    (message cmd)
    (shell-command (concat "bash ~/cqlsh -u " cassandra-name " -p " cassandra-pass " " url " " port " -e \"" cmd "\" &" output-buffer error-buffer)))
  (other-window 1)
  (toggle-truncate-lines)
  (evil-force-normal-state))

(provide 'emacs-cqlsh)
