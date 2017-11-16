class GopayValidator < ActiveModel::Validator
  def validate(record)
    # if !session[:user_id].nil?
      if record.payment_type == "Go Pay"
        gopay = User.find(record.user_id).gopay
        if record.total.nil?
          if gopay < record.sub_total
            record.errors[:payment_type] << "Gopay credit is not enough"
          end
        elsif !record.total.nil?
          if gopay < record.total
            record.errors[:payment_type] << "Gopay credit is not enough"
          end
        end

      # end
    end
  end
end
