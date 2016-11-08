require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard'

# Test tasks
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb'] # optional
  t.options = %w{--private} # optional
  t.stats_options = ['--list-undoc'] # optional
end

# Default task
task :default => :test
