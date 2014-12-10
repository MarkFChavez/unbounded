class HomeController < ApplicationController
  def index
    @tags = []
    @tags = search_tag if has_hashtag?
  end

  private

  def client
    Instagram.client
  end

  def search_tag
    tags = client.tag_search search_params["hashtag"]
    client.tag_recent_media(tags[0].name) rescue []
  end

  def has_hashtag?
    search_params && search_params["hashtag"].present? rescue false
  end

  def search_params
    params.require(:search).
      permit(:hashtag)
  end
end
