# emacs-cqlsh
used cqlsh <a href="https://docs.datastax.com/en/install/6.8/install/installCqlsh.html">CQLSH</a>
add to your init.el file:
(add-to-list 'load-path "~/.emacs.d/emacs-cqlsh")
(require 'emacs-cqlsh)
(setq url "localhost")
(setq port "9042")
(setq cassandra-name "cassandra")
(setq cassandra-pass "cassandra")
