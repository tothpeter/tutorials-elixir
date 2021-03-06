defmodule MyTweet.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: MyTweet.Worker.start_link(arg1, arg2, arg3)
      worker(MyTweet.TweetServer, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyTweet.Supervisor]
    main_pid = Supervisor.start_link(children, opts)
    file_path = Path.join(:code.priv_dir(:my_tweet), "sample.txt")
    MyTweet.Scheduler.schedule_file("* * * * *", file_path)

    main_pid
  end
end
