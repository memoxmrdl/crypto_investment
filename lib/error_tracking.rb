# frozen_string_literal: true

class ErrorTracking
  def initialize(exception:)
    @exception = exception
  end

  def self.exception(exception)
    new(exception:).logging_and_reports
  end

  def logging_and_reports
    log_error
    # report_to_sentry
    # report_to_rollbar
  end

  private

  def log_error
    Rails.logger.error("#{@exception}")
  end

  # https://docs.sentry.io/platforms/ruby/
  # def report_to_sentry
  #   Sentry.capture_exception(e)
  # end

  # https://docs.rollbar.com/docs/ruby
  # def report_to_rollbar
  #   Rollbar.error(e)
  # end
end
