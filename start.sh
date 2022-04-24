bundle check || bundle install
# start puma
bundle exec puma -C config/puma.rb
