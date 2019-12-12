import os
import subprocess
import sys

class Cache:
    def __init__(self):
        self._cache = {}
        self._misses = 0
        self._hits = 0

    def put(self, key, value):
        self._cache[key] = value

    def get(self, key):
        if key in self._cache:
            self._hits += 1
            return self._cache[key]
        else:
            self._misses += 1
            return None

    def get_memory_usage(self):
        out = subprocess.Popen(['ps', 'v', '-p', str(os.getpid())],
                               stdout=subprocess.PIPE).communicate()[0].split(b'\n')
        vsz_index = out[0].split().index(b'RSS')
        mem = float(out[1].split()[vsz_index]) / 1024
        cache_memory = sys.getsizeof(self._cache)
        return cache_memory / mem

    @staticmethod
    def get_value(**kwargs):
        value = 0
        for _, v in kwargs.items():
            try:
                value += int(v[0])
            except ValueError:
                value = 0
        return value

    def get_hit_rate(self):
        return 100 - (self._hits * 100 / (self._misses + self._hits))
