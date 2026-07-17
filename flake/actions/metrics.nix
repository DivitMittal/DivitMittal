_: {
  # Requires the repo secret METRICS_TOKEN to be set to a Personal Access
  # Token (classic) with scopes: public_repo, read:user, read:org. The
  # default ${{ secrets.GITHUB_TOKEN }} authenticates as github-actions[bot]
  # and is rejected by the GraphQL queries lowlighter/metrics issues
  # ("Bad credentials" 401). See: https://github.com/lowlighter/metrics#-using-the-github-action-on-githubcom
  flake.actions-nix.workflows.".github/workflows/metrics.yml" = {
    name = "Metrics";
    on = {
      schedule = [{cron = "0 * * * *";}]; # hourly
      workflow_dispatch = {};
    };
    jobs.metrics-job = {
      name = "Generates assets/github-metrics.svg";
      environment.name = "production";
      permissions.contents = "write";
      steps = [
        {
          uses = "lowlighter/metrics@latest";
          "with" = {
            token = "\${{ secrets.METRICS_TOKEN }}";

            user = "DivitMittal";
            filename = "assets/github-metrics.svg";
            template = "classic";

            base = "header, activity, community, repositories, metadata";
            base_hireable = "yes";
            base_indepth = "no";

            config_octicon = "yes";
            config_timezone = "Asia/Kolkata";
            config_twemoji = "yes";

            ## Habits
            plugin_habits = "no";
            plugin_habits_charts_type = "classic";
            plugin_habits_days = 14;
            plugin_habits_facts = "yes";
            plugin_habits_from = 200;
            plugin_habits_languages_limit = 8;
            plugin_habits_languages_threshold = "0%";

            ## Isocalendar
            plugin_isocalendar = "yes";
            plugin_isocalendar_duration = "half-year";

            ## Languages
            plugin_languages = "no";
            plugin_languages_analysis_timeout = 15;
            plugin_languages_analysis_timeout_repositories = 7.5;
            plugin_languages_categories = "markup, programming";
            plugin_languages_colors = "github";
            plugin_languages_limit = 20;
            plugin_languages_recent_categories = "markup, programming";
            plugin_languages_recent_days = 14;
            plugin_languages_recent_load = 300;
            plugin_languages_sections = "most-used";
            plugin_languages_threshold = "0%";

            ## Stargazers
            plugin_stargazers = "no";
            plugin_stargazers_charts = "no";
            plugin_stargazers_charts_type = "classic";
            plugin_stargazers_days = 14;

            plugin_traffic = "yes";
          };
        }
      ];
    };
  };
}
