import os

print("Using os, count: ", os.cpu_count())

import multiprocessing

print("Using multiprocessing, count: ", multiprocessing.cpu_count())

def cpu_count():
    try:
        with open('/proc/cpuinfo', 'r') as fh:
            cpuinfo = fh.readlines()
        cores = sum(1 for line in cpuinfo if line.startswith('processor'))
        return cores
    except FileNotFoundError:
        return None

print("Reading /proc/cpuinfo, count: ", cpu_count())
