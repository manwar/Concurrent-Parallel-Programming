#!/usr/bin/env python3

import math
import multiprocessing

def worker(id):
    result = 0
    for i in range(1_000_000):
        result += math.sqrt(i)
    print(f"Task {id} result: {result}")

if __name__ == "__main__":
    process1 = multiprocessing.Process(target=worker, args=(1,))
    process2 = multiprocessing.Process(target=worker, args=(2,))

    process1.start()
    process2.start()

    process1.join()
    process2.join()

    print("All tasks done!")
