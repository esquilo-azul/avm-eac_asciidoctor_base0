# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/sources/base'
require 'avm/eac_asciidoctor_base0/instances/build'
require 'eac_fs/comparator'

::RSpec.describe ::Avm::EacAsciidoctorBase0::Instances::Build do # rubocop:disable Metrics/BlockLength
  let(:application) { ::Avm::Applications::Base.new('myapp') }
  let(:application_instance) do
    ::Avm::EacAsciidoctorBase0::Instances::Base
      .new(application, 'stub')
  end
  let(:fs_comparator) { ::EacFs::Comparator.new.truncate_file('*.html') }
  let(:instance) { described_class.new(application_instance) }
  let(:source) { avm_source('EacAsciidoctorBase0', target_basename: application.id) }

  before do
    application.entry('stereotype').write('EacAsciidoctorBase0')
    ::EacConfig::Node.context.current.entry("#{application.id}_dev.install.path")
                     .value = source.path.to_path
    application_instance.entry('install.name').write('The Author')
    application_instance.entry('install.name_initials').write('T.A.')
    application_instance.entry('install.email').write('theauthor@example.net')
    application_instance.entry('web.url').write('https://www.example.net')
  end

  include_examples 'source_target_fixtures', __FILE__ do
    def source_data(source_file)
      ::FileUtils.copy_entry(source_file, source.path)
      instance.perform
      fs_comparator.build(instance.target_directory)
    end

    def target_data(target_file)
      fs_comparator.build(target_file.to_pathname)
    end
  end
end
