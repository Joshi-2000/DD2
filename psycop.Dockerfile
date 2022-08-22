FROM python:3-slim
RUN pip install psycopg[binary]
RUN pip install requests
COPY Get_data.py /app/Get_data.py
CMD python /app/Get_data.py



