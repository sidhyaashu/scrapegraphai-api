# --- Stage 1: The Builder ---
# (This part is correct, no changes needed)
FROM python:3.11-slim-bookworm AS builder
WORKDIR /app
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN apt-get update && apt-get install -y --no-install-recommends \
    libnss3 libnspr4 libdbus-1-3 libatk1.0-0 libatk-bridge2.0-0 \
    libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxrandr2 libgbm1 \
    libasound2 libpango1.0-0 libxshmfence1 libxfixes3 libxdamage1 \
    libx11-6 libxext6 libcairo2 \
    && rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN playwright install chromium

# --- Stage 2: The Final Image ---
# (This part is also correct, no changes needed)
FROM python:3.11-slim-bookworm
WORKDIR /app
COPY --from=builder /opt/venv /opt/venv
COPY --from=builder /usr/lib/ /usr/lib/
COPY --from=builder /lib/ /lib/
COPY --from=builder /usr/share/ /usr/share/
COPY --from=builder /root/.cache/ms-playwright/ /root/.cache/ms-playwright/
COPY . .
ENV PATH="/opt/venv/bin:$PATH"
EXPOSE 8000

# --- CHANGE THIS LINE ---
# Use the standard <module>:<attribute> format
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]