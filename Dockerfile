FROM ruby:3.2.2
ENV ROOT="/app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Jakarta

WORKDIR ${ROOT}

COPY Gemfile ${ROOT}
COPY Gemfile.lock ${ROOT}

RUN gem install bundler
RUN bundle install --jobs 4