defmodule Outline.Accounts.UserFromAuth do
  alias Ueberauth.Auth

  def build(%Auth{} = auth) do
    %{
      uid: "#{auth.uid}",
      provider: "#{auth.provider}",
      name: name_from_auth(auth),
      username: username_from_auth(auth),
      email: email_from_auth(auth),
      avartar_url: avartar_url_from_auth(auth),
    }
  end

  defp name_from_auth(%Auth{info: %{name: name}}) when name != nil, do: name
  defp name_from_auth(%Auth{info: info}) do
    [info.first_name, info.last_name]
    |> Enum.filter(&(&1 != nil and &1 != ""))
    |> Enum.join(" ")
  end

  defp username_from_auth(%Auth{info: %{nickname: nickname}}), do: nickname
  defp username_from_auth(%Auth{}), do: ""

  defp avartar_url_from_auth(%Auth{info: %{urls: %{avatar_url: url}}}), do: url
  defp avartar_url_from_auth(%Auth{}), do: ""

  defp email_from_auth(%Auth{info: %{email: email}}), do: email
  defp email_from_auth(%Auth{}), do: ""
end
