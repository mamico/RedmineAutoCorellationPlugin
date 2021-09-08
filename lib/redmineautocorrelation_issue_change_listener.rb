class RedmineAutoCorrelationIssueChangeListener < Redmine::Hook::Listener
    def controller_issues_bulk_edit_after_save(context={})
      controller_issues_edit_after_save(context)
    end
    def controller_issues_new_after_save(context={})
      controller_issues_edit_after_save(context)
    end
    def controller_issues_edit_after_save(context={})
      if context[:issue]
        AutoCorrelation.issue_update(User.current, context[:issue], context[:journal])
      end
    end
  end