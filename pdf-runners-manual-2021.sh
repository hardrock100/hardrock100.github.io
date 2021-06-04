# Note that .sh scripts work only on Mac. If you're on Windows, install Git Bash and use that as your client.

echo 'Kill all Jekyll instances'
kill -9 $(ps aux | grep '[j]ekyll' | awk '{print $2}')
clear

echo "Building PDF-friendly HTML site for Runners Manual 2021 ...";
bundle exec jekyll serve --detach --config _config.yml,pdfconfigs/config_runners_manual_2021_pdf.yml;
echo "done";

echo "Building the PDF ...";
prince --javascript --input-list=_site/pdfconfigs/runners-manual-2021-list.txt -o pdf/runners_manual_2021.pdf;

echo "Done. Look in the pdf directory to see if it printed successfully."
