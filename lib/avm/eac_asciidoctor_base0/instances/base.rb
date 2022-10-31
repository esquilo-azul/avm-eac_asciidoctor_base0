# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/apache_host'
require 'avm/eac_asciidoctor_base0/instances/apache_path'
require 'avm/eac_asciidoctor_base0/instances/deploy'
require 'avm/eac_webapp_base0/instances/base'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Base < ::Avm::EacWebappBase0::Instances::Base
        FILES_UNITS = {}.freeze
        AUTHOR_EMAIL_ENTRY_PATH = 'install.email'
        AUTHOR_NAME_ENTRY_PATH = 'install.name'
        AUTHOR_NAME_INITIALS_ENTRY_PATH = 'install.name_initials'

        # @return [String]
        def author_email
          entry(AUTHOR_EMAIL_ENTRY_PATH).value!
        end

        # @return [String]
        def author_name
          entry(AUTHOR_NAME_ENTRY_PATH).value!
        end

        # @return [String]
        def author_name_initials
          entry(AUTHOR_NAME_INITIALS_ENTRY_PATH).value!
        end
      end
    end
  end
end
