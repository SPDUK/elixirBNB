defmodule ElixirbnbWeb.UserController do
  use ElixirbnbWeb, :controller

  # plug Coherence.Authentication.Session, [protected: true] when action != :show

  def show(conn, %{"id" => id}) do
    assign(conn, :user, Coherence.Schemas.get_user!(id))
    |> render("index.html")
  end
end
