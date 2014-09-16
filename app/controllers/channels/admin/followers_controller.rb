class Channels::Admin::FollowersController < Channels::Admin::BaseController
  actions :index

  before_filter do
  	p "inside befor filter"
  	p request.subdomain.to_s
    @channel = Channel.find_by_permalink(request.subdomain.to_s)
    p "after running before filter"
  end

  def index
  	if @channel
    @total_subscribers = @channel.subscribers.count(:all)
    @subscribers = @channel.subscribers.page(params[:page])    
    end
  end
end
