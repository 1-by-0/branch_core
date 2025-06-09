defmodule BranchCore.Accounts.Providers.Helpers do
  def random_string do
    binary = <<
      System.system_time(:nanosecond)::64,
      :erlang.phash2({node(), self()})::16,
      :erlang.unique_integer()::16
    >>

    binary
    |> Base.url_encode64()
    |> String.replace(["/", "+"], "-")
  end

  def encode_query(params), do: URI.encode_query(params)

  def encode_param(param), do: URI.encode(param)

  def host, do: BranchCoreWeb.Endpoint.url()
end
