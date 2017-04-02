defmodule RestApi.Event do
  use RestApi.Web, :model
  schema "events" do
    field :title
    field :description

    timestamps
  end
end
