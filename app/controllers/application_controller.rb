class ApplicationController < ActionController::Base

  def not_found
    render 'pages/not_found', status: :not_found
  end

end
