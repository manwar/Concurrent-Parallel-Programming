#!/usr/bin/env python3

import os
import time

def worker():
    print(f"\tChild process (PID: {os.getpid()}) started.")
    time.sleep(2)
    print(f"\tChild process (PID: {os.getpid()}) finished.")
    os._exit(0)

def parent():
    print(f"Parent process (PID: {os.getpid()}) started.")
    pid = os.fork()
    if pid == 0:
        worker()
    else:
        print(f"\tChild process (PID: {pid}) created.")
        os.waitpid(pid, 0)
        print(f"Parent process (PID: {os.getpid()}) finished.")

if __name__ == "__main__":
    parent()
