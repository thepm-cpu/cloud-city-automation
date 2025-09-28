from flask import Flask, jsonify
import psycopg2
import os
import socket

app = Flask(__name__)

# Database configuration
def get_db_connection():
    conn = psycopg2.connect(
        host=os.getenv('DATABASE_HOST', 'localhost'),
        database=os.getenv('DATABASE_NAME', 'cloud_city_db'),
        user=os.getenv('DATABASE_USER', 'app_user'),
        password=os.getenv('DATABASE_PASSWORD', 'password')
    )
    return conn

@app.route('/')
def hello():
    hostname = socket.gethostname()
    return jsonify({
        'message': 'Welcome to Cloud City!',
        'hostname': hostname,
        'status': 'healthy'
    })

@app.route('/health')
def health():
    try:
        # Check database connection
        conn = get_db_connection()
        conn.close()
        db_status = 'healthy'
    except Exception as e:
        db_status = f'unhealthy: {str(e)}'
    
    return jsonify({
        'status': 'healthy',
        'database': db_status,
        'timestamp': '2024-01-01T00:00:00Z'
    }), 200

@app.route('/metrics')
def metrics():
    # Simple metrics endpoint for Prometheus
    metrics_data = """
# HELP http_requests_total Total HTTP requests
# TYPE http_requests_total counter
http_requests_total{{method="GET",endpoint="/"}} 10
http_requests_total{{method="GET",endpoint="/health"}} 5
# HELP app_health Application health status
# TYPE app_health gauge
app_health 1
"""
    return metrics_data, 200, {'Content-Type': 'text/plain'}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)