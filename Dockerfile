# Pull a pre-built alpine docker image with nginx and python3 installed
FROM tiangolo/uwsgi-nginx:python3.8-alpine-2020-12-19

# Set the port on which the app runs; make both values the same.
ENV LISTEN_PORT=8000
EXPOSE 8000

# Indicate where uwsgi.ini lives
ENV UWSGI_INI uwsgi.ini

# Tell nginx where static files live.
ENV STATIC_URL /app/static_collected

# Copy the app files to a folder and run it from there
WORKDIR /app
COPY . /app

# Install PostgreSQL client libraries
RUN apk add --no-cache postgresql-libs

# Add the necessary build tools
RUN apk add --no-cache build-base


# Make sure dependencies are installed
RUN python3 -m pip install -r requirements.txt

# Upgrade pip
RUN python3 -m pip install --upgrade pip

