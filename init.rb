require File.join(File.dirname(__FILE__), 'lib', 'date_sensitive_partial')
ActionView::Base.send(:include, DateSensitivePartial)