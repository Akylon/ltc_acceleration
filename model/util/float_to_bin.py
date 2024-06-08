import numpy as np

a = np.array([0.1], dtype=np.float32)

b = a[0]

#bin = f"{a:b}"

m, e = np.frexp(a)
base = np.float32(2.0)

print(f"m: {m}, e: {e}")
print(m*base**e)


print(f"{int(b):0b}")

import struct
def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

print(binary(b))