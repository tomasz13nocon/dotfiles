# import re
# import subprocess
# from multiprocessing.connection import Listener
# from threading import Timer
# import psutil
# import os
import sys
import signal
import time

i = 0


def sig(signum, frame):
    global i
    i += 1


signal.signal(signal.SIGUSR1, sig)

while True:
    i += 1
    print(i)
    time.sleep(1)


# address = ("127.0.0.1", 4649)
#
# result = subprocess.run(
#     "ddcutil getvcp 10", shell=True, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL
# )
# print("Test2")
# reg = re.search(r".*current value =\s+([0-9]+).*", str(result.stdout))
# print("Test3")
#
# if reg is None:
#     print("can't get brightness from ddc")
#     exit(1)
#
# print("Test4")
# current = int(reg.group(1))
# print(current)  # idk why stdout doesn't show...
# print("Test5")
#

# def apply_brightness(value):
#     subprocess.run("ddcutil setvcp 10 %s" % value, shell=True, stderr=subprocess.DEVNULL)
#     print(value)
#
# t = Timer(0, lambda: 0)
#
# listener = Listener(address);
#
# try:
#     while True:
#         conn = listener.accept()
#         msg = conn.recv()
#         current += msg
#         current = max(0, min(current, 100))
#
#         # debounce
#         t.cancel()
#         t = Timer(0.2, apply_brightness, [current])
#         t.start()
#
#         print(current)
# finally:
#     listener.close()
#
