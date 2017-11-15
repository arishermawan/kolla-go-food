class LocationValidator < ActiveModel::Validator
  def validate(record)
    if !record.address.empty? && !record.get_location.nil?
      if record.get_location[:status] == "NOT_FOUND"
        record.errors[:address] << "is not found"
      end
    end
  end
end
