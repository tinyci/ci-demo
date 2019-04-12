#!bash
 
if [ "x${GITHUB_TOKEN}" = "x" ]
then
  echo >&2 "Please enter your github token that tinyCI can use to:"
  echo >&2 "  - Enable repositories and add CI hooks"
  echo >&2 "  - Perform operations like cloning repositories and"
  echo >&2 "    reading from them through the API"
  echo >&2 "Otherwise, press ^C to discontinue."
  echo >&2
  echo >&2 "NOTE: the demo does not cover OAuth Installations: please consult"
  echo >&2 "with http://docs.tinyci.org on how to set up a OAuth instance."
  read GITHUB_TOKEN
fi

if [ "x${UI_ENDPOINT}" = "x" ]
then
  echo >&2 "Please enter a URL to an endpoint reachable from external to your network,"
  echo >&2 "so that github can reach it."
  echo >&2 "Note that in a production installation, that the UI and hook"
  echo >&2 "services can be deployed independently and do not suffer this limitation. See"
  echo >&2 "http://docs.tinyci.org for more."
  echo >&2

  read UI_ENDPOINT
fi

if [ "x${SESSION_CRYPT_KEY}" = "x" ]
then
  export SESSION_CRYPT_KEY=$(xxd -ps -l 32 /dev/urandom | perl -e 'undef $/; print join("", split(/\n/, <>));')
fi

echo -n >&2 "Editing configuration file..."

cp services.yaml.tmpl services.yaml
sed -i -e "s!@GITHUB_TOKEN@!${GITHUB_TOKEN}!g" services.yaml
sed -i -e "s!@SESSION_CRYPT_KEY@!${SESSION_CRYPT_KEY}!g" services.yaml
sed -i -e "s!@UI_ENDPOINT@!${UI_ENDPOINT}!g" services.yaml

echo >&2 "done."
