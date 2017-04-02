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

  def create(conn, _params) do
    changeset = RestApi.Event.changeset(%RestApi.Event{}, _params)
      case Repo.insert(changeset) do
        {:ok, event} ->
          json conn |> put_status(:created), event
        {:error, _changeset} ->
          json conn |> put_status(:bad_request), %{errors: ["unable to create event"] }
      end
  end

  def update(conn, %{"id" => id} = _params) do
    event = Repo.get(RestApi.Event, id)
    if event do
      perform_update(conn, event, _params)
    else
      json conn |> put_status(:not_found), %{errors: ["invalid event"]}
    end
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

  defp perform_update(conn, event, _params) do
    changeset = RestApi.Event.changeset(event, _params)
    case Repo.update(changeset) do
      {:ok, event} ->
        json conn |> put_status(:ok), event
      {:error, _result} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to update event"]}
    end
  end


end
