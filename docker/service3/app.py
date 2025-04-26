from flask import Flask
import requests
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from Service 3!"

@app.route('/call-service2')
def call_service2():
    response = requests.get('http://service2:5000/call-service1')
    return f"Service3 calling Service2 which calls Service1: {response.text}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)