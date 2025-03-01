#!/usr/bin/env python3

import threading
import time

def worker(id):
    print(f"Thread {id} started.")
    time.sleep(5)
    print(f"Thread {id} finished.")

print("Main process started.")
thread = threading.Thread(target=worker, args=(1,))
thread.start()
print("Main process finished.")
