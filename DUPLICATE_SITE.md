# Duplicate This Site As `msdm`

This repo is your GitHub user site (`cerencodes.github.io`), so the duplicate should be a separate repository named `msdm`.

That means the URLs will be:

- Current site: `https://cerencodes.github.io/`
- Duplicate site: `https://cerencodes.github.io/msdm/`

## Fastest Path

1. Run the scaffold script from this repo root:

```powershell
.\scripts\new-website-copy.ps1
```

2. Create a new GitHub repository named `msdm`.
3. In the new `msdm` folder:
   - review `_quarto.yml`
   - delete or replace any post folders under `posts/`
   - render the site
4. Push the new folder to the new `msdm` repository.
5. Enable GitHub Pages for the `msdm` repository.

## What The Script Does

- Copies this repo to a sibling folder named `msdm`
- Excludes local/build artifacts:
  - `.git`
  - `.quarto`
  - `.Rproj.user`
  - `_site`
  - `_freeze`
- Updates `_quarto.yml` to use:
  - `title: "MSDM"`
  - `description: "The MSDM website"`
  - `site-url: https://cerencodes.github.io/msdm/`

## After Copying

Open the new repo folder and edit the content you want to change:

- top-level pages: `index.qmd`, `projects.qmd`, `resume.qmd`
- posts: `posts/*/index.qmd`

The listing page in `projects.qmd` automatically shows whatever is inside `posts/`, so replacing post folders there is usually enough.

## Suggested Next Commands

From the new `msdm` folder:

```powershell
quarto render
git init
git add .
git commit -m "Initial msdm site"
git branch -M main
git remote add origin https://github.com/cerencodes/msdm.git
git push -u origin main
```

## Important Note

If you want `msdm` at a root URL like `https://msdm.github.io/`, that requires either:

- a GitHub account/org named `msdm`, or
- a custom domain

With your current account, the normal GitHub Pages result is `https://cerencodes.github.io/msdm/`.
