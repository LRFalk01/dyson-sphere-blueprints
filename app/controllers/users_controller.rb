class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :blueprints ]

  def blueprints
    @user = User.find(params[:user_id])
    authorize @user

    @blueprints = @user.blueprints
      .joins(:collection)
      .where(collection: { type: "Public" })
      .includes(:collection)
      .page(params[:page])
      .order(cached_votes_total: :desc)
  end
end
