# frozen_string_literal: true

require 'asciidoctor'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Base
        class InstanceToBuild
          AUTHOR_EMAIL = 'author@local.net'
          AUTHOR_NAME = 'Local Author'
          AUTHOR_NAME_INITIALS = 'L.A.'

          common_constructor :source

          # @return [Struct]
          def application
            ::Struct.new(:local_source).new(source)
          end

          # @return [String]
          def author_email
            AUTHOR_EMAIL
          end

          # @return [String]
          def author_name
            AUTHOR_NAME
          end

          # @return [String]
          def author_name_initials
            AUTHOR_NAME_INITIALS
          end

          # @return [String]
          def web_url
            "file://#{source.path.expand_path.join('build', 'index.html')}"
          end
        end
      end
    end
  end
end
