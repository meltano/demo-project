ARG MELTANO_IMAGE=meltano/meltano:latest
FROM $MELTANO_IMAGE

WORKDIR /project
COPY . .

RUN pip install -r requirements.txt
RUN meltano install
RUN cp --remove-destination .meltano/cache/discovery.yml .

# meltano ui
ENV MELTANO_READONLY 1
EXPOSE 5000

ENTRYPOINT ["meltano"]