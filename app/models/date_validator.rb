class DateValidator < ActiveModel::Validator
  def validate(record)
    if !record.valid_from.is_a?(Date)
      record.errors[:valid_from] << "is invalid Date"
    end

    if !record.valid_through.is_a?(Date)
      record.errors[:valid_through] << "is invalid Date"
    end

    if record.valid_through.is_a?(Date) && record.valid_from.is_a?(Date)
      if record.valid_through < record.valid_from
       record.errors[:valid_through] << "must be greater than or equal to valid_from"
      end
    end
  end
end
