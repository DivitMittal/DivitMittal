_: {
  # Managed by forge-tofu: DivitMittal/profile-readme/PROFILE_README_TOKEN
  # comes from infra-nixCfg-secrets/secrets/forge/github/profile_readme.age.
  # Metrics needs a user PAT for account queries and repository traffic;
  # use GITHUB_TOKEN separately for committing the generated image.
  flake.actions-nix.workflows.".github/workflows/metrics.yml" = {
    name = "Metrics";
    on = {
      schedule = [{cron = "0 * * * *";}]; # hourly
      workflow_dispatch = {};
    };
    jobs.metrics-job = {
      name = "Generates assets/github-metrics.svg";
      environment.name = "profile-readme";
      permissions.contents = "write";
      steps = [
        {
          uses = "lowlighter/metrics@latest";
          "with" = {
            token = "\${{ secrets.PROFILE_README_TOKEN }}";
            committer_token = "\${{ secrets.GITHUB_TOKEN }}";

            user = "DivitMittal";
            filename = "assets/github-metrics.svg";
            template = "classic";

            base = "header, activity, community, repositories, metadata";
            base_hireable = "yes";
            base_indepth = "no";

            # Keep the generated card focused on metrics rather than attribution.
            extras_css = ''
              .calendar.field, .items-wrapper > section:last-of-type { display: none !important; }
              footer { display: none !important; }
              /* The classic template uses the same heart icon for Sponsors and Sponsoring. */
              .field:has(> svg > path[d^="M4.25 2.5c-1.336 0-2.75 1.164-2.75 3"]) { display: none !important; }
            '';

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

            ## Achievements
            plugin_achievements = "yes";
            plugin_achievements_threshold = "B";

            ## Follow-up
            plugin_followup = "yes";
            plugin_followup_sections = "repositories, user";

            ## Isocalendar
            plugin_isocalendar = "no";
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

            ## Lines changed
            plugin_lines = "yes";
            plugin_lines_delay = 30;
            plugin_lines_sections = "base";

            ## Notable contributions
            plugin_notable = "yes";
            plugin_notable_from = "all";
            plugin_notable_types = "commit, pull_request";

            ## Stargazers
            plugin_stargazers = "no";
            plugin_stargazers_charts = "no";
            plugin_stargazers_charts_type = "classic";
            plugin_stargazers_days = 14;

            ## Starred topics
            plugin_topics = "yes";
            plugin_topics_limit = 8;
            plugin_topics_mode = "icons";
            plugin_topics_sort = "activity";

            plugin_traffic = "yes";
          };
        }
      ];
    };
  };
}
