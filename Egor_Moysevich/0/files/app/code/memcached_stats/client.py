import re, telnetlib, sys

class Client:
  REGEX = re.compile(ur"STAT (.*) (.*)\r")
  CMD_END = 'END'

  def __init__(self, host, port):
    self._telnet = telnetlib.Telnet(host, port)

  def write(self, cmd):
    telnet_cmd = "%s\n" % cmd
    self._telnet.write(telnet_cmd)

  def read_command_result(self):
    return self._telnet.read_until(self.CMD_END)

  def command(self, cmd):
    self.write(cmd)

    return self.read_command_result()

  @classmethod
  def stats(cls, host='localhost', port='11211'):
    client = cls(host, port)
    plain_stats = client.command('stats')
    matched = re.findall(client.REGEX, plain_stats)

    return dict(matched)
