#See for the future:
# - http://drnicwilliams.com/2006/10/12/my-irbrc-for-consoleirb/
# - http://bjhess.com/blog/2007/11/27/irbrc-tweakage/
#   - http://quotedprintable.com/2007/9/13/my-irbrc
#   - http://pablotron.org/software/wirble/
# - http://giantrobots.thoughtbot.com/2008/12/23/script-console-tips
# - http://redhanded.hobix.com/inspect/stickItInYourIrbrcMethodfinder.html
# - http://snippets.dzone.com/posts/show/258
# - http://github.com/greatseth/dotfiles/tree/master

#require 'map_by_method'
#require 'what_methods'
%w(pp open-uri rubygems hpricot wirble irb/completion irb/ext/save-history ).each do |x|
  begin
    require x
  rescue LoadError => e
    puts e.inspect
  end
end
 
ARGV.concat %w( --readline )
 
Wirble.init
Wirble.colorize
 
module Kernel
  { :h => :Hpricot,
    :r => :require,
    :x => :exit
  }.each { |n,o| alias_method n, o }
end
 
IRB.conf.merge! \
  :PROMPT_MODE => :SIMPLE,
  :AUTO_INDENT => true,
  :SAVE_HISTORY => 100,
  :HISTORY_FILE => "#{ENV['HOME']}/.irb-save-history"
