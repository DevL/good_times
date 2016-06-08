defmodule GoodTimes.Mixfile do
  use Mix.Project

  def project do
    [
      app: :good_times,
      version: "1.2.0",
      name: "GoodTimes",
      source_url: "https://github.com/DevL/good_times",
      elixir: "~> 1.3.0-dev",
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
      maintainers: ["Lennart Fridén", "Martin Svalin"],
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
      {:earmark, "~> 0.2", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:inch_ex, ">= 0.5.0", only: :docs}
    ]
  end
end
