#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

for i in "$@"; do
  case $i in
  --version=*)
    VERSION="${i#*=}"
    shift # past argument=value
    ;;
  --libsass=*)
    LIBSASS_VERSION="${i#*=}"
    shift # past argument=value
    ;;
  --sassc=*)
    SASSC_VERSION="${i#*=}"
    shift # past argument=value
    ;;
  --tag=*)
    TAG="${i#*=}"
    shift # past argument=value
    ;;
  --namespace=*)
    NAMESPACE="${i#*=}"
    shift # past argument=value
    ;;
  --help)
    echo -e "" \
    "SYNOPSIS\n" \
    "       update.sh OPTIONS\n\n" \
    "       update.sh --help\n\n" \
    "OPTIONS\n" \
    "       --help\n" \
    "         Print usage statement \n\n" \
    "       --version=[x.y], --version=[x.y.z]\n" \
    "         Specify the semantic version of SassC/LibSass to build from.\n" \
    "         Also used to determine the path to the Dockerfile and used as\n" \
    "         the tag.\n\n" \
    "       --libsass=[x.y], --libsass=[x.y.z]\n" \
    "         Override the --version of LibSass used to build.\n\n" \
    "       --sassc=[x.y], --sassc=[x.y.z]\n" \
    "         Override the --version of SassC used to build.\n\n" \
    "       --tag=[x.y], --tag=[x.y.z], --tag=[tagname]\n" \
    "         Specify the semantic version or name to build the image's tag with.\n\n" \
    "       --namespace=[namespace]\n" \
    "         Specify the Docker Hub namespace to build the image under." \
    | less
    exit 0
    ;;
  *)
    >&2 echo "Unknown option \"${i#*=}\", try \`update --help\`"
    exit 1
    ;;
  esac
done

if [ -z ${VERSION+set} ]; then
  >&2 echo "Supply the SassC version desired with --version=x.y.z"
  exit 1
fi

if [[ "$VERSION" =~ ^([0-9]*)\.([0-9]*)(\.([0-9]+((-|.)[^ ]*)?)|)?$ ]]; then
  MAJOR_VERSION="${BASH_REMATCH[1]}"
  MINOR_VERSION="${BASH_REMATCH[2]}"
  PATCH_VERSION="${BASH_REMATCH[4]}"
else
  >&2 echo "--version must be a semantic version in the format x.y or x.y.z"
  exit 1
fi

LIBSASS_VERSION="${LIBSASS_VERSION:-${VERSION}}"
SASSC_VERSION="${SASSC_VERSION:-${VERSION}}"
NAMESPACE="${NAMESPACE:-codycraven}"
if [[ -z ${PATCH_VERSION-unset} ]]; then
  TAG="${TAG:-`echo $MAJOR_VERSION.$MINOR_VERSION`}"
else
  TAG="${TAG:-`echo $MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION`}"
fi

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")/$MAJOR_VERSION.$MINOR_VERSION"
docker build \
  --build-arg LIBSASS_VERSION="$LIBSASS_VERSION" \
  --build-arg SASSC_VERSION="$SASSC_VERSION" \
  -t "$NAMESPACE"/sassc:"$TAG" \
  .
