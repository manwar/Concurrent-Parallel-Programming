#!/usr/bin/env python3

import time
import threading
from random import random

lock_a  = threading.Lock()
lock_b  = threading.Lock()
lock_c  = threading.Lock()
counter = 9

def worker(name, first, second):
    global counter
    while counter > 0:
        first.acquire()
        if not second.acquire(blocking=False):
            first.release()
            time.sleep(random()/10)
        else:
            try:
                if counter > 0:
                    counter -= 1
                    print(f"{name} took the turn, counter is {counter} now.")
            finally:
                second.release()
                first.release()

if __name__ == '__main__':
    threads = []
    threads.append(threading.Thread(target=worker, args=('Thread 1', lock_a, lock_b)))
    threads.append(threading.Thread(target=worker, args=('Thread 2', lock_b, lock_c)))
    threads.append(threading.Thread(target=worker, args=('Thread 3', lock_c, lock_a)))
    for thread in threads:
        thread.start()
    for thread in threads:
        thread.join()
