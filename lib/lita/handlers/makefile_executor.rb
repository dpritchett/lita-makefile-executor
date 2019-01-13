# START:header
module Lita
  module Handlers
    class MakefileExecutor < Handler
      config :shipit_command, default: 'make -C ./examples deploy'
      # END:header

      # START:routeit
      route /^(shipit|ship it)/i, :shipit_handler, command: true

      def shipit_handler(message)
	appname = message.matches.last
	result = ship_app
	message.reply result
      end
      # END:routeit

      # START:execute
      def ship_app
	`#{config.shipit_command}`
      end
      # END:execute

      Lita.register_handler(self)
    end
  end
end
