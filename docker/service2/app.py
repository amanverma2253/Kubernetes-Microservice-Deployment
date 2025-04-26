from flask import Flask
import requests
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from Service 2!"

@app.route('/call-service1')
def call_service1():
    response = requests.get('http://service1:5000')
    return f"Service2 calling Service1: {response.text}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)