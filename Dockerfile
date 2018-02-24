FROM orihoch/sk8s-pipelines:v0.0.3-b

ENV PYTHONUNBUFFERED 1

COPY Pipfile /pipelines/
COPY Pipfile.lock /pipelines/
RUN pipenv install --system --deploy --ignore-pipfile && pipenv check

COPY --from=orihoch/sk8s-pipelines:v0.0.3-g /entrypoint.sh /entrypoint.sh

COPY *.py /pipelines/
COPY *.sh /pipelines/
COPY *.yaml /pipelines/

ENV PIPELINES_SCRIPT="cd /pipelines && (source ./pipelines_script.sh)"
ENV RUN_PIPELINE_CMD=run_pipeline
