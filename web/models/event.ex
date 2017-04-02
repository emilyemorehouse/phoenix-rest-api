defmodule RestApi.Event do
  use RestApi.Web, :model
  schema "events" do
    field :title
    field :description

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
      |> cast(params, [:title, :description])
      |> unique_constraint(:title)
  end
end
