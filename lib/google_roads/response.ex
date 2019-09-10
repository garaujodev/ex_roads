defmodule GoogleRoads.Response do
  @moduledoc false

  @type t :: {:ok, map()} | {:error, error()}

  @type status :: String.t

  @type error :: HTTPoison.Error.t | status()

  def wrap({:ok, %{body: %{"error" => %{"status" => status, "message" => error_message}}}}), do: {:error, status, error_message}
  def wrap({:ok, %{body: body} = response}) when is_binary(body) do
    wrap({:ok, %{response | body: Jason.decode!(body)}})
  end
  def wrap({:ok, %{body: body}}), do: {:ok, body}
  def wrap({:ok, %{id: id}}), do: {:ok, id}
  def wrap({:error, %{reason: reason}}), do: {:error, reason}
end
