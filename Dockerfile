# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any necessary packages, including transformers
RUN pip install --upgrade pip \
    && pip install transformers \
    && pip install torch  # Optional if you're using PyTorch
