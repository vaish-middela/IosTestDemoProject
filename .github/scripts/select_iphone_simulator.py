# # .github/scripts/select_iphone_simulator.py
# import json
# import subprocess
# import sys

# result = subprocess.run(
#     ["xcrun", "simctl", "list", "devices", "available", "-j"],
#     check=True,
#     capture_output=True,
#     text=True,
# )

# data = json.loads(result.stdout)

# for runtime in sorted(data["devices"], reverse=True):
#     for device in data["devices"][runtime]:
#         if device.get("isAvailable") and "iPhone" in device.get("name", ""):
#             print(device["udid"])
#             sys.exit(0)

# sys.exit("No available iPhone simulator found")
import json
import subprocess
import sys

result = subprocess.run(
    ["xcrun", "simctl", "list", "devices", "available", "-j"],
    check=True,
    capture_output=True,
    text=True,
)

data = json.loads(result.stdout)
candidates = []

for runtime, devices in data.get("devices", {}).items():
    for device in devices:
        if (
            device.get("isAvailable", True)
            and device.get("name", "").startswith("iPhone")
            and device.get("udid")
        ):
            candidates.append((runtime, device))

if not candidates:
    print("No available iPhone simulator with a UDID was found.", file=sys.stderr)
    sys.exit(1)

runtime, device = sorted(candidates, key=lambda item: item[0], reverse=True)[0]
print(f"Selected {device['name']} ({runtime})", file=sys.stderr)
print(device["udid"])