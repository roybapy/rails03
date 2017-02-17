Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'dj.log'))
ActiveRecord::Base.logger.level = 1
