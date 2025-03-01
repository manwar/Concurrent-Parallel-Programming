#!/usr/bin/env python3

import time
import math
import threading

def cpu_worker(id):
    result = 0
    for i in range(10_000_000):
        result += math.sqrt(i)
    print(f"Thread {id} completed.")

start_time = time.time()
threads = []
for i in range(9):
    thread = threading.Thread(target=cpu_worker, args=(i + 1,))
    threads.append(thread)
    thread.start()
for thread in threads:
    thread.join()
end_time = time.time()
print(f"Total time taken: {end_time - start_time:.2f} seconds")
