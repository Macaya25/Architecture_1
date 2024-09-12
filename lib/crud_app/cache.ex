defmodule CrudApp.Cache do

  def start_link(_) do
    Cachex.start_link(:cache, [])
  end

  def get(key) do
    case Cachex.get(:cache, key) do
      {:ok, value} when not is_nil(value) -> {:ok, value}
      _ -> :not_found
    end
  end

  def set(key, value) do
    Cachex.put(:cache, key, value)
  end

  def delete(key) do
    Cachex.del(:cache, key)
  end
end
