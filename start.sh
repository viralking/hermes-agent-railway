#!/bin/sh
exec python3 - << 'EOF'
import os, pty, time

master, slave = pty.openpty()
pid = os.fork()
if pid == 0:
    os.dup2(slave, 0)
    os.dup2(slave, 1)
    os.close(master)
    os.close(slave)
    os.execvp('hermes', ['hermes'])
else:
    os.close(slave)
    while True:
        time.sleep(3600)
EOF
