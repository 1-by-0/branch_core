defmodule BranchCore.Accounts.Providers.Github do

  import BranchCore.Accounts.Providers.Request
  import BranchCore.Accounts.Providers.Helpers

  @client_id Application.compile_env(:branch_core, :github_client_id)
  @client_secret Application.compile_env(:branch_core, :github_client_secret)
  @urls %{
    "token_url" => "https://github.com/login/oauth/access_token",
    "redirect_url" => "/oauth/callbacks/github"
  }


  def authorize_url do
    state = random_string()
    scope = "user public_repo"

    "https://github.com/login/oauth/authorize?client_id=#{@client_id}&state=#{state}&scope=#{encode_param(scope)}"
  end

  def get_access_token(opts) do

    code = Keyword.fetch!(opts, :code)

    body = URI.encode_query(
      %{
        code: code,
        client_id: @client_id,
        client_secret: @client_secret,
        redirect_uri: "#{host()}#{@urls["redirect_url"]}"}
    )


    make_request(@urls["token_url"], :post, body) |> get_token_from_body()

  end

  def get_token_from_body({:error, reason}) do
    {:error, reason}
  end

  def get_token_from_body({:ok, %{"access_token" => token}}) do
    {:ok, token}
  end
end
