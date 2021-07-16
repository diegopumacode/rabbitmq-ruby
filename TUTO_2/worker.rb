require 'bunny'

connection = Bunny.new()
connection.start

channel = connection.create_channel
queue = channel.queue('hello')


begin
    puts ' [*] Waiting for messages. To exit press CTRL+C'
    # manual ack => confirmacion de mensajes, aunque pare el proceso del un worker,la data no se perdera, los mensaje 
    # no reconocidos se volveran a entregar
    queue.subscribe(manual_ack: true ,block: true) do |delivery_info, _properties, body|
        puts " [x] Received #{body}"
        # imitate some work
        # Se toma el numero de puntos de una cadena , cada ounto represena un segundo "worker" =>  simulacion no ma
        sleep body.count('.').to_i
        puts ' [x] Done'

        channel.ack(delivery_info.delivery_tag)
    end
  rescue Interrupt => _
    connection.close

    exit(0)
end