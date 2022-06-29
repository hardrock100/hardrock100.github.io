# Hardrock Hundred Manuals and Documentation

This is a GitHub Pages site for manuals and other documentation related to the Hardrock Hundred Endurance Run.

The website is located at https://hardrock100.github.io

The primary site for the Hardrock Hundred is located at https://hardrock100.com

### Additions and Changes

Make additions and changes to the site by submitting a Pull Request. You can do this directly from
GitHub by following these steps:

1. You can't make changes directly to the master branch, so first you'll need to make a new branch.
   Follow the [GitHub documentation](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-and-deleting-branches-within-your-repository#creating-a-branch)
   to make a new branch.

2. Add or edit files [like this](https://docs.github.com/en/github/managing-files-in-a-repository/editing-files-in-your-repository).

3. Commit your changes.

4. If you need to add an image, [upload it](https://docs.github.com/en/github/managing-files-in-a-repository/adding-a-file-to-a-repository)
   and again commit changes.

5. Go back to the main repository page and make a Pull Request.

6. Name your Pull Request and submit it.

7. Ask another collaborator to review and approve your changes.

8. Once your Pull Request is approved, merge it into the master branch. Once merged, your branch will be automatically
   deleted.

9. Within a short time (generally 30 to 60 seconds) your changes should be available on the site.
   Verify things look how you expected. If anything doesn't look right, repeat the above steps and fix it.

### Running the Site Locally

It is not necessary to run the site locally, but if you would like to do so, follow these steps:

1. Install Ruby and Jekyll (https://jekyllrb.com/docs/installation/)
2. Clone this repo:
   ```bash
   git clone https://github.com/hardrock100/hardrock100.github.io.git
   ```

3. Change into the repo directory
   ```bash
   cd hardrock100.github.io
   ```

4. Run the Jekyll server
   ```bash
   jekyll serve
   ```

5. Open a browser and visit localhost:4000

### Generating a PDF Version

It is convenient to provide a PDF version of the Runner's Manual for a given year. To do so, you will need to either
use a browser to print a compilation page or use a PDF generator like Prince to produce the PDF file directly.

#### Use a browser to print a compilation page

1. Manually build a compilation page that you can add to your markdown, and name it something like `compilation.md`:

```md
<embed type="text/html" src="https://hardrock100.github.io/" width="100%" height="700px">
<embed type="text/html" src="https://hardrock100.github.io/docs/runners_manual/rules/" width="100%" height="370px">
<embed type="text/html" src="https://hardrock100.github.io/docs/runners_manual/course/course/" width="100%" height="1000px">
```

You will need to manually set the height of each page to create proper spacing on the page. Some trial and error will be
required.

2. Load the page in your browser and print it to a PDF file. As of this writing (June 2022) Safari and Firefox produced
   the best output, but that may change with newer versions.
3. Move the generated PDF file to the `/pdf` directory.
4. Change the "Download PDF" button link to reference the new PDF file.

#### Use Prince to generate the PDF file

1. Get the site running locally as described in the section above
2. Add a `.yml` config file to the `/pdfconfigs` directory that looks something like this:

```yaml
# pdfconfigs/config_example_pdf.yml

destination: _site/
url: "http://127.0.0.1:4010"
port: 4010
print_title: Hardrock Hundred Endurance Run - Runners Manual 2022
```

3. Add a plain text file that lists, in order, the `html` files that you want compiled into the PDF. That file should be
   named to reflect the PDF document that will result (like `example-file-list.txt`), and it should look something like
   this:

```text
---
layout: none
search: exclude
---

http://localhost:4010/index.html
http://localhost:4010/docs/runners_manual/runners_manual/index.html
http://localhost:4010/docs/runners_manual/rules/index.html
http://localhost:4010/docs/runners_manual/schedule/index.html
http://localhost:4010/docs/runners_manual/course/course/index.html
```

Note that these are references to the `.html` files in your `_site/docs` directory, *not* to the `.md` files in your
root-level `/docs` directory.

4. Add a shell script in the root level that looks something like this:

```bash
# generate-pdf-example.sh
# Note that .sh scripts work only on Mac. If you're on Windows, install Git Bash and use that as your client.

echo 'Kill all Jekyll instances'
kill -9 $(ps aux | grep '[j]ekyll' | awk '{print $2}')
clear

echo "Building PDF-friendly HTML site for Example File...";
bundle exec jekyll serve --detach --config _config.yml,pdfconfigs/config_example_pdf.yml;
echo "done";

echo "Building the PDF ...";
prince --javascript --input-list=_site/pdfconfigs/example-file-list.txt -o pdf/example_output_file.pdf;

echo "Done. Look in the pdf directory to see if it printed successfully."
```

5. If you haven't already, install the Prince PDF generator

```bash
brew install prince
```

6. Make sure your shell script is executable from your terminal:

```bash
sudo chmod +x generate-pdf-example.sh
```

7. And then run the executable file:

```bash
generate-pdf-example.sh
```

8. Check the `/pdf` directory for your output PDF file. Tweak the file list and regenerate if needed.
9. Change the "Download PDF" button to point to the generated PDF file.
