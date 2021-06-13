FROM legionio/legion:latest
LABEL maintainer="Matthew Iverson <matthewdiverson@gmail.com>"

RUN gem install lex-redis --no-document --no-prerelease
CMD ruby --jit $(which legionio)
