FROM adinriv/docker-texlive

# we additionally need latexmk, python, java (because of pax), perl (because of pax), pdftk, ghostscript, and unzip (because of pax)
RUN apt-get update -qq && apt-get upgrade -qq && \
    apt-get install -y --no-install-recommends latexmk python2.7 openjdk-8-jre-headless libfile-which-perl pdftk ghostscript unzip && \
    apt-get install -y python-pip && \
    rm -rf /var/lib/apt/lists/*

# update texlive
RUN tlmgr update --self --all --reinstall-forcibly-removed

# Add additional packages
RUN tlmgr install collection-german

# Prepare usage of pax
RUN mkdir /root/.texlive2017 && perl `kpsewhich -var-value TEXMFDIST`/scripts/pax/pdfannotextractor.pl --install

# Enable using the scripts of https://github.com/gi-ev/LNI-proceedings
RUN pip install pyparsing && pip install python-docx

WORKDIR /home
