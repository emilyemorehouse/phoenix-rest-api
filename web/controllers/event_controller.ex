defmodule RestApi.EventController do
  use RestApi.Web, :controller

  def index(conn, _params) do
    events = Repo.all(RestApi.Event)
    json conn_with_status(conn, events), events
  end

  def event(conn, %{"id" => id}) do
    event = Repo.get(RestApi.Event, String.to_integer(id))

    json conn_with_status(conn, event), event
  end

  # Helpers - error handling
  defp conn_with_status(conn, nil) do
    conn
      |> put_status(:not_found)
  end

  defp conn_with_status(conn, _) do
    conn
      |> put_status(:ok)
  end

end
