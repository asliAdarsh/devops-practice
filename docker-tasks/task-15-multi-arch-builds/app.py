#!/usr/bin/env python3
# ==============================================
# Task 15: Multi-Architecture Builds Demo
# Prints the CPU architecture it's running on
# ==============================================
import platform
import struct
import sys

def get_architecture():
    """Get detailed CPU architecture info."""
    arch = platform.machine()
    bits = struct.calcsize("P") * 8
    python_arch = platform.architecture()[0]
    processor = platform.processor()
    
    return {
        "architecture": arch,
        "bits": f"{bits}-bit",
        "python_arch": python_arch,
        "processor": processor or "unknown"
    }

if __name__ == "__main__":
    info = get_architecture()
    
    print("=" * 50)
    print("Multi-Architecture Build Demo")
    print("=" * 50)
    print(f"Platform:       {sys.platform}")
    print(f"Architecture:   {info['architecture']}")
    print(f"Bit depth:      {info['bits']}")
    print(f"Python arch:    {info['python_arch']}")
    print(f"Processor:      {info['processor']}")
    print("=" * 50)
    print("This image can run on multiple CPU architectures!")
    print("Docker multi-arch builds make this possible.")
