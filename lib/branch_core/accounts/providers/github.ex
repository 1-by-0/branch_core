defmodule BranchCore.Accounts.Providers.Github do
  import BranchCore.Accounts.Providers.Request
  import BranchCore.Accounts.Providers.Helpers

  @client_id Application.compile_env(:branch_core, :github_client_id)
  @client_secret Application.compile_env(:branch_core, :github_client_secret)
  @urls %{
    "token_url" => "https://github.com/login/oauth/access_token",
    "redirect_url" => "/oauth/callbacks/github",
    "repos" => "https://api.github.com/user/repos?visibility=public"
  }

  def authorize_url do
    state = random_string()
    scope = "user public_repo"

    "https://github.com/login/oauth/authorize?client_id=#{@client_id}&state=#{state}&scope=#{encode_param(scope)}"
  end

  def get_access_token(opts) do
    code = Keyword.fetch!(opts, :code)

    body =
      URI.encode_query(%{
        code: code,
        client_id: @client_id,
        client_secret: @client_secret,
        redirect_uri: "#{host()}#{@urls["redirect_url"]}"
      })

    make_request(@urls["token_url"], :post, body: body) |> process_returned_value()
  end

  def repos(token) do
    make_request(@urls["repos"], :get, token: token) |> process_returned_value
  end

  def process_returned_value({:error, reason}), do: {:error, reason}
  def process_returned_value({:ok, %{access_token: token}}), do: {:ok, token}
  def process_returned_value({:ok, value}), do: {:ok, value}
end
