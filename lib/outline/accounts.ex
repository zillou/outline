defmodule Outline.Accounts do
  alias Outline.Repo

  alias Outline.Accounts.{User, UserFromAuth}
  alias Ueberauth.Auth

  @doc """
  Gets a single user by its id.
  Returns nil if the User does not exist.
  """
  def get_user(id), do: Repo.get(User, id)

  def upsert_user(auth) do
    attrs = UserFromAuth.build(auth)

    changeset =
      case get_user_by_auth(auth) do
        nil -> User.changeset(%User{}, attrs)
        user -> User.changeset(user, attrs)
      end

    Repo.insert_or_update(changeset)
  end

  def get_user_by_auth(%Auth{uid: uid, provider: provider}) when is_nil(uid) or is_nil(provider), do: nil
  def get_user_by_auth(%Auth{uid: uid, provider: provider}) do
    Repo.get_by(User, uid: "#{uid}", provider: "#{provider}")
  end
end
