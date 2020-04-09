# frozen_string_literal: true

module Banana::Logging
  COLORS = {
      info: "\e[34m", # blue
      warn: "\e[33m", # yellow
      error: "\e[31m" # red
  }.freeze

  def log(level, msg)
    TPMReporter.config.output.puts(build_log_msg(level, msg))
  end

  def build_log_msg(level, msg)
    colorize(level, "[TPMReporter #{level.to_s.upcase}] #{msg}")
  end

  def colorize(level, msg)
    return msg unless TPMReporter.config.color?

    "#{COLORS[level]}#{msg}\e[0m"
  end
end