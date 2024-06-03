FROM ruby:3.3.2

# Environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV APP_HOME=/app

RUN apt-get update -y \
    && apt-get install -y \
    apt-transport-https \
    libcurl4-gnutls-dev

# Create the home directory for the new app user.
RUN mkdir -p $APP_HOME

# Install the last bundler version
RUN gem install bundler --no-document

# Move to the application folder
WORKDIR $APP_HOME

COPY . .

# Install Bundler dependencies
RUN bundle config
RUN bundle install

CMD ["rackup"]
