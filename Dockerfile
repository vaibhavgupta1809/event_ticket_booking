FROM ruby:3.1.2


# Install nodejs and yarn (if needed)
RUN apt-get update && apt-get install -y nodejs yarn
# RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Create directory for our Rails application and set it as working directory
RUN mkdir /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install bundler
RUN gem install bundler

# Install dependencies
RUN bundle install

# Copy the Rails application code
COPY . .

# Precompile the Rails assets
RUN rake assets:precompile

# Expose your Rails app
EXPOSE 3000

# Run Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]



# Stage for running tests
FROM ruby:3.1.2 as tester
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .
CMD ["rspec"]