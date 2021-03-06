class ApplicationHelper::Toolbar::MiqAlertsCenter < ApplicationHelper::Toolbar::Basic
  button_group('miq_alert_vmdb', [
    select(
      :miq_alert_vmdb_choice,
      nil,
      t = N_('Configuration'),
      t,
      :items => [
        button(
          :miq_alert_new,
          'pficon pficon-add-circle-o fa-lg',
          t = N_('Add a New Alert'),
          t,
          :klass => ApplicationHelper::Button::ButtonNewDiscover),
      ]
    ),
  ])
end
