FROM python:3.8-alpine

COPY . /graylog2thehive

WORKDIR /graylog2thehive

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
