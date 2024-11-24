# Use the offical Ruby Image
FROM ruby:3.2

# Set working directory
WORKDIR /app

# copy the gemfile and install dependencies
COPY Gemfile ./
RUN bundle install

# copy the application code
COPY . .

# expose the application port
EXPOSE 4567

# command to start the sinatra app
CMD sh -c "ruby db/schema.rb && ruby db/seeds.rb && bundle exec ruby app.rb -o 0.0.0.0"