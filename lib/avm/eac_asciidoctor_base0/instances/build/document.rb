# frozen_string_literal: true

require 'asciidoctor'
require 'avm/eac_asciidoctor_base0/instances/macros'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          require_sub __FILE__, include_modules: true

          BODY_TARGET_BASENAME = 'index.html'

          enable_simple_cache
          enable_speaker
          common_constructor :build, :parent_document, :source_document
          delegate :subpath, to: :source_document

          # @param other [Avm::EacAsciidoctorBase0::Instances::Build::Document]
          # @return [String]
          def href_to_other_body(other)
            other.body_target_path.relative_path_from(body_target_path.dirname)
          end

          # @return [Enumerable<String>]
          def body_source_lines
            if source_document.body_path.file?
              source_document.body_path.read.each_line
            else
              default_body_source_lines
            end
          end

          # Absolute path to the output of Asciidoctor's source file.
          #
          # @return [Pathname]
          def body_target_path
            build.target_directory.join(source_document.subpath).join(BODY_TARGET_BASENAME)
          end

          # @return [Asciidoctor::Document]
          def build_body
            ::Asciidoctor.convert(
              pre_processed_body_source_content,
              base_dir: convert_base_dir,
              to_file: body_target_path.to_path, safe: :unsafe, mkdirs: true
            )
          end

          # @param basename [String]
          # @return [Avm::EacAsciidoctorBase0::Instances::Build::Document, nil]
          def child(basename)
            basename = basename.to_s
            children.find { |c| c.source_document.root_path.basename.to_path == basename }
          end

          # @param basename [String]
          # @return [Avm::EacAsciidoctorBase0::Instances::Build::Document]
          def child!(basename)
            child(basename) || raise("Child not found with basename \"#{basename}\"")
          end

          # @return [Pathname]
          def convert_base_dir
            source_document.root_path
          end

          # @return [Enumerable<String>]
          def default_body_source_lines
            macro_lines(:default_body)
          end

          # @param name [String]
          # @return [Array<String>]
          def macro_lines(name, arguments = [])
            ::Avm::EacAsciidoctorBase0::Instances::Macros.const_get(name.to_s.camelize)
              .new(self, arguments).result
          end

          def perform
            perform_self
            perform_children
          end

          def perform_self
            infov 'Building', source_document.subpath
            build_body
            copy_media_directory
          end

          def perform_children
            children.each(&:perform)
          end

          # @return [String]
          def pre_processed_body_source_content
            (
              header_lines + [''] + body_source_lines
              .flat_map { |line| pre_process_line(line.rstrip) }
            ).map { |line| "#{line.rstrip}\n" }.join
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
