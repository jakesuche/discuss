defmodule DiscussWeb.PageController do
  use DiscussWeb, :controller

  alias Discuss.Repo
  alias Discuss.Schemas.Topic
  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.

     topics = Repo.all(Topic)
    IO.inspect(conn.assigns)

    render(conn, :home,  topics: topics)
    #  render(conn, :home, layout: false)
  end



end
