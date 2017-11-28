class LocationValidator < ActiveModel::Validator
  def validate(record)
    if !record.address.empty? && !record.get_google_api.nil?
      if record.get_google_api[:status] == "NOT_FOUND"
        record.errors[:address] << "is not found"
      end
    end
  end
end
