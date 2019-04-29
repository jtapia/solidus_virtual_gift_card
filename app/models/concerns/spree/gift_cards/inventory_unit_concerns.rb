# frozen_string_literal: true

module Spree
  module GiftCards
    module InventoryUnitConcerns
      extend ActiveSupport::Concern

      included do
        has_one :gift_card, class_name: 'Spree::VirtualGiftCard'
      end
    end
  end
end
