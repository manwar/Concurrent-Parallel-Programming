#!/usr/bin/env python3

import time
import threading

rlock = threading.RLock()

def worker(id):
    with rlock:
        print(f"Thread: {id} acquired the lock.")
        with rlock:
            print(f"Thread: {id} re-acquired the same lock.")
            time.sleep(1)
        print(f"Thread: {id} released the nested lock.")
    print(f"Thread: {id} released the lock.")

if __name__ == '__main__':
    threading.Thread(target=worker, args=(1,)).start()
