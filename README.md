# emacs-cqlsh
used cqlsh <a href="https://docs.datastax.com/en/install/6.8/install/installCqlsh.html">CQLSH</a>
add to your init.el file:<br>
(add-to-list 'load-path "~/.emacs.d/emacs-cqlsh")<br>
(require 'emacs-cqlsh)<br>
(setq url "localhost")<br>
(setq port "9042")<br>
(setq cassandra-name "cassandra")<br>
(setq cassandra-pass "cassandra")<br>
