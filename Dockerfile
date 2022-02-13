# pull official python image from docker-hub
FROM python:3.9.0-alpine


# set environment variables
ENV PROJECT_ROOT /app
# Prevents Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE 1
# Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED 1


# set work directory
WORKDIR $PROJECT_ROOT


# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .

# for psycopg2
RUN apk update
RUN apk add postgresql-dev gcc python3-dev musl-dev
RUN pip install -r requirements.txt


# copy project
COPY . .

WORKDIR $PROJECT_ROOT/application

# copy entrypoint.sh - checks if Postgres is healthy before applying the migrations and running the Django development server.
COPY ./entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
