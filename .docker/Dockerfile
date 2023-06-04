ARG RUBY_IMAGE=ruby:3.1.2-slim

FROM ${RUBY_IMAGE}

RUN apt-get update \
    && apt-get install -y build-essential git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# install latest bundler
RUN gem install bundler

# Create app directory
WORKDIR /workspace

# Set bundle path
ENV BUNDLE_PATH /bundle

# Default to console
CMD ["bin/console"]
