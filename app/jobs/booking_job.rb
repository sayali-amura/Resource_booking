class BookingJob < ActiveJob::Base
  # include Sidekiq::Worker
  queue_as :high_priority
  # BookingJob.perform_later(60.seconds.from_now)
  def perform(booking)
    availble_booking_conflicts	= booking.send(:check_bookings_in_duration)
    # byebug
    if availble_booking_conflicts.length > 1
    	
    	top_booking = prioritize_booking(availble_booking_conflicts).first
    	top_booking.update(status: 1)
    	# byebug

    elsif availble_booking_conflicts.length == 1
    	availble_booking_conflicts.first.update(status: 1)
    end
  end

  def prioritize_booking booking_array
  	booking_array.sort_by{|x| x.employee.role.priority}
  end

end
