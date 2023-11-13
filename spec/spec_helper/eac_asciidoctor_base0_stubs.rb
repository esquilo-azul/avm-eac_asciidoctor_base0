# frozen_string_literal: true

require 'eac_config/node'
require 'avm/applications/base'
require 'avm/instances/base'
require 'eac_ruby_utils/core_ext'

module EacAsciidoctorBase0Stubs
  class Director
    DEFAULT_APPLICATION_ID = 'myapp'
    INSTANCE_ENTRY_KEYS = {
      'install.name' => 'The Author',
      'install.name_initials' => 'T.A.',
      'install.email' => 'theauthor@example.net',
      'web.url' => 'https://www.example.net'
    }.freeze

    enable_simple_cache
    common_constructor :rspec_example, :application_id, default: [DEFAULT_APPLICATION_ID] do
      source
      application
      instance
    end

    private

    # @return [Avm::Applications::Base]
    def application_uncached
      r = ::Avm::Applications::Base.new(application_id)
      r.entry('stereotype').write('EacAsciidoctorBase0')
      r.local_source_path_entry.value = source.path.to_path
      r
    end

    # @return [Avm::EacAsciidoctorBase0::Instances::Base]
    def instance_uncached
      r = ::Avm::EacAsciidoctorBase0::Instances::Base.new(application, 'stub')
      INSTANCE_ENTRY_KEYS.each { |k, v| r.entry(k).write(v) }
      r
    end

    # @return [Avm::EacAsciidoctorBase0::Sources::Base]
    def source_uncached
      rspec_example.avm_source('EacAsciidoctorBase0', target_basename: application_id)
    end
  end

  def eac_asciidoctor_base0_stubs(id = nil)
    args = [self]
    args << id if id.present?
    ::EacAsciidoctorBase0Stubs::Director.new(*args)
  end
end

EacRubyUtils::Rspec.default_setup.rspec_config.include(EacAsciidoctorBase0Stubs)
