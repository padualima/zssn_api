FROM ruby:3.0.2
# Add nodejs and yarn dependencies
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# Install dependencies
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
nodejs yarn build-essential libpq-dev git-all nano

RUN gem install bundler
# Set project path
ENV INSTALL_PATH /myapp
RUN mkdir -p $INSTALL_PATH
# Set path with default directory
WORKDIR $INSTALL_PATH

# Copy Gemfile into container
COPY Gemfile ./
# Set path Gemfile
ENV BUNDLE_PATH /gems
# Copy code into container
COPY . .
