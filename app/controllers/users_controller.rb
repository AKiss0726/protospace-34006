class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #@name = user.name
    @prototype = Prototype.find(params[:id])
    @prototypes = @user.prototypes
  end
end
