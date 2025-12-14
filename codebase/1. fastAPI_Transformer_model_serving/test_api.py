import requests
import json

# API endpoint
url = "http://127.0.0.1:8000/question_answering"

# Test data
data = {
    "question": "What is extractive question answering?",
    "context": "Extractive Question Answering is the task of extracting an answer from a text given a question. An example of a question answering dataset is the SQuAD dataset, which is entirely based on that task. If you would like to fine-tune a model on a SQuAD task, you may leverage the `run_squad.py`."
}

print("=" * 60)
print("Testing FastAPI Question Answering Endpoint")
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
    print("Make sure the FastAPI server is running (python main.py)")
except Exception as e:
    print(f"\n❌ ERROR: {str(e)}")

print("\n" + "=" * 60)
