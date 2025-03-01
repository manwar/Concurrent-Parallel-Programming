#!/usr/bin/env python3

import time
import queue
import threading

def worker(id, result):
    print(f"Thread {id} started.")
    time.sleep(5)
    print(f"Thread {id} finished.")
    result.put(id * 2)

print("Main process started.")
result = queue.Queue()
thread = threading.Thread(target=worker, args=(1, result))
thread.start()
thread.join()
while not result.empty():
    print("Result from thread: ", result.get())
print("Main process finished.")
