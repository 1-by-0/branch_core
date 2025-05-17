defmodule BranchCore.Synchronizers.SkillSynchronizer do
  alias BranchCore.KnowledgeBase

  @url "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml"

  def sync_skills do
    case Finch.build(:get, @url) |> Finch.request(BranchCore.Finch) do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        process_yaml_response(body)
      _ ->
        IO.inspect("Failed to get lingustics, please check connection related issues")
    end
  end

  defp process_yaml_response(body) do
    case Yamel.decode(body) do
      {:ok, language_map} ->
       language_map
       |> Task.async_stream(fn {skill_name, details} ->
        KnowledgeBase.create_skill_if_not_found(%{
          "name" => skill_name,
          "type" => details["type"],
          "color" => details["color"]
        })
       end)
       |> Stream.run()

       {:ok, "Inserted Entries"}

      _ ->
        {:error, "Failed to Insert Entries, Please check the YAML structure"}
    end
  end
end
