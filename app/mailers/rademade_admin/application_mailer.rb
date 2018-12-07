module RademadeAdmin

  class ApplicationMailer < ActionMailer::Base
    default from: RademadeAdmin.configuration.mail_from || 'admin@example.com'
    layout 'mailer'
  end

end
