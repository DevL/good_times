defmodule GoodTimes.Mixfile do
  use Mix.Project

  def project do
    [
      app: :good_times,
      version: "0.2.0",
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
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      {:inch_ex, only: :docs}
    ]
  end
end
