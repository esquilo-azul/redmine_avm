# coding: utf-8

require 'redmine'

require 'avm/patches/issue_patch'

Redmine::Plugin.register :avm do
  name 'Agora Vai! Methodology'
  author 'Eduardo Henrique Bogoni'
  description ''
  version '0.1.0'

  settings(default: {}, partial: 'settings/avm')
end

Rails.configuration.to_prepare do
  EacBase::EventManager.add_listener(Issue, :create, 'Avm::Listeners::IssueAutoUndefine')
end
