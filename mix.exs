defmodule GoodTimes.Mixfile do
  use Mix.Project

  def project do
    [
      app: :good_times,
      version: "1.0.0",
      name: "GoodTimes",
      source_url: "https://github.com/DevL/good_times",
      elixir: "~> 1.0",
      deps: deps,
      description: description,
      package: package
    ]
  end

  defp description do
    """
    Expressive and easy to use datetime functions.
    """
  end

  defp package do
    [
      contributors: ["Lennart Fridén", "Martin Svalin"],
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/DevL/good_times"}
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      {:inch_ex, only: :docs}
    ]
  end
end
