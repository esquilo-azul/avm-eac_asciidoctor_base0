# frozen_string_literal: true

require 'asciidoctor'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          require_sub __FILE__, include_modules: true

          enable_simple_cache
          enable_speaker
          common_constructor :build, :parent_document, :source_document
          delegate :subpath, to: :source_document

          # @param other [Avm::EacAsciidoctorBase0::Instances::Build::Document]
          # @return [String]
          def href_to_other_body(other)
            other.body_target_path.relative_path_from(body_target_path.dirname)
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
            body_target_write
            copy_media_directory
          end

          def perform_children
            children.each(&:perform)
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
