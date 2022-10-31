# frozen_string_literal: true

require 'avm/eac_webapp_base0/instances/deploy'
require 'avm/eac_asciidoctor_base0/sources/base'
require 'avm/eac_asciidoctor_base0/instances/build'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Deploy < ::Avm::EacWebappBase0::Instances::Deploy
        def build_content
          ::Avm::EacAsciidoctorBase0::Instances::Build.new(
            project,
            ::Avm::EacAsciidoctorBase0::Instances::Build::OPTION_TARGET_DIRECTORY => build_dir
          ).perform
        end

        private

        def project_uncached
          ::Avm::EacAsciidoctorBase0::Sources::Base.new(
            instance.source_instance.read_entry(::Avm::Instances::EntryKeys::INSTALL_PATH)
          )
        end
      end
    end
  end
end
