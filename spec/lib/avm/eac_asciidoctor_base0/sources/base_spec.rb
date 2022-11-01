# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/base'
require 'avm/eac_asciidoctor_base0/sources/base'

::RSpec.describe ::Avm::EacAsciidoctorBase0::Sources::Base do
  include_examples 'in_avm_registry', 'sources'

  describe '#instance' do
    let(:application) { ::Avm::Applications::Base.new('myapp') }
    let(:source) { avm_source('EacAsciidoctorBase0', target_basename: application.id) }

    before do
      application.local_source_path_entry.value = source.path
    end

    it do
      expect(source.instance).to be_a(::Avm::EacAsciidoctorBase0::Instances::Base)
    end
  end
end
