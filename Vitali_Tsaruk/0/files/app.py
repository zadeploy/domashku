from flask import Flask, render_template, request
import logging
import sys
import telnetlib

app = Flask(__name__)
logging.basicConfig(stream=sys.stderr)


def memCasheStats():

    client = telnetlib.Telnet(host='localhost', port='11211')
    client.write("stats\n")
    listStats = client.read_until('END')
    listStats = listStats.split()
    get_hits = int(listStats[(listStats.index('get_hits')+1)])
    get_misses = int(listStats[(listStats.index('get_misses')+1)])
    mem_bytes = int(listStats[(listStats.index('bytes')+1)])
    limit_maxbytes = int(listStats[(listStats.index('limit_maxbytes')+1)])
    try:
        memory_used = (mem_bytes*100) / limit_maxbytes
        gets_missed = (get_misses*100) / get_hits
        result = str(gets_missed) + "% of gets missed the cache. " + \
            str(memory_used) + "% of memcached memory used."
    except:
        result = "no data"
    return result


@app.route('/')
def stats():
    logging.error("Sample error message")
    return render_template("app.html.j2", some_message=memCasheStats())


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
