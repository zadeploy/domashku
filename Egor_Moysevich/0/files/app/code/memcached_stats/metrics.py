class Metrics:
  def __init__(self, stats):
    self.raw = stats

  def memory_used_rate(self):
    return self.rate_of('bytes', 'limit_maxbytes')

  def get_miss_rate(self):
    return self.rate_of('get_misses', 'cmd_get')

  def rate_of(self, value_key, compare_key):
    value = float(self.raw[value_key])
    compare_value = float(self.raw[compare_key])

    return round((value / compare_value) * 100, 2)
