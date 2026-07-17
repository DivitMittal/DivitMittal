_: {
  flake.actions-nix.workflows.".github/workflows/stats-cards.yml" = {
    name = "Stats Cards";
    on = {
      schedule = [{cron = "30 * * * *";}]; # hourly, offset 30m from metrics
      push.branches = ["master"];
      pull_request.branches = ["master"];
      workflow_dispatch = {};
    };
    jobs.stats-cards-job = {
      name = "Generates stats cards";
      environment.name = "production";
      permissions.contents = "write";
      steps = [
        {
          name = "Checkout repo";
          uses = "actions/checkout@v4";
        }
        {
          name = "Generate top languages card";
          # `stats-organization/github-readme-stats-action@v2` is the
          # maintained successor to `readme-tools/github-readme-stats-action`
          # (which depended on the now-deprecated
          # `anuraghazra/github-readme-stats`). It renders cards via
          # `stats-organization/github-stats-extended`. The query-string
          # options format is preserved, so the options below are unchanged.
          uses = "stats-organization/github-readme-stats-action@v2";
          "with" = {
            card = "top-langs";
            options = "username=\${{ github.repository_owner }}&langs_count=14&theme=transparent&hide_progress=true&show_icons=true&hide_border=true";
            path = "assets/top-langs.svg";
            token = "\${{ secrets.GITHUB_TOKEN }}";
          };
        }
        # Pinned-repo cards. Each step renders a single repo's stats card
        # (forks omitted — these showcase original work only).
        {
          name = "Generate pin: OS-nixCfg";
          uses = "stats-organization/github-readme-stats-action@v2";
          "with" = {
            card = "pin";
            options = "username=\${{ github.repository_owner }}&repo=OS-nixCfg&title_color=58A6FF&text_color=8B949E&icon_color=79C0FF&bg_color=0D1117&border_color=30363D&border_radius=6&hide_border=false&show_owner=false&show_icons=true";
            path = "assets/pins/pin-OS-nixCfg.svg";
            token = "\${{ secrets.GITHUB_TOKEN }}";
          };
        }
        {
          name = "Generate pin: ai-nixCfg";
          uses = "stats-organization/github-readme-stats-action@v2";
          "with" = {
            card = "pin";
            options = "username=\${{ github.repository_owner }}&repo=ai-nixCfg&title_color=58A6FF&text_color=8B949E&icon_color=79C0FF&bg_color=0D1117&border_color=30363D&border_radius=6&hide_border=false&show_owner=false&show_icons=true";
            path = "assets/pins/pin-ai-nixCfg.svg";
            token = "\${{ secrets.GITHUB_TOKEN }}";
          };
        }
        {
          name = "Generate pin: TLTR";
          uses = "stats-organization/github-readme-stats-action@v2";
          "with" = {
            card = "pin";
            options = "username=\${{ github.repository_owner }}&repo=TLTR&title_color=58A6FF&text_color=8B949E&icon_color=79C0FF&bg_color=0D1117&border_color=30363D&border_radius=6&hide_border=false&show_owner=false&show_icons=true";
            path = "assets/pins/pin-TLTR.svg";
            token = "\${{ secrets.GITHUB_TOKEN }}";
          };
        }
        {
          name = "Generate pin: CARLA-Autonomous-Driving";
          uses = "stats-organization/github-readme-stats-action@v2";
          "with" = {
            card = "pin";
            options = "username=\${{ github.repository_owner }}&repo=CARLA-Autonomous-Driving&title_color=58A6FF&text_color=8B949E&icon_color=79C0FF&bg_color=0D1117&border_color=30363D&border_radius=6&hide_border=false&show_owner=false&show_icons=true";
            path = "assets/pins/pin-CARLA-Autonomous-Driving.svg";
            token = "\${{ secrets.GITHUB_TOKEN }}";
          };
        }
        {
          name = "Commit stats cards";
          uses = "stefanzweifel/git-auto-commit-action@v5";
          "with" = {
            commit_message = "Update stats cards - [Skip GitHub Action]";
            file_pattern = "assets/*.svg assets/pins/*.svg";
            commit_user_name = "github-actions";
            commit_user_email = "github-actions@users.noreply.github.com";
          };
        }
      ];
    };
  };
}
