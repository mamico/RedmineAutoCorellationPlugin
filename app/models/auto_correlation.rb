require 'rubygems'

class AutoCorrelation < ActiveRecord::Base
    def self.issue_update(user, issue, journal)
        changes = []
        if journal
            journal.details.each do |j|
                if j.prop_key == 'description'
                    j.value.scan(/#(\d+)/m).each do |t|
                        add_related(issue, t[0].to_i)
                    end
                end
            end
            journal.notes.scan(/#(\d+)/m).each do |t|
                add_related(issue, t[0].to_i)
            end
        else
            issue.description.scan(/#(\d+)/m).each do |t|
                add_related(issue, t[0].to_i)
            end
        end
    end
private
    def self.add_related(issue, issue_to_id)
        saved = false
        @relation = IssueRelation.new
        @relation.issue_from = issue
        @relation.safe_attributes = {"issue_to_id" => issue_to_id}
        @relation.init_journals(User.current)
        begin
            saved = @relation.save
        rescue ActiveRecord::RecordNotUnique
            @relation.errors.add :base, :taken
        end
    end
end