#See for the future:
# - http://drnicwilliams.com/2006/10/12/my-irbrc-for-consoleirb/
# - http://bjhess.com/blog/2007/11/27/irbrc-tweakage/
#   - http://quotedprintable.com/2007/9/13/my-irbrc
#   - http://pablotron.org/software/wirble/
# - http://giantrobots.thoughtbot.com/2008/12/23/script-console-tips
# - http://redhanded.hobix.com/inspect/stickItInYourIrbrcMethodfinder.html
# - http://snippets.dzone.com/posts/show/258
# - http://github.com/greatseth/dotfiles/tree/master

#awful patch for rails 3 :/
basedirs = ENV["GEM_PATH"].to_s.split(":").map{|d|"#{d}/gems/*/lib"}
Dir.glob(basedirs).each do |dir|
  $: << dir unless $:.include?(dir)
end

#require 'map_by_method'
#require 'what_methods'
%w(yaml pp open-uri rubygems irb/completion irb/ext/save-history ).each do |x|
  begin
    require x
  rescue LoadError => e
    puts "Unable to load #{x}"
    #e.inspect
  end
end

ARGV.concat %w( --readline )

module Kernel
  {
    :r => :require,
    :x => :exit
  }.each { |n,o| alias_method n, o }
end

IRB.conf.merge! \
  :PROMPT_MODE => :SIMPLE,
  :AUTO_INDENT => true,
  :SAVE_HISTORY => 100,
  :HISTORY_FILE => "#{ENV['HOME']}/.irb-save-history"

# BELOW: RAILS SPECIFIC

# Show queries in script/console
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  #Rails.logger = 
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# if Rails here, load all models
if defined?(Rails)
  Rails.application.eager_load!
end

#Hirb.enable rescue nil
