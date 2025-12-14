"""
Script to create a TensorFlow SavedModel for TFX serving
This converts a BERT sentiment analysis model to TensorFlow format
"""

print("=" * 60)
print("Creating TensorFlow SavedModel for TFX Serving")
print("=" * 60)

# Step 1: Import required libraries
print("\n[Step 1/3] Importing libraries...")
try:
    from transformers import TFBertForSequenceClassification
    print("✓ Transformers imported successfully")
except ImportError as e:
    print(f"✗ Error importing transformers: {e}")
    print("Please run: pip install transformers tensorflow")
    exit(1)

# Step 2: Load the pre-trained model
print("\n[Step 2/3] Loading pre-trained BERT model from Hugging Face...")
print("This will download ~400MB, please wait...")

try:
    model = TFBertForSequenceClassification.from_pretrained(
        "nateraw/bert-base-uncased-imdb",
        from_pt=True  # Convert from PyTorch to TensorFlow
    )
    print("✓ Model loaded successfully")
except Exception as e:
    print(f"✗ Error loading model: {e}")
    exit(1)

# Step 3: Save the model in TensorFlow SavedModel format
print("\n[Step 3/3] Saving model in TensorFlow SavedModel format...")

try:
    model.save_pretrained("tfx_model", saved_model=True)
    print("✓ Model saved successfully to: tfx_model/saved_model/1/")
except Exception as e:
    print(f"✗ Error saving model: {e}")
    exit(1)

print("\n" + "=" * 60)
print("SUCCESS! Model is ready for TFX serving")
print("=" * 60)
print("\nNext steps:")
print("1. Pull TensorFlow Serving: docker pull tensorflow/serving")
print("2. Run the Docker commands from the lab instructions")
print("=" * 60)
