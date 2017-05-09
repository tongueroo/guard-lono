require "guard/compat/plugin"
require "colorize"

module Guard
  class Lono < Plugin

    # Initialize a Guard.
    # @param [Hash] options the custom Guard options
    def initialize(options = {})
      @options = {
        :all_on_start => true,
        :notification => true,
      }.merge(options)
      super(@options)
    end

    # Call once when Guard starts. Please override initialize method to init stuff.
    # @raise [:task_has_failed] when start has failed
    def start
      run_all if @options[:all_on_start]
    end

    # Called when just `enter` is pressed
    # This method should be principally used for long action like running all specs/tests/...
    # @raise [:task_has_failed] when run_all has failed
    def run_all
      run!
    end

    # Called on file(s) modifications that the Guard watches.
    # @param [Array<String>] paths the changes files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_change(paths)
      run!
    end

    private

    def run!
      throw :task_has_failed unless command
    end

    def command
      system("lono generate")
    end
  end
end
