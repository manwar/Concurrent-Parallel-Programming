#!/usr/bin/env python3

import threading
from readerwriterlock import rwlock

reader = rwlock.RWLockFair().gen_rlock()
writer = rwlock.RWLockFair().gen_wlock()

rcount = 0
wcount = 0

def read_worker(id):
    global rcount
    global wcount

    with reader:
        rcount += 1
        if rcount == 1:
            writer.acquire()

    print(f"Reader {id} reads data: {wcount}")

    with reader:
        rcount -= 1
        if rcount == 0:
            writer.release()

def write_worker(id):
    global wcount

    with writer:
        wcount += 1
        print(f"Writer {id} writes data: {wcount}")

if __name__ == '__main__':
    for i in range(1, 3):
        threading.Thread(target=write_worker, args=(i,)).start()
    for i in range(1, 4):
        threading.Thread(target=read_worker, args=(i,)).start()
