from memcached_stat import MemcachedStat
from flask import Flask, render_template, request
import logging, sys

app = Flask(__name__)
logging.basicConfig(stream=sys.stderr)

memcached = MemcachedStat()

@app.route('/')
def stats():
    full_stat = memcached.stats()
    logging.error("Sample error message")
    if any(full_stat):
       return render_template("app.html.j2", statistic= full_stat)
    else:
       return render_template("app.html.j2", error_message="Sorry! Smth went wrong:(")

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
