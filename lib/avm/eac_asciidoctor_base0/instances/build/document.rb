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
          common_constructor :build, :parent_document, :source_document

          # Absolute path to the output of Asciidoctor's source file.
          #
          # @return [Pathname]
          def body_target_path
            build.target_directory.join(
              parent_document.present? ? source_document.subpath : ROOT_BODY_TARGET_BASENAME
            ).basename_sub('.*') { |b| "#{b}.html" }
          end

          # @return [Pathname]
          def convert_base_dir
            source_document.root_path
          end

          def perform
            perform_self
            perform_children
          end

          def perform_self
            infov 'Building', source_document.root_path
            ::Asciidoctor.convert(
              pre_processed_body_source_content,
              base_dir: convert_base_dir,
              to_file: body_target_path.to_path, safe: :unsafe, mkdirs: true
            )
          end

          def perform_children
            children.each(&:perform)
          end

          # @return [String]
          def pre_processed_body_source_content
            source_document.body_path.read.each_line
                           .flat_map { |line| pre_process_line(line.rstrip) }
                           .map { |line| "#{line.rstrip}\n" }.join
          end

          def tree_documents_count
            children.inject(1) { |a, e| a + e.tree_documents_count }
          end

          private

          def children_uncached
            source_document.children
                           .map { |source_child| self.class.new(build, self, source_child) }
          end
        end
      end
    end
  end
end
