# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/macros'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Theme
          TARGET_SUBPATH = '_theme'

          common_constructor :build

          # @return [void]
          def perform
            copy_theme_to_target
          end

          # @return [Pathname]
          def target_path
            build.target_directory.join(TARGET_SUBPATH)
          end

          # @return [Pathname]
          def target_stylesheet_path
            target_path
              .join(Avm::EacAsciidoctorBase0::Sources::Base::Theme::THEME_STYLESHEET_BASENAME)
          end

          protected

          # @return [void]
          def copy_theme_to_target
            build.source.copy_theme_directory_to(target_path)
          end
        end
      end
    end
  end
end
