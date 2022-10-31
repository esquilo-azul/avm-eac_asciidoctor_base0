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

            delegate :build, to: :document
            delegate :instance, to: :build
            delegate :author_email, :author_name, to: :instance

            ATTRIBUTES = ['Author Initials', 'toc', 'icons', 'numbered', 'website'].freeze
            TOC = 'left'
            ICONS = ''
            NUMBERED = ''

            def attributes_lines
              ATTRIBUTES.map do |attr|
                [":#{attr}:", attribute_value(attr)].reject(&:blank?).join(' ')
              end
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
              [author_line] + attributes_lines
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
