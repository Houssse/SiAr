module ContentValidation
  extend ActiveSupport::Concern

  included do
    validate :content_length
  end

  private

  def content_length
    if content.nil? || content.body.to_plain_text.length < 5
      errors.add(:content, "must be at least 5 characters")
    end
  end
end
