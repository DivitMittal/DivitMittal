{...}: {
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
          uses = "readme-tools/github-readme-stats-action@v1";
          "with" = {
            card = "top-langs";
            options = "username=\${{ github.repository_owner }}&langs_count=14&theme=transparent&hide_progress=true&show_icons=true&hide_border=true";
            path = "top-langs.svg";
            token = "\${{ secrets.GITHUB_TOKEN }}";
          };
        }
        {
          name = "Commit stats cards";
          uses = "stefanzweifel/git-auto-commit-action@v5";
          "with" = {
            commit_message = "Update stats cards - [Skip GitHub Action]";
            file_pattern = "*.svg";
            commit_user_name = "github-actions";
            commit_user_email = "github-actions@users.noreply.github.com";
          };
        }
      ];
    };
  };
}