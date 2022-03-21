# frozen_string_literal: true

module DfE
  module Analytics
    class SendEvents < ActiveJob::Base
      def self.do(events)
        if DfE::Analytics.async?
          perform_later(events)
        else
          perform_now(events)
        end
      end

      def perform(events)
        if DfE::Analytics.log_only?
          Rails.logger.info('DfE::Analytics: ' + events.inspect)
        else
          DfE::Analytics.events_client.insert(events)
        end
      end
    end
  end
end
