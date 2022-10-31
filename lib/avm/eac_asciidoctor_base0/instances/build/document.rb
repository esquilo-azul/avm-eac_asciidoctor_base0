# frozen_string_literal: true

require 'asciidoctor'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          require_sub __FILE__

          ROOT_BODY_TARGET_BASENAME = 'index'

          enable_simple_cache
          enable_speaker
          common_constructor :build, :parent_document, :basename

          # Absolute path to the Asciidoctor file.
          #
          # @return [Pathname]
          def body_source_path
            root_source_path.join(
              ::Avm::EacAsciidoctorBase0::Sources::Base::CONTENT_DOCUMENT_BASENAME
            )
          end

          # Absolute path to the output of Asciidoctor's source file.
          #
          # @return [Pathname]
          def body_target_path
            build.target_directory.join(
              parent_document.present? ? subpath : ROOT_BODY_TARGET_BASENAME
            ).basename_sub('.*') { |b| "#{b}.html" }
          end

          def perform
            perform_self
            perform_children
          end

          def perform_self
            infov 'Building', root_source_path
            ::Asciidoctor.convert(
              pre_processed_body_source_content,
              to_file: body_target_path.to_path, safe: :unsafe, mkdirs: true
            )
          end

          def perform_children
            children.each(&:perform)
          end

          # @return [String]
          def pre_processed_body_source_content
            body_source_path.read.each_line.map { |line| pre_process_line(line.rstrip) + "\n" }.join
          end

          def tree_documents_count
            children.inject(1) { |a, e| a + e.tree_documents_count }
          end

          # Absolute path to the document's source root.
          #
          # @return [Pathname]
          def root_source_path
            build.source.content_directory.join(subpath)
          end

          def subpath
            parent_document.if_present('.'.to_pathname) { |pd| pd.subpath.join(basename) }
          end

          private

          def children_uncached
            root_source_path.children.select(&:directory?)
                            .map { |path| self.class.new(build, self, path.basename) }
          end
        end
      end
    end
  end
end
