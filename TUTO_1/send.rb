require 'bunny'

# conexion a rabbit === maquina local
connection = Bunny.new()
connection.start

# creacion de canal de la conexion
channel = connection.create_channel

# Ya con el canal creado solo queda crear la cola y la publicacion del mensaje
queue = channel.queue('hello')
channel.default_exchange.publish('Hello World!', routing_key: queue.name)

# si llego hasta aqui significa que funciono
puts " [x] Sent 'Hello World!'"

# la cola solo se crearaa si aun no existe - el contenido es una matriz de bytes, po que se puede codificar lo que se deseee
# cerramos la conexion
connection.close