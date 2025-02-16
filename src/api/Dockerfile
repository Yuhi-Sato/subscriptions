FROM ruby:3.4.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /app

RUN gem install bundler -v 2.4.22

COPY Gemfile Gemfile.lock /app/

RUN bundle install

COPY . /app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
