class AppMailer < ActionMailer::Base
  layout 'mail'
  default from: "Barnacle Translations <info@barnacletranslations.com>"

  def send_quote(data)
    # attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @data = data
    mail(to: 'info@barnacletranslations.com', subject: data[:subject])
  end
end