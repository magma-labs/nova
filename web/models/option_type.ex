defmodule Nova.OptionType do
  @moduledoc """
  Represents an option type to be associated to a `Nova.Product`.
  """
  use Nova.Web, :model

  schema "nova_option_types" do
    has_many :option_values, Nova.OptionValue, on_delete: :delete_all
    has_many :option_type_products,
      Nova.OptionTypeProduct,
      on_delete: :delete_all
    has_many :products, through: [:option_type_products, :products]

    field :name, :string
    field :display_name, :string

    timestamps
  end

  @required_fields ~w(name display_name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:name, min: 3, max: 200)
    |> unique_constraint(:name)
    |> validate_length(:display_name, min: 3, max: 200)
  end
end
