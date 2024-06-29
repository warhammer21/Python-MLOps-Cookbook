FROM python:3.8.8-slim-buster

# Install Poetry
RUN pip install --no-cache-dir poetry

# Working Directory
WORKDIR /app

# Copy source code and poetry files to working directory
COPY pyproject.toml poetry.lock /app/

# Install dependencies
RUN poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

# Copy the rest of your application
COPY . /app/

# Expose port
EXPOSE 8080

# Command to run the application
CMD ["poetry", "run", "gunicorn", "-c", "gunicorn_config.py", "app:app"]
