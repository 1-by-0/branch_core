defmodule BranchCore.Accounts.Providers.Request do
  def make_request(url, method, opts) do
    build_request_for_method(url, method, opts)
    |> Finch.request(BranchCore.Finch)
    |> process_response()
  end

  def build_request_for_method(url, :get, opts), do: get(url, opts)
  def build_request_for_method(url, :post, opts), do: post(url, opts)

  def post(url, opts) do
    Finch.build(:post, url, headers(opts), body(opts))
  end

  def get(url, opts) do
    Finch.build(:get, url, headers(opts))
  end

  defp process_response({:ok, %Finch.Response{status: 200, body: body}}) do
    decode_body(body)
  end

  defp process_response(response) do
    IO.inspect(response)
    {:error, "Something went wrong, please try again later"}
  end

  def body(opts) do
    Keyword.fetch!(opts, :body)
  end

  def headers(opts) do
    case Keyword.fetch(opts, :token) do
      :error -> default_headers()
      {:ok, token} -> [{"Authorization", "Bearer #{token}"}]
    end
  end

  defp decode_body(body), do: Jason.decode(body, keys: :atoms)

  defp default_headers, do: [{"accept", "application/json"}]
end
