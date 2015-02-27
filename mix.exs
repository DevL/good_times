defmodule GoodTimes.Mixfile do
  use Mix.Project

  def project do
    [
      app: :good_times,
      version: "0.1.0",
      elixir: "~> 1.0",
      deps: deps,
      description: description,
      package: package
    ]
  end

  defp description do
    """
    Easy to use time functions.
    """
  end

  defp package do
    [
      contributors: ["Lennart Fridén", "Martin Svalin"],
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/magplus/good_times"}
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    []
  end
end
