require 'rake'
require 'bumper/medjool'

@vfile = 'VERSION'

def bumper_file(file)
  @vfile = file
end

def bumper_medjool
  @medjool ||= Bumper::Medjool.new(File.read(@vfile))
end

namespace :mbump do
  desc "create a blank version file"
  task :init do
    @medjool = Bumper::Medjool.new('0.0.0.0')
    @medjool.write(@vfile)
  end

  desc "mbump major"
  task :major do
    bumper_medjool.mbump_major
    persist!
  end

  desc "mbump build"
  task :build do
    bumper_medjool.mbump_build
    persist!
  end

  def persist!
    bumper_medjool.write(@vfile)
    puts "version: #{bumper_medjool}"
  end
end
