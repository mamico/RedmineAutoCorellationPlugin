Rails.logger.info 'Starting Auto Correlation plugin...'

require_dependency 'redmineautocorrelation_issue_change_listener'

Redmine::Plugin.register :auto_correlation do
  name 'Auto Correlation plugin'
  author 'Mauro Amico'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/mamico/RedmineAutoCorellationPlugin'
  author_url 'https://github.com/mamico'
end
