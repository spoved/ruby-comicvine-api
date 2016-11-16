require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard'

# Test tasks
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = false
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb'] # optional
  t.options = %w{--private} # optional
  t.stats_options = ['--list-undoc'] # optional
end

# Default task
task :default => :test

Rake::Task['build'].enhance do
  require 'digest/sha2'
  built_gem_path = 'pkg/comicvine-'+ComicVine::VERSION+'.gem'
  checksum = Digest::SHA256.new.hexdigest(File.read(built_gem_path))
  checksum_path = 'checksum/comicvine-'+ComicVine::VERSION+'.gem.sha256'
  File.open(checksum_path, 'w' ) {|f| f.write(checksum) }
end