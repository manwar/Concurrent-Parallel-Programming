#!/usr/bin/env python3

import time
import requests
import threading

def io_worker(id):
    url = "https://www.google.com"
    response = requests.get(url)
    print(f"Thread {id} finished.")

start_time = time.time()
threads = []
for i in range(9):
    thread = threading.Thread(target=io_worker, args=(i + 1,))
    threads.append(thread)
    thread.start()
for thread in threads:
    thread.join()
end_time = time.time()
print(f"Total time taken: {end_time - start_time:.2f} seconds")
