module Bumper
  class Medjool

    [:major, :minor, :revision, :build].each do |part|
      define_method part do
        @v[part]
      end

      define_method "mbump_#{part}" do
        mbump(part)
      end
    end

    def initialize(v)
      @v = {}
      if v =~ /^(\d+)\.(\d+)\.(\d+)(?:\.(.*?))?$/
        @v[:major]    = $1
        @v[:minor]    = $2 == '0' ? get_current_minor : $2
        @v[:revision] = $3 == '0' ? get_current_revision : $3
        @v[:build]    = $4
      end
    end

    def mbump(part)
      version = @v[part] = @v[part].succ

      # If we are bumping the major, then reset all
      # the other version parts and return.
      if part == :major
        @v[:revision] = get_current_revision
        @v[:minor]    = get_current_minor
        @v[:build]    = '0'
        return version
      end

      # We are here because we bumped the build, so
      # we need to check for a date change to see
      # if need to reset the build number itself.
      if version_out_of_date?
        @v[:revision] = get_current_revision
        @v[:minor]    = get_current_minor
        @v[:build]    = '1'
      end

      version
    end

    def get_current_minor
      Time.now.year.to_s + ("%02d" % Time.now.month)
    end

    def get_current_revision
      "%02d" % Time.now.day
    end

    def version_out_of_date?
      (@v[:minor] != get_current_minor) or (@v[:revision] != get_current_revision)
    end

    def to_s
      [major, minor, revision, build].compact.join('.')
    end

    def write(f)
      File.open(f, 'w') { |h| h.write(self.to_s) }
    end
  end
end
