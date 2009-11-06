module DateSensitivePartial

  # Relate a specific partial name to a range of dates when it should be active
  class DateRangePartial < Object
    attr_accessor :start_date, :end_date, :partial_name

    def initialize(start_date, end_date, partial_name)
      self.start_date   = start_date
      self.end_date     = end_date
      self.partial_name = partial_name
    end
    
    def active?(current_time = nil)
      now = current_time.nil? ? DateTime.now : current_time
      now.between?(start_date, end_date)
    end
    
  end
  
  # Groupings is a hash
  #   the keys represent a unique name for a collection of partails
  #   the values are arrays of DateSensitivePartial::DateRangePartial objects
  GROUPINGS = Hash.new
  
  # helper method which returns the string of a partial name to render
  # based on the partial grouping name and the date context if specified
  def date_sensitive_partial(partial_grouping_name, date_context = nil)
    unless GROUPINGS.empty?
      if group = GROUPINGS[partial_grouping_name]
        group.each do |date_range_partial|
          return date_range_partial.partial_name if date_range_partial.active?(date_context)
        end
      end
    end
  end
  
end
