# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Deploy < ::Avm::EacWebappBase0::Instances::Deploy
        def build_content
          ::Avm::EacAsciidoctorBase0::Instances::Build.new(
            instance,
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
