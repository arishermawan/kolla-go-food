class FoodsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "foods"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
