# frozen_string_literal: true

class RelativePathValidator < ActiveModel::Validator
  def validate(record)
    return unless record.relative_path

    start_with_slash = start_with_slash?(record)
    if start_slash_required?(record)
      record.errors.add(:relative_path, :slash_required) unless start_with_slash
    elsif start_with_slash
      record.errors.add(:relative_path, :slash_not_allowed)
    end
  end

  def start_slash_required?(record)
    record.ancestry.nil?
  end

  def start_with_slash?(record)
    record.relative_path.start_with?('/')
  end
end
