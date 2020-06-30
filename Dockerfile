ARG MELTANO_IMAGE=meltano/meltano:latest
FROM $MELTANO_IMAGE

WORKDIR /project
COPY . .

# Install any additional requirements
RUN pip install -r requirements.txt

# Install all plugins into the `.meltano` directory
RUN meltano install

# Pin `discovery.yml` manifest by copying cached version to project root
RUN ["/bin/bash", "-c", "[[ -f .meltano/cache/discovery.yml ]] && cp -n .meltano/cache/discovery.yml ."]

# Don't allow changes to containerized project
ENV MELTANO_READONLY 1

# Expose default port used by `meltano ui`
EXPOSE 5000

ENTRYPOINT ["meltano"]
