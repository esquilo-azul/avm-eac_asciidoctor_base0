# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/build'

::RSpec.describe ::Avm::EacAsciidoctorBase0::Instances::Build::Document do
  let(:app_director) { eac_asciidoctor_base0_stubs }
  let(:build) { ::Avm::EacAsciidoctorBase0::Instances::Build.new(app_director.instance) }
  let(:fixtures_dir) { __dir__.to_pathname.join('document_spec_files') }
  let(:instance) { build.root_document }
  let(:target_file) { fixtures_dir.join('pre_processed_root_body.adoc') }

  it do
    expect(instance.pre_processed_body_source_content).to eq(target_file.read)
  end
end
