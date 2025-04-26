# Stage 1: Build stage
FROM python:3.9-alpine AS builder

# Install build dependencies
RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev

# Set working directory
WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Copy application code
COPY . .

# Stage 2: Runtime stage
FROM python:3.9-alpine

# Install runtime dependencies
RUN apk add --no-cache libffi

# Set working directory
WORKDIR /app

# Copy installed dependencies from the builder stage
COPY --from=builder /install /usr/local

# Copy application code
COPY . .

# Expose the application port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]