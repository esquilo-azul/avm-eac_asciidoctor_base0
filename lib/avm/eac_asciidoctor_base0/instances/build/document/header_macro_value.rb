# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          class HeaderMacroValue
            enable_method_class
            enable_settings_provider
            enable_simple_cache
            common_constructor :document

            delegate :build, :source_document, to: :document
            delegate :instance, to: :build
            delegate :author_email, :author_name, to: :instance

            ATTRIBUTES = ['Author Initials', 'toc', 'icons', 'numbered', 'website'].freeze
            TOC = 'left'
            ICONS = ''
            NUMBERED = ''

            # @return [String]
            def attribute_line(name, value)
              [":#{name}:", value].reject(&:blank?).join(' ')
            end

            def attributes_lines
              ATTRIBUTES.map { |attr| attribute_line(attr, attribute_value(attr)) }
            end

            def attribute_value(attr)
              setting_value(attr.variableize)
            end

            def author_initials
              instance.author_name_initials
            end

            def author_line
              "#{author_name} <#{author_email}>"
            end

            def result
              result_lines.join("\n")
            end

            def result_lines
              [title_line, author_line] + attributes_lines
            end

            # @return [String]
            def title_line
              "= #{source_document.title}"
            end

            def website
              instance.web_url
            end
          end
        end
      end
    end
  end
end
