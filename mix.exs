defmodule GoodTimes.Mixfile do
  use Mix.Project

  def project do
    [
      app: :good_times,
      version: "1.1.2",
      name: "GoodTimes",
      source_url: "https://github.com/DevL/good_times",
      elixir: "~> 1.0",
      deps: deps(),
      preferred_cli_env: [coveralls: :test, "coveralls.html": :test, "test.watch": :test],
      test_coverage: [tool: ExCoveralls],
      description: description(),
      package: package()
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
      {:earmark, "~> 1.3", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev},
      {:inch_ex, "~> 2.0", only: :docs},
      {:excoveralls, "~> 0.10", only: :test},
      {:mix_test_watch, "~> 0.9", only: :test}
    ]
  end
end
