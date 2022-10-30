# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/sources/base'
require 'avm/eac_asciidoctor_base0/sources/build'
require 'eac_fs/comparator'

::RSpec.describe ::Avm::EacAsciidoctorBase0::Sources::Build do
  let(:fixtures_dir) { __dir__.to_pathname.join('build_spec_files') }
  let(:fs_comparator) { ::EacFs::Comparator.new.truncate_file('*.html') }
  let(:instance) { described_class.new(source) }
  let(:source) { avm_source('EacAsciidoctorBase0') }
  let(:target_dir) { fixtures_dir }
  let(:main_document) do
    source.path.join(::Avm::EacAsciidoctorBase0::Sources::Base::MAIN_FILE_SUBPATH)
  end

  before do
    %w[doc1 doc2 doc2_1].each do |basename|
      ::FileUtils.cp(main_document, source.path.join("#{basename}.adoc"))
    end
    instance.perform
  end

  it do
    expect(fs_comparator.build(instance.target_directory)).to eq(fs_comparator.build(target_dir))
  end
end
