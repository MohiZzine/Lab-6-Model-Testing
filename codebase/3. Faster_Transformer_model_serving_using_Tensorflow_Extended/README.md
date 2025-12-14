# Part 3: TFX Deployment - Quick Start Guide

## Step-by-Step Instructions

### **Step 1: Setup Virtual Environment**

Open your terminal and navigate to this folder:

```bash
cd "c:\Users\farid\OneDrive\Desktop\Model Testing\codebase\3. Faster_Transformer_model_serving_using_Tensorflow_Extended"
```

Run the setup script:

```bash
setup_venv.bat
```

This will:
- Create a virtual environment called `venv_tfx`
- Install TensorFlow, PyTorch, transformers, FastAPI, and other dependencies
- Take about 5-10 minutes

📸 **SCREENSHOT 1**: Take a screenshot when installation completes successfully.

---

### **Step 2: Activate Virtual Environment**

```bash
venv_tfx\Scripts\activate
```

You should see `(venv_tfx)` at the beginning of your command prompt.

---

### **Step 3: Create the SavedModel**

```bash
python create_saved_model.py
```

This will:
- Download the BERT sentiment model (~400MB)
- Convert it from PyTorch to TensorFlow
- Save it in `tfx_model/saved_model/1/` folder

📸 **SCREENSHOT 2**: Screenshot showing "SUCCESS! Model is ready for TFX serving"

---

### **Step 4: Pull TensorFlow Serving Docker Image**

```bash
docker pull tensorflow/serving
```

📸 **SCREENSHOT 3**: Screenshot of docker pull completion.

---

### **Step 5: Setup TFX Docker Container**

Create and run a temporary container:

```bash
docker run -d --name serving_base tensorflow/serving
```

Copy the model into the container:

```bash
docker cp tfx_model/saved_model serving_base:/models/bert
```

Commit the container to a new image:

```bash
docker commit --change "ENV MODEL_NAME bert" serving_base my_bert_model
```

Stop and remove the temporary container:

```bash
docker stop serving_base
docker rm serving_base
```

📸 **SCREENSHOT 4**: Screenshot showing all docker commands completed.

---

### **Step 6: Run TFX Serving Container**

```bash
docker run -p 8501:8501 -p 8500:8500 --name bert my_bert_model
```

Keep this terminal window open! The TFX server is now running.

📸 **SCREENSHOT 5**: Screenshot showing TFX container running and serving.

---

### **Step 7: Start FastAPI Wrapper (New Terminal)**

Open a **NEW terminal window**, navigate to the folder, and activate the venv:

```bash
cd "c:\Users\farid\OneDrive\Desktop\Model Testing\codebase\3. Faster_Transformer_model_serving_using_Tensorflow_Extended"
venv_tfx\Scripts\activate
python main.py
```

📸 **SCREENSHOT 6**: Screenshot showing FastAPI started on port 8000.

---

### **Step 8: Test the System (Another New Terminal)**

Open **ANOTHER new terminal**, activate venv, and test:

```bash
cd "c:\Users\farid\OneDrive\Desktop\Model Testing\codebase\3. Faster_Transformer_model_serving_using_Tensorflow_Extended"
venv_tfx\Scripts\activate
python test_tfx_api.py
```

📸 **SCREENSHOT 7**: Screenshot showing the test result with sentiment prediction.

---

## Summary

You should now have:
- ✅ TFX Docker container running (Terminal 1)
- ✅ FastAPI wrapper running (Terminal 2)
- ✅ Test completed successfully (Terminal 3)

## Troubleshooting

**Error: "Could not connect to TFX"**
- Make sure TFX Docker container is running: `docker ps`

**Error: "Could not connect to FastAPI"**
- Make sure main.py is running in Terminal 2

**Port already in use**
- Stop existing containers: `docker stop bert`
- Or use different ports

---

## To Stop Everything

```bash
# Stop FastAPI (Terminal 2): Press Ctrl+C

# Stop TFX Docker (Terminal 1): Press Ctrl+C
# Or in any terminal:
docker stop bert
docker rm bert

# Deactivate virtual environment:
deactivate
```
