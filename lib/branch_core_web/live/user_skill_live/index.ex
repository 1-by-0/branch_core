defmodule BranchCoreWeb.UserSkillLive.Index do
  use BranchCoreWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(skills: [])}
  end

end
