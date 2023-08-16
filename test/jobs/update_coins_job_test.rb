require "test_helper"

class UpdateCoinsJobTest < ActiveJob::TestCase
  def setup
    @subject = UpdateCoinsJob
  end

  def test_it_enqueued
    assert_enqueued_jobs 1 do
      @subject.perform_later
    end
  end
end
