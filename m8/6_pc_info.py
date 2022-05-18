"""Show basic PC information (OS, RAM amount, HDD’s, and etc.)."""

import psutil
import platform
from utils import get_size

print()

# System information
print("="*40, "OS Information", "="*40)
uname = platform.uname()
print(f"System: {uname.system}")
print(f"Node Name: {uname.node}")
print(f"Release: {uname.release}")
print(f"Version: {uname.version}")
print(f"Machine: {uname.machine}")
print(f"Processor: {uname.processor}")

# CPU information
print("="*40, "CPU Info", "="*40)
# number of cores
cores = psutil.cpu_count(logical=False)
print("Physical cores:", cores)
print("Total cores:", psutil.cpu_count(logical=True))
# CPU frequencies
paths = [
    f"/sys/devices/system/cpu/cpu{n}/cpufreq/cpuinfo_max_freq" for n in range(cores)
]
cpu_freq_list = []
for path in paths:
    f = open(path, "r")
    cpu_freq = f.read().strip()
    cpu_freq_list.append(int(cpu_freq))
    f.close()
max_cpufreq = max(cpu_freq_list)/1000000
print(f"Max Frequency: {max_cpufreq:.2f}GHz")

# CPU usage
print("CPU Usage Per Core:")
for i, percentage in enumerate(psutil.cpu_percent(percpu=True, interval=1)):
    print(f"Core {i}: {percentage}%")
print(f"Total CPU Usage: {psutil.cpu_percent()}%")

# Memory Information
print("="*40, "RAM Information", "="*40)
# get the memory details
svmem = psutil.virtual_memory()
print(f"Total: {get_size(svmem.total)}")
print(f"Available: {get_size(svmem.available)}")
print(f"Used: {get_size(svmem.used)}")
print(f"Percentage: {svmem.percent}%")

# Disk Information
print("="*40, "Disk Information", "="*40)
print("Partitions and Usage:")
# get all disk partitions
partitions = psutil.disk_partitions(all=True)
for partition in partitions[0:2]:
    print(f"=== Device: {partition.device} ===")
    print(f"  Mountpoint: {partition.mountpoint}")
    print(f"  File system type: {partition.fstype}")
    try:
        partition_usage = psutil.disk_usage(partition.mountpoint)
    except PermissionError:
        # this can be catched due to the disk that
        # isn't ready
        continue
    print(f"  Total Size: {get_size(partition_usage.total)}")
    print(f"  Used: {get_size(partition_usage.used)}")
    print(f"  Free: {get_size(partition_usage.free)}")
    print(f"  Percentage: {partition_usage.percent}%")

# Network information
print("="*40, "Network Information", "="*40)
# get all network interfaces (virtual and physical)
if_addrs = psutil.net_if_addrs()
for interface_name, interface_addresses in if_addrs.items():
    print(f"=== Interface: {interface_name} ===")
    for address in interface_addresses:
        if str(address.family) == 'AddressFamily.AF_INET':
            print(f"  IP Address: {address.address}")
            print(f"  Netmask: {address.netmask}")
            print(f"  Broadcast IP: {address.broadcast}")
        elif str(address.family) == 'AddressFamily.AF_PACKET':
            print(f"  MAC Address: {address.address}")
        elif str(address.family) == 'AddressFamily.AF_INET6':
            print(f"  IPv6 Address: {address.address.split('%')[0]}")
print()
