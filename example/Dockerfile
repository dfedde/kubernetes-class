FROM ruby:slim


COPY Gemfile Gemfile.lock /opt/

WORKDIR /opt

RUN bundle install

COPY server.rb /opt/

CMD ["/opt/server.rb"]

EXPOSE 4567
