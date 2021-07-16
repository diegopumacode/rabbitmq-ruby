require 'bunny'

connection = Bunny.new()
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')
# durable => para ue la cola sea duradera
queue.publish(message, persistent: true)
puts " [x] Sent #{message}"

connection.close