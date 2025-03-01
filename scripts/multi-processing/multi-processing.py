#!/usr/bin/env python3

import os
import time
import multiprocessing as mp

def worker():
    pid = os.getpid()
    print("Process " + str(pid) + " started.")
    time.sleep(2)
    print("Process " + str(pid) + " finished.")

if __name__ == '__main__':
    print('Process ID: ', os.getpid())
    print('\nStarting 5 processes.')
    for i in range(5):
        mp.Process(target=worker).start()
