# frozen_string_literal: true

desc "Lint with rubocop and auto fix"
task :lint do
  exec "bundle exec rubocop -A"
end
