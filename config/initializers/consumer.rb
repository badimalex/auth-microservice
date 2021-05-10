channel = RabbitMq.consumer_channel
exchange = channel.default_exchange

queue = channel.queue('auth', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, prop, payload|
  payload = JSON(payload)
  extracted_token = ExtractToken.extracted_token(payload['token'])
  result = Auth::FetchUserService.call(extracted_token['uuid'])

  # @todo
  if result.user
    exchange.publish(
      { user_id: result.user.id }.to_json,
      routing_key: prop.reply_to,
      correlation_id: prop.correlation_id
    )
  end
end
