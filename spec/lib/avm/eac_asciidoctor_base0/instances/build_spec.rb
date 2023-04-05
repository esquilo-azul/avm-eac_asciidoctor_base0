# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/build'
require 'eac_fs/comparator'

::RSpec.describe ::Avm::EacAsciidoctorBase0::Instances::Build do
  let(:app_director) { eac_asciidoctor_base0_stubs }
  let(:fs_comparator) { ::EacFs::Comparator.new.truncate_file('*.html') }
  let(:instance) { described_class.new(app_director.instance) }

  include_examples 'source_target_fixtures', __FILE__ do
    def source_data(source_file)
      ::FileUtils.copy_entry(source_file, app_director.source.path)
      instance.perform
      fs_comparator.build(instance.target_directory)
    end

    def target_data(target_file)
      fs_comparator.build(target_file.to_pathname)
    end
  end
end
