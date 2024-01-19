defmodule DiscussWeb.AuthController do
     use DiscussWeb, :controller
     alias  Discuss.Schemas.User
     alias Discuss.Repo

     plug Ueberauth

     def callback(conn,_params) do

      %{assigns: %{ueberauth_auth: auth}} = conn

      user_params = %{token: auth.credentials.token, name: auth.info.name, email: "uchechidi9@gmail.com", provider: "github"  }
      struct = %User{}
      changeset = User.changeset(struct, user_params)

      signin(conn, changeset)

      conn
      |>  put_flash(:info, "Authentication suucessfully")
      |>  redirect(to: "/")

     end

     def logout(conn, _params) do
       assign(conn, :user, nil)
       conn
       |> put_flash(:info, "logged out successfully")
       |> redirect(to: "/")
     end

     defp signin(conn, changeset) do
      case insert_or_update_user(changeset) do
        {:ok, user} ->
          conn
            |> put_flash(:info, "Welcome back")
            |> put_session(:user_id, user.id)
            |> redirect(to: "/")
        {:error, _reason} ->
          conn
            |> put_flash(:error, "error just occured")
            |> redirect(to: "/")

      end
     end




     defp  insert_or_update_user(changeset) do
        case  Repo.get_by(User, email: changeset.changes.email) do
          nil ->
            Repo.insert(changeset)
          user ->
            {:ok, user}
        end
     end
end
