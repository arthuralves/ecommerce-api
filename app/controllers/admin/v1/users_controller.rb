module Admin::V1
  class UsersController < ApiController
    def index
      @users = User.all
    end
  end
end
