require "test_helper"

class SyncCryptocurrenciesToCoinsJobTest < ActiveJob::TestCase
  def setup
    @subject = SyncCryptocurrenciesToCoinsJob
  end

  def test_it_enqueued
    assert_enqueued_jobs 1 do
      @subject.perform_later
    end
  end
end
