
class ApplicationAPI < Grape::API
  # include APIGuard

  format :json

  helpers do

  end

  mount V1::Base

end