# Keep-Alive Workflow Prompt

Use this prompt for an AI assistant that edits the GitHub Actions workflow:

> Update the existing `supabase-keep-alive.yml` workflow so it keeps the repository active without creating CI noise. The workflow should:
> - run on the existing schedule and manual dispatch trigger,
> - check the age of the latest commit,
> - create an empty commit only when the repo is close to the 60-day inactivity limit,
> - include `[skip ci]` in the empty commit message so other workflows do not trigger,
> - push the commit back to the default branch using `GITHUB_TOKEN`,
> - keep the Supabase ping step intact.
>
> Prefer a safe threshold below 60 days, such as 55 days, because the schedule only runs every few days and should act before GitHub disables scheduled workflows for inactivity.