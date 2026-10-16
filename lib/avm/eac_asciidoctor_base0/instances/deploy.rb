# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Deploy < ::Avm::EacWebappBase0::Instances::Deploy
        # @return [void]
        def build_content
          ::Avm::EacAsciidoctorBase0::Instances::Build.new(
            instance,
            ::Avm::EacAsciidoctorBase0::Instances::Build::OPTION_SOURCE => source,
            ::Avm::EacAsciidoctorBase0::Instances::Build::OPTION_TARGET_DIRECTORY => build_dir
          ).perform
        end
      end
    end
  end
end
