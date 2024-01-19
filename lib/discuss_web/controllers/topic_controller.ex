defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Schemas.Topic
  alias Discuss.Repo

  def new(conn, _params) do
    struct = %Topic{}
    params = %{}
    changeset = Topic.changeset(struct, params)
    render(conn, :topic, changeset: changeset)
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render(conn, :edit, changeset: changeset, topic_id: topic_id)
  end

  def update(conn, %{"id" => topic_id,  "topic" => topic}) do
    old_topic = Repo.get(Topic,topic_id)
    changeset = Topic.changeset(old_topic, topic)

    # changeset = Repo.get(Topic, topic_id) |> Topic.changeset(topic)
    
    case Repo.update(changeset ) do
      {:ok,_topic} ->
        conn
         |> put_flash(:info, "Topic Updated Successfully")
         |> redirect(to: "/")
      {:error, changeset} ->

        render(conn , :edit, changeset: changeset, topic: old_topic, topic_id: topic_id)


    end

  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: "/")

      # render(conn, :topic, changeset: changeset)
      {:error, changeset} ->
        render(conn, :topic, changeset: changeset)
    end
  end

  def delete(conn, %{"topic_id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic deleted Successfully")
     |> redirect(to: "/")

  end

end
