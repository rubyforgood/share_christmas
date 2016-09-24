class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@todo.com'
  layout 'mailer'
end
