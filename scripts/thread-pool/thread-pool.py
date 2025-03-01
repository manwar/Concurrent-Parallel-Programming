#!/usr/bin/env python3

import threading
from concurrent.futures import ThreadPoolExecutor

def worker(task_id):
    name = threading.current_thread().name
    print(f"{name} doing task: {task_id}")

if __name__ == '__main__':
    pool = ThreadPoolExecutor(max_workers=5)
    [pool.submit(worker, task_id) for task_id in range(1, 10)]
    pool.shutdown()
