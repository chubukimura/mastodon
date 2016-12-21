# frozen_string_literal: true

module Streamable
  extend ActiveSupport::Concern

  included do
    has_one :stream_entry, as: :activity

    def title
      super
    end

    def content
      title
    end

    def target
      super
    end

    def object_type
      :activity
    end

    def thread
      super
    end

    def hidden?
      false
    end

    after_create do
      account.stream_entries.create!(activity: self, hidden: hidden?) if account.local?
    end
  end
end
