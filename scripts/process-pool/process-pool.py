#!/usr/bin/env python3

import os
from concurrent.futures import ProcessPoolExecutor

def worker(task_id):
    name = os.getpid()
    print(f"Process {os.getpid()} doing task: {task_id}")

if __name__ == '__main__':
    with ProcessPoolExecutor(max_workers=5) as pool:
        for task_id in range(10):
            pool.submit(worker, task_id)
