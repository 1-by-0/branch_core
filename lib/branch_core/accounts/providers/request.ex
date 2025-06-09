defmodule BranchCore.Accounts.Providers.Request do
  def make_request(url, method, body) do
    Finch.build(method, url, headers(), body)
    |> Finch.request(BranchCore.Finch)
    |> process_response()
  end

  defp process_response({:ok, %Finch.Response{status: 200, body: body}}) do
    decode_body(body)
  end

  defp process_response(_response) do
    {:error, "Something went wrong, please try again later"}
  end

  defp decode_body(body), do: Jason.decode(body)

  defp headers, do: [{"accept", "application/json"}]
end
