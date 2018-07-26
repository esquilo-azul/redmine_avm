default_value = {
  dependencies_section_title: 'Dependencies',
  no_dependencies_section_message: <<EOS.strip_heredoc,
                                                   Dependencies section not found.
                                                   Customize this message in plugin AVM's configuration.
EOS
  dependencies_section_missing_dependencies_message: <<EOS.strip_heredoc,
                                                   Missing dependencies found dependencies section: %{ids}.
                                                   Customize this message in plugin AVM's configuration.
EOS
  motivation_section_title: 'Motivation',
  unmotivated_message: 'This issue is not motivated.'
}

default_admin = ::User.where(id: 1, admin: true).first
default_value[:admin_user_id] = default_admin.id if default_admin

::RedminePluginsHelper::Settings.default(:redmine_avm, default_value)
