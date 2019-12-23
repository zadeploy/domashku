from flask import Flask, render_template, request
import logging, sys
import re, telnetlib

app = Flask(__name__)
logging.basicConfig(stream=sys.stderr)

def memStats():
    host="localhost"
    port="11211"

    client = telnetlib.Telnet(host, port)
    client.write("stats\n")
    resp = client.read_until('END')

    result = dict(re.findall("STAT (.*) (.*)\r", resp))
    get_hits = int(result['get_hits'])
    get_misses = int(result['get_misses'])
    memory = int(result['bytes'])
    maxMemory = int(result['limit_maxbytes'])

    try:
        h_mPercentage = (get_misses * 100) / get_hits
        memoryUsage = (memory * 100) / maxMemory
        msg = str(h_mPercentage) + r"% of gets missed the cache" + r"<br>" + str(memoryUsage) + r"% of memcached memory used"
    except:
        msg = "Collecting data..."
    return msg

@app.route('/')
def stats():
    logging.error("Sample error message")
    return render_template("app.html.j2", some_message=memStats())

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
