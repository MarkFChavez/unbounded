class HomeController < ApplicationController
  def index
    @tags = []
    @tags = search_tag if has_hashtag?
  end

  private

  def search_tag
    client = Instagram.client

    tags = client.tag_search search_params["hashtag"]
    client.tag_recent_media tags[0].name
  end

  def has_hashtag?
    search_params && search_params["hashtag"].present? rescue false
  end

  def search_params
    params.require(:search).
      permit(:hashtag)
  end
end
