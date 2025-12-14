import requests
import json

# API endpoint
url = "http://127.0.0.1:8000/sentiment"

# Test data
data = {
    "text": "A very cool output using tensorflow extended serving"
}

print("=" * 60)
print("Testing TFX-based FastAPI Endpoint")
print("=" * 60)
print("\nSending POST request to:", url)
print("\nRequest Body:")
print(json.dumps(data, indent=2))
print("\n" + "-" * 60)

try:
    # Send POST request
    response = requests.post(url, json=data)

    # Check if request was successful
    if response.status_code == 200:
        print("\n✅ SUCCESS! Status Code:", response.status_code)
        print("\nResponse:")
        print(json.dumps(response.json(), indent=2))
    else:
        print(f"\n❌ ERROR! Status Code: {response.status_code}")
        print("Response:", response.text)

except requests.exceptions.ConnectionError:
    print("\n❌ ERROR: Could not connect to the API!")
    print("Make sure both FastAPI and TFX Docker are running")
except Exception as e:
    print(f"\n❌ ERROR: {str(e)}")

print("\n" + "=" * 60)
