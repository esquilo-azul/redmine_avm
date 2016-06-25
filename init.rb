# coding: utf-8

require 'redmine'

require 'avm/patches/issue_patch'

Redmine::Plugin.register :avm do
  name 'Agora Vai! Methodology'
  author 'Eduardo Henrique Bogoni'
  description ''
  version '0.1.0'

  settings(default: { dependencies_section_title: 'Dependencies',
                      no_dependencies_section_message: <<EOS,
Dependencies section not found.
Customize this message in plugin AVM's configuration.
EOS
                      dependencies_section_missing_dependencies_message: <<EOS
Missing dependencies found dependencies section: %{ids}.
Customize this message in plugin AVM's configuration.
EOS
    }, partial: 'settings/avm')

  Redmine::MenuManager.map :admin_menu do |menu|
    menu.push :issue_status_assigns, { controller: 'issue_status_assigns', action: 'index' },
              caption: :label_issue_status_assigns
  end
end

Rails.configuration.to_prepare do
  EacBase::EventManager.add_listener(Issue, :create, 'Avm::Listeners::IssueAutoUndefine')
  EacBase::EventManager.add_listener(Issue, :update, 'Avm::Listeners::IssueAutoUndefine')
  EacBase::EventManager.add_listener(IssueRelation, :create, 'Avm::Listeners::IssueAutoUndefine')
  EacBase::EventManager.add_listener(IssueRelation, :delete, 'Avm::Listeners::IssueAutoUnblock')
  EacBase::EventManager.add_listener(Issue, :delete, 'Avm::Listeners::IssueAutoUnblock')
  EacBase::EventManager.add_listener(Issue, :update, 'Avm::Listeners::IssueAutoUnblock')
  EacBase::EventManager.add_listener(Issue, :create, 'Avm::Listeners::IssueAutoAssign')
  EacBase::EventManager.add_listener(Issue, :update, 'Avm::Listeners::IssueAutoAssign')
end
