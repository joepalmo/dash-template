FROM python:3.9-slim

RUN apt-get update -yq && apt-get upgrade -yq && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/app
WORKDIR /home/app

COPY app /home/app

ENV PIP_DISABLE_VERSION_CHECK=1

# Install Python dependencies.
RUN pip3 install -r requirements.txt --compile --no-cache-dir

# Finally, run gunicorn.
CMD gunicorn -b 0.0.0.0:8000 app:server