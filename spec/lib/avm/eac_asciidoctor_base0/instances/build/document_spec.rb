# frozen_string_literal: true

RSpec.describe Avm::EacAsciidoctorBase0::Instances::Build::Document do
  let(:app_director) { eac_asciidoctor_base0_stubs }
  let(:build) { Avm::EacAsciidoctorBase0::Instances::Build.new(app_director.instance) }
  let(:fixtures_dir) { __dir__.to_pathname.join('document_spec_files') }
  let(:instance) { build_doc_child(build.root_document, :c1, :c1_1, :c1_1_1) } # rubocop:disable Naming/VariableNumber
  let(:target_file) { fixtures_dir.join('pre_processed_root_body.adoc') }
  let(:source) { app_director.source }
  let(:doc_template) do
    r = temp_dir
    FileUtils.copy_entry(source.root_document.root_path, r)
    r
  end
  let(:pre_processed_body_source_content) do
    sanitize_body_source(instance.pre_processed_body_source_content)
  end

  before do
    copy_template_hash(
      source.root_document,
      c1: {
        c1_1: { # rubocop:disable Naming/VariableNumber
          c1_1_1: { # rubocop:disable Naming/VariableNumber
            c1_1_1_1: {}, # rubocop:disable Naming/VariableNumber
            c1_1_1_2: {} # rubocop:disable Naming/VariableNumber
          },
          c1_1_2: { # rubocop:disable Naming/VariableNumber
            c1_1_2_1: {}, # rubocop:disable Naming/VariableNumber
            c1_1_2_2: {} # rubocop:disable Naming/VariableNumber
          }
        }
      },
      c2: {
        c2_1: {} # rubocop:disable Naming/VariableNumber
      }
    )
  end

  it do
    expect(pre_processed_body_source_content).to eq(target_file.read)
  end

  # @return [Avm::EacAsciidoctorBase0::Sources::Document]
  def copy_template_doc(parent, basename)
    parent.assert_argument(Avm::EacAsciidoctorBase0::Sources::Document, 'parent')

    root_target = parent.root_path.join(basename.to_s)
    FileUtils.copy_entry(doc_template, root_target)
    root_target.join('title').write(root_target.basename.to_path)
    Avm::EacAsciidoctorBase0::Sources::Document.new(parent.source, parent,
                                                    root_target.basename)
  end

  # @return [Array<Avm::EacAsciidoctorBase0::Sources::Document>]
  def copy_template_hash(parent, hash)
    parent.assert_argument(Avm::EacAsciidoctorBase0::Sources::Document, 'parent')
    hash.assert_argument(Hash, 'hash')

    hash.map do |k, v|
      r = copy_template_doc(parent, k)
      copy_template_hash(r, v)
      r
    end
  end

  # @return [Avm::EacAsciidoctorBase0::Instances::Build::Document]
  def build_doc_child(build_doc, *path)
    basename = path.shift.to_s
    r = build_doc.child!(basename)
    path.any? ? build_doc_child(r, *path) : r
  end

  # @param source [String]
  # @return [String]
  def sanitize_body_source(source)
    source.gsub(/^:stylesheet:\s*.+\s*$/, ':stylesheet: ../../../../theme/main.css')
  end
end
