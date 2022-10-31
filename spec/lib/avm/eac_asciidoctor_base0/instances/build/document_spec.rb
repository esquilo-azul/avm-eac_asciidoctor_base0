# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/sources/base'
require 'avm/eac_asciidoctor_base0/instances/build'

::RSpec.describe ::Avm::EacAsciidoctorBase0::Instances::Build::Document do
  let(:application) { ::Avm::Applications::Base.new('myapp') }
  let(:application_instance) do
    ::Avm::EacAsciidoctorBase0::Instances::Base
      .new(application, 'stub')
  end
  let(:build) { ::Avm::EacAsciidoctorBase0::Instances::Build.new(application_instance) }
  let(:fixtures_dir) { __dir__.to_pathname.join('document_spec_files') }
  let(:instance) { build.root_document }
  let(:source) { avm_source('EacAsciidoctorBase0', target_basename: application.id) }
  let(:target_file) { fixtures_dir.join('pre_processed_root_body.adoc') }

  before do
    application.entry('stereotype').write('EacAsciidoctorBase0')
    ::EacConfig::Node.context.current.entry("#{application.id}_dev.install.path")
                     .value = source.path.to_path
    application_instance.entry('install.path').write(source.path.to_path)
    application_instance.entry('install.name').write('The Author')
    application_instance.entry('install.name_initials').write('T.A.')
    application_instance.entry('install.email').write('theauthor@example.net')
    application_instance.entry('web.url').write('https://www.example.net')
  end

  it do
    expect(instance.pre_processed_body_source_content).to eq(target_file.read)
  end
end
