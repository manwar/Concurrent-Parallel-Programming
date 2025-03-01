#!/usr/bin/env python3

import os
import time
import threading

def worker():
    name = threading.current_thread().name
    print("Thread " + name + " started.")
    time.sleep(2)
    print("Thread " + name + " finished.")

print('Process ID: ', os.getpid())
print('Starting 5 threads.')
for i in range(5):
    threading.Thread(target=worker).start()
