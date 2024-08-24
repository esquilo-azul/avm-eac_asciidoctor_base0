# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/logging/error'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Logging
      class Catcher < ::SimpleDelegator
        CATCH_LEVEL = ::Logger::ERROR
        LOGGER_METHODS = %i[unknown fatal error warn info debug].freeze

        class << self
          # @param [String]
          # @return [Integer]
          def level_by_method(method_name)
            ::Logger.const_get(method_name.to_s.underscore.upcase)
          end

          # @return [Hash<Symbol, Integer]
          def methods_levels
            LOGGER_METHODS.to_h { |method_name| [method_name, level_by_method(method_name)] }
          end

          def on
            real_logger = ::Asciidoctor::LoggerManager.logger
            begin
              ::Asciidoctor::LoggerManager.logger = new(real_logger)
              yield
            ensure
              ::Asciidoctor::LoggerManager.logger = real_logger
            end
          end
        end

        methods_levels.each do |method_name, level|
          define_method method_name do |*args, &block|
            __getobj__.send(method_name, *args, &block)
            return unless level >= CATCH_LEVEL

            raise ::Avm::EacAsciidoctorBase0::Logging::Error.new(level, *args, &block)
          end
        end
      end
    end
  end
end
