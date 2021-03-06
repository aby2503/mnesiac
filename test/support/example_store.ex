defmodule Mnesiac.Support.ExampleStore do
  @moduledoc false
  require Record
  use Mnesiac.Store

  Record.defrecord(
    :example,
    __MODULE__,
    id: nil,
    topic_id: nil,
    event: nil
  )

  @type example ::
          record(
            :example,
            id: String.t(),
            topic_id: String.t(),
            event: String.t()
          )

  @impl true
  def store_options,
    do: [
      attributes: example() |> example() |> Keyword.keys(),
      index: [:topic_id],
      disc_copies: [node()]
    ]

  @impl true
  def copy_store do
    :mnesia.add_table_copy(__MODULE__, node(), :disc_copies)
  end
end
