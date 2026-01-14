import re
import subprocess
from multiprocessing.connection import Listener
from multiprocessing.connection import Client
import sys
from threading import Timer
import signal
import time


# terminate already running instance of this script to avoid port collision
# my_pid = os.getpid()
# for p in psutil.process_iter():
#     if len(p.cmdline()) > 1 and "ddc.py" in p.cmdline()[1]:
#         if not p.pid == my_pid:
#             p.terminate()


def exit_gracefully(signum, frame):
    sys.exit(0)


signal.signal(signal.SIGTERM, exit_gracefully)


def apply_brightness(monitor, value):
    subprocess.run('ddcutil setvcp 10 %d -l "%s"' % (value, monitor), shell=True)


def daemon():
    current = {}
    listeners = {}

    result = subprocess.run("sudo ddcutil detect | grep Model: | sed 's/.*Model:[[:space:]]*//'", shell=True, stdout=subprocess.PIPE)
    for model in result.stdout.splitlines():
        model_str = model.decode()
        if model_str.strip():
            current[model_str] = get_brightness(model_str)

    t = Timer(0, lambda: 0)

    listener = Listener(address)

    try:
        while True:
            conn = listener.accept()
            msg = conn.recv()
            monitor = msg["monitor"]
            if msg["action"] == "get":
                print("sending " + str(current[monitor]) + " on " + monitor)

                conn.send(current[monitor])
                # conn.close ??
            elif msg["action"] == "set":
                current[monitor] += msg["value"]
                current[monitor] = max(0, min(current[monitor], 100))

                # debounce
                t.cancel()
                t = Timer(0.5, apply_brightness, [monitor, current[monitor]])
                t.start()

                print(listeners)
                if monitor in listeners:
                    print(
                        "sending "
                        + str(current[monitor])
                        + " to listener for "
                        + monitor
                    )
                    listeners[monitor].send(current[monitor])
            elif msg["action"] == "listen":
                listeners[monitor] = Client(msg["address"])
                print("added listener for %s and sending brightness" % monitor)
                listeners[monitor].send(current[monitor])
            elif msg["action"] == "unlisten" and listeners[monitor]:
                del listeners[monitor]

    finally:
        listener.close()


def get_brightness(monitor):
    result = subprocess.run(
        'ddcutil getvcp 10 -l "' + monitor + '"', shell=True, stdout=subprocess.PIPE
    )
    reg = re.search(r".*current value =\s+([0-9]+).*", str(result.stdout))

    if reg is None:
        print("can't get brightness from ddc")
        # TODO retry
        exit(1)

    return int(reg.group(1))


def send_to_daemon(msg):
    conn = Client(address)
    conn.send(msg)
    conn.close()


address = ("127.0.0.1", 4616)

if sys.argv[1] == "daemon":
    daemon()
else:
    if len(sys.argv) <= 2:
        print("No monitor specified, exiting")
        exit(1)

    monitor = sys.argv[2]

    match sys.argv[1]:
        case "daemon":
            daemon()
        case "get":
            conn = Client(address)
            conn.send({"action": "get", "monitor": monitor})
            msg = conn.recv()
            print(msg)
            conn.close()
        case "set":
            send_to_daemon({"action": "set", "monitor": monitor, "value": int(sys.argv[3])})
        case "listen":
            monitor_address = (address[0], address[1] + (hash(monitor) % 380))
            print("..")
            time.sleep(2)
            listener = Listener(monitor_address)
            print("sending 'listen' to daemon", monitor_address)
            try:
                send_to_daemon(
                    {"action": "listen", "monitor": monitor, "address": monitor_address}
                )
            except ConnectionRefusedError:
                print("xx")
                time.sleep(1)
                exit()
            conn = listener.accept()
            try:
                while True:
                    msg = conn.recv()
                    print(msg)
            finally:
                send_to_daemon({"action": "unlisten", "monitor": monitor})
                conn.close()
                listener.close()
