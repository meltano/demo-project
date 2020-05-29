ARG MELTANO_IMAGE=meltano/meltano
FROM $MELTANO_IMAGE

WORKDIR /project
COPY . .

RUN pip install -r requirements.txt
RUN meltano install
RUN cp .meltano/cache/discovery.yml .

# meltano ui
ENV MELTANO_READONLY 1
EXPOSE 5000

ENTRYPOINT ["meltano"]