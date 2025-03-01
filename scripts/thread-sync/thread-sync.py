#!/usr/bin/env python3

import threading

lock = threading.Lock()
resource = 0

def worker(id):
    global resource

    with lock:
        resource += 1
        print(f"In thread {id}, shared {resource=}")

threads = []
for i in range(1, 6):
    t = threading.Thread(target=worker, args=(i,))
    threads.append(t)
    t.start()

for t in threads:
    t.join()

print(f"Final value of shared {resource=}")
