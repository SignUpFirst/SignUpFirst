# coding: utf-8
class UsersController < ApplicationController
  after_filter :verify_authorized, except: %i[uservoice_gadget reactivate]
  skip_before_filter :force_http, only: [:update_password]
  inherit_resources
  defaults finder: :find_active!
  actions :show, :update, :update_password, :unsubscribe_notifications, :uservoice_gadget, :credits, :destroy
  respond_to :json, only: [:contributions, :projects]

  def destroy
    authorize resource
    resource.deactivate
    sign_out(current_user) if current_user == resource
    flash[:notice] = t('users.current_user_fields.deactivate_notice', name: resource.name)
    redirect_to root_path
  end

  def unsubscribe_notifications
    authorize resource
    redirect_to user_path(current_user, anchor: 'unsubscribes')
  end

  def credits
    authorize resource
    redirect_to user_path(current_user, anchor: 'credits')
  end

  def uservoice_gadget
    if params[:secret] == CatarseSettings[:uservoice_secret_gadget]
      @user = User.find_by_email params[:email]
    end

    render :uservoice_gadget, layout: false
  end

  def show
    authorize resource
    show!{
      fb_admins_add(@user.facebook_id) if @user.facebook_id
      @title = "#{@user.display_name}"
      @credits = @user.contributions.can_refund
      @subscribed_to_posts = @user.posts_subscription
      @unsubscribes = @user.project_unsubscribes
    }
  end

  def reactivate
    user = User.find_by(reactivate_token: params[:token])
    if user
      user.reactivate
      sign_in user
      flash[:notice] = t('users.reactivated')
    else
      flash[:error] = t('users.failed_reactivation')
    end
    redirect_to root_path
  end

  def update
    authorize resource
    update! do |success,failure|
      success.html do
        flash[:notice] = t('users.current_user_fields.updated')
      end
      failure.html do
        flash[:error] = @user.errors.full_messages.to_sentence
      end
    end
    return redirect_to user_path(@user, anchor: 'settings')
  end

  def update_password
    authorize resource
    if @user.update_with_password(params[:user])
      flash[:notice] = t('users.current_user_fields.updated')
    else
      flash[:error] = @user.errors.full_messages.to_sentence
    end
    return redirect_to user_path(@user, anchor: 'settings')
  end
end
