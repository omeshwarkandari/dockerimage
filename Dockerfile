FROM python:3.7-alpine
Copy hello_there.py /
CMD [ "python", "hello_there.py"]
