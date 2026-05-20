FROM python:3.10-slim

# Install basic background dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements listing
COPY requirements.txt .

# Install dependencies, forcing pip to fetch CPU-only versions of Torch to keep the image lean
RUN pip install --no-cache-dir -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cpu

# Copy the rest of the workspace and run local editable package registration
COPY . .
RUN pip install -e .

# Launch the Gradio application
CMD ["python", "app.py"]
