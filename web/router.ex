defmodule RestApi.Router do
  use RestApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", RestApi do
  #   pipe_through :browser # Use the default browser stack

  #   get "/", PageController, :index
  # end

  scope "/api/v1", RestApi do
    pipe_through :api

    get "/events", EventController, :index
    get "/events/:id", EventController, :event
  end
end
