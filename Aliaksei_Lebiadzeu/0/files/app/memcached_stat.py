import os
import re

MEMCACHED_STATS_CLI_COMMAND = 'echo stats | nc localhost 11211'

class MemcachedStat:    

    def __get_cli_output(self):
        return os.popen(MEMCACHED_STATS_CLI_COMMAND).read()

    def __convert_cli_output_to_dict(self, cli_output):
        print(repr(cli_output))
        reg = re.findall("[A-Z]+\s(.+?)\s(.+?)\\r?\n", cli_output)
        print(reg)
        return dict(reg)

    def __calculate_hits_percentage(self, stats):
        percentage = float(stats['get_hits']) / float(stats['cmd_get']) * 100
        return str(round(percentage, 2))

    def __calculate_miss_percentage(self, stats):
        percentage = float(stats['get_misses']) / float(stats['cmd_get']) * 100
        return str(round(percentage, 2))

    def __calculate_used_memory_percentage(self, stats):
        percentage = float(stats['bytes']) / float(stats['limit_maxbytes']) * 100
        return str(round(percentage, 2))

    def stats(self):
        stats = self.__convert_cli_output_to_dict(self.__get_cli_output())
        if any(stats): 
            stats['hits_percentage'] = self.__calculate_hits_percentage(stats)
            stats['miss_percentage'] = self.__calculate_miss_percentage(stats)
            stats['memory_percentage'] = self.__calculate_used_memory_percentage(stats)
        return stats
