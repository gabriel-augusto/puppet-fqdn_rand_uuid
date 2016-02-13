require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet_blacksmith/rake_tasks'
require 'json'

desc 'Release task for running on Travis CI'
task :travis_release => :validate do

  target_version = ENV['TRAVIS_TAG']
  if target_version.nil?
    puts 'Not a build for a tag, not doing a release'
    exit
  end

  unless ENV['MAIN_ENV'] == 'y'
    puts 'Skipping release process because this is not the main environment.'
    exit
  end

  metadata = JSON.parse(File.read('metadata.json'))
  if metadata['version'] != target_version
    fail 'Version in metadata.json does not match current tag.'
  end

  Rake::Task['module:push'].invoke

end
