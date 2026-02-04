# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          class HeaderLines
            enable_method_class
            enable_settings_provider
            enable_simple_cache
            common_constructor :document

            delegate :build, :source_document, to: :document
            delegate :instance, to: :build
            delegate :author_email, :author_name, to: :instance

            ATTRIBUTES = ['Author Initials', 'toc', 'icons', 'numbered', 'source-highlighter',
                          'website'].freeze
            TOC = 'left'
            ICONS = ''
            NUMBERED = ''
            SOURCE_HIGHLIGHTER = 'rouge'

            # @return [String]
            def attribute_line(name, value)
              [":#{name}:", value].compact_blank.join(' ')
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

            # @return [String]
            def breadcrumbs_lines
              ['[.normal]', document.macro_lines(:breadcrumbs)]
            end

            # @return [Array<String>]
            def result
              [stylesheet_line, title_line, author_line] + attributes_lines + [''] +
                breadcrumbs_lines
            end

            # @return [Pathname]
            def relative_path_to_stylesheet
              build.theme.target_stylesheet_path
                .relative_path_from(document.body_target_path.dirname)
            end

            # @return [String]
            def stylesheet_line
              attribute_line('stylesheet', stylesheet_path)
            end

            # @return [String]
            def title_line
              "= #{source_document.title}"
            end

            def website
              instance.web_url
            end

            protected

            # @return [Pathname]
            def stylesheet_path_uncached
              temp = ::EacRubyUtils::Fs::Temp.file
              temp.write("@import '#{relative_path_to_stylesheet}'\n")
              temp.to_pathname
            end
          end
        end
      end
    end
  end
end
