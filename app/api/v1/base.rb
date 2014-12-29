module V1
  class Base < ApplicationAPI
    version "v1", :using => :path

    post :forward_quote do
      data = {
        :name => params[:name],
        :email => params[:email],
        :subject => params[:subject],
        :message => params[:message]
      }
      AppMailer.delay.send_quote(data).deliver
      return data
    end
  end
end
