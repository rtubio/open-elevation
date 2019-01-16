FROM python:3.7.2-stretch
ENV PYTHONUNBUFFERED 1
EXPOSE 8080

ADD ./config/debian.packages .
RUN apt-get update
RUN apt-get install -y $(grep -vE "^\s*#" debian.packages | tr "\n" " ")

ADD ./config/requirements.txt .
RUN pip install GDAL==2.1.3\
  --global-option=build_ext\
  --global-option="-I/usr/include/gdal"
RUN pip install -r requirements.txt
RUN pip uninstall -y GDAL
RUN pip install GDAL==2.1.3\
  --global-option=build_ext\
  --global-option="-I/usr/include/gdal"

RUN mkdir /code
ADD . /code/
WORKDIR /code

CMD python server.py
