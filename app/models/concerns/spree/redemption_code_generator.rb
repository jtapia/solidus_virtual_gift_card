# frozen_string_literal: true

module Spree
  module RedemptionCodeGenerator
    def self.generate_redemption_code
      chars = [('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
      Array.new(16).map { chars[rand(chars.count)] }.join
    end

    def self.format_redemption_code_for_lookup(redemption_code)
      redemption_code.delete('-').upcase
    end
  end
end
