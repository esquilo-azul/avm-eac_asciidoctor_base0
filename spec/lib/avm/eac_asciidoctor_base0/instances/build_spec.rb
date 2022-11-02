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
  let(:fixtures_dir) { __dir__.to_pathname.join('build_spec_files') }
  let(:fs_comparator) { ::EacFs::Comparator.new.truncate_file('*.html') }
  let(:instance) { described_class.new(application_instance) }
  let(:source) { avm_source('EacAsciidoctorBase0', target_basename: application.id) }
  let(:target_dir) { fixtures_dir }
  let(:main_document) do
    source.path.join(::Avm::EacAsciidoctorBase0::Sources::Base::MAIN_FILE_SUBPATH)
  end

  before do
    application.entry('stereotype').write('EacAsciidoctorBase0')
    ::EacConfig::Node.context.current.entry("#{application.id}_dev.install.path")
                     .value = source.path.to_path
    application_instance.entry('install.name').write('The Author')
    application_instance.entry('install.name_initials').write('T.A.')
    application_instance.entry('install.email').write('theauthor@example.net')
    application_instance.entry('web.url').write('https://www.example.net')
    %w[doc1 doc2 doc2/doc2_1].each do |subpath|
      target_dir = source.content_directory.join(subpath)
      target_dir.mkpath
      ::FileUtils.cp(
        main_document,
        target_dir.join(::Avm::EacAsciidoctorBase0::Sources::Base::CONTENT_DOCUMENT_BASENAME)
      )
      ::FileUtils.cp(
        source.root_document.title_path,
        target_dir.join(::Avm::EacAsciidoctorBase0::Sources::Base::Document::TITLE_BASENAME)
      )
    end
    instance.perform
  end

  it do
    expect(fs_comparator.build(instance.target_directory)).to eq(fs_comparator.build(target_dir))
  end
end
