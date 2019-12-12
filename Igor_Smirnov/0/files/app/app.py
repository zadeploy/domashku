from cache import Cache
from flask import Flask, render_template, request


app = Flask(__name__)
cache = Cache()


@app.route('/')
def stats():
    request_args=request.args.to_dict(flat=False)
    request_key = str(request_args)
    value = cache.get(request_key)
    if value is None:
        request_value = cache.get_value(**request_args)
        cache.put(request_key, request_value)
    return render_template("app.html.j2", hit_rate=cache.get_hit_rate(),
                           value=value,
                           mem_usage=cache.get_memory_usage())


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
