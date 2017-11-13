class VoucherValidator < ActiveModel::Validator
  def validate(record)
    if record.voucher_code != nil && record.voucher_code !=""
      find_voucher = Voucher.find_by(code: record.voucher_code)
      if find_voucher == nil
        record.errors[:voucher_code] << "is not exist"
      else
        if Date.today > find_voucher.valid_through
          record.errors[:voucher_code] << "is expire"
        end
      end
    end
  end
end
  