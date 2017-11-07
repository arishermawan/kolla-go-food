class AmountValidator < ActiveModel::Validator
  def validate(record)
    if record.unit_type == "Rp (Rupiah)"
      if record.max_amount < record.amount
        record.errors[:max_amount] << "must be greater or equal to amount"
      end
    end
  end
end
