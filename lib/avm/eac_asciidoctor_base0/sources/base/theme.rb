# frozen_string_literal: true

require 'asciidoctor'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Base
        module Theme
          CONFIGURATION_THEME_KEY = 'theme'
          DEFAULT_THEME_DIRECTORY_SUBPATH = 'theme'
          THEME_STYLESHEET_BASENAME = 'main.css'

          # @param target_directory_path [Pathname]
          def copy_theme_directory_to(target_directory_path)
            target_directory_path.parent.mkpath
            ::FileUtils.copy_entry(theme_directory, target_directory_path)
          end

          # @return [Pathname]
          def default_theme_directory
            path.join(DEFAULT_THEME_DIRECTORY_SUBPATH)
          end

          # @return [Pathname]
          def theme_directory
            theme_directory_by_configuration || default_theme_directory
          end

          # @return [Pathname]
          def theme_directory_by_configuration
            configuration_entry(CONFIGURATION_THEME_KEY).value.if_present do |v|
              v.to_pathname.expand_path(path)
            end
          end

          # @return [Pathname]
          def theme_stylesheet_path
            theme_directory.join(THEME_STYLESHEET_BASENAME)
          end
        end
      end
    end
  end
end
