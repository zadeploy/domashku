from flask import Flask, render_template, request
import logging, sys
import memcached_stats

app = Flask(__name__)
logging.basicConfig(stream=sys.stderr)

@app.route('/')
def stats():
    logging.error("Memcache stats info has been sent to the browser!")
    metrics = memcached_stats.Metrics(memcached_stats.Client.stats())

    return render_template(
        "app.html.j2",
        memory_used_rate=metrics.memory_used_rate(),
        get_miss_rate=metrics.get_miss_rate(),
        stats=metrics.raw)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
