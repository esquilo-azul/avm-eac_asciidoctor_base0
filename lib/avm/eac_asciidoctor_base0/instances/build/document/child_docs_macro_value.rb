# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          class ChildDocsMacroValue
            enable_method_class
            common_constructor :document

            # @return [Array<String>]
            def result
              document.children.map { |child_doc| ChildDocLine.new(document, child_doc) }.sort
                      .map(&:result)
            end

            class ChildDocLine
              common_constructor :document, :child
              compare_by :title, :address

              # @return [Pathname]
              def address
                child.body_target_path.relative_path_from(
                  document.body_target_path.dirname
                )
              end

              # @return [String]
              def link
                "link:#{address}[#{title}]"
              end

              # @return [String]
              def result
                "* #{link}"
              end

              # @return [String]
              def title
                child.source_document.title
              end
            end
          end
        end
      end
    end
  end
end
