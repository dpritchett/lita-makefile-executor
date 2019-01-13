# START:header
module Lita
  module Handlers
    class MakefileExecutor < Handler
      config :shipit_command, default: 'deploy'
      config :shipit_makefile_path, default: './examples'
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
	`make -C #{config.shipit_makefile_path} #{config.shipit_command}`
      end
      # END:execute

      Lita.register_handler(self)
    end
  end
end
