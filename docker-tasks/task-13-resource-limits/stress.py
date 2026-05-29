#!/usr/bin/env python3
# ==============================================
# Task 13: Resource Limits - Stress Test Script
# Demonstrates memory limits on Docker containers
# ==============================================
import time
import sys
import os

def stress_memory(mb):
    """Allocate memory in chunks to demonstrate limits."""
    print(f"Attempting to allocate {mb}MB of memory...")
    print(f"Memory limit: {os.popen('cat /sys/fs/cgroup/memory/memory.limit_in_bytes 2>/dev/null || echo unknown').read().strip()}")
    
    chunks = []
    try:
        for i in range(mb):
            # Allocate 1MB at a time
            chunk = bytearray(1024 * 1024)
            chunks.append(chunk)
            if (i + 1) % 50 == 0:
                print(f"Allocated {i + 1}MB so far...")
                time.sleep(0.5)
        print(f"Successfully allocated {mb}MB!")
        print("Press Ctrl+C to release memory, or wait for idle loop...")
        while True:
            time.sleep(10)
    except MemoryError:
        print(f"\nOUT OF MEMORY at ~{len(chunks)}MB!")
        print("Docker's memory limit was enforced.")
    except KeyboardInterrupt:
        print("\nCleaning up...")
    finally:
        chunks = []
        print("Memory released.")

def stress_cpu(seconds=30):
    """Burn CPU to demonstrate CPU limits."""
    print(f"Burning CPU for {seconds} seconds...")
    print(f"CPU limit: {os.popen('cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us 2>/dev/null || echo unknown').read().strip()}")
    
    end_time = time.time() + seconds
    count = 0
    while time.time() < end_time:
        count += 1
        _ = count ** 2
    
    print(f"Completed {count} iterations in {seconds}s")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Resource stress test for Docker")
    parser.add_argument("--memory", type=int, default=100, help="MB to allocate")
    parser.add_argument("--cpu", type=int, default=0, help="CPU burn duration in seconds")
    args = parser.parse_args()
    
    print("=" * 50)
    print("Docker Resource Limits Stress Test")
    print("=" * 50)
    
    if args.cpu > 0:
        stress_cpu(args.cpu)
    else:
        stress_memory(args.memory)
    
    print("Stress test complete.")
