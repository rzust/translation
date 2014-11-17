class AppMailer < ActionMailer::Base
  layout 'mail'
  default from: "ESOTEC <info@esotecsolutions.com>"

  def send_quote(data)
    # attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @data = data
    mail(to: 'info@esotecsolutions.com', subject: data[:subject])
  end
end