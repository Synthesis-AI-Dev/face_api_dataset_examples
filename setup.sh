TMPDIR=$(mktemp -d)

curl -o "${TMPDIR}/requirements.txt" https://raw.githubusercontent.com/Synthesis-AI-Dev/face_api_dataset_examples/main/requirements.txt
pip install -Ur "${TMPDIR}/requirements.txt"
rm -rf $TMPDIR

[ -d test_dataset ]
DIR1_EXISTS=$?

[ -d test_dataset2 ]
DIR2_EXISTS=$?

if  [ $DIR1_EXISTS -ne 0 ] || [ $DIR2_EXISTS -ne 0 ]
then

  (git lfs install > /dev/null)
  if [ $? -eq 0 ]
  then
      echo "git lfs is already installed"
  else
      echo "installing git lfs"
      case "$(uname -s)" in

         Darwin)
           brew install git-lfs
           ;;

         Linux)
           curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
           apt-get install git-lfs
           ;;

         *)
           echo "This script can't install git lfs your OS. Please take care of it yourself."
           ;;
      esac
  fi

  CDIR=$(pwd)
  TMPDIR=$(mktemp -d)
  cd $TMPDIR
  git clone https://github.com/Synthesis-AI-Dev/face_api_dataset_examples.git --depth 0
  if [ $DIR1_EXISTS -ne 0 ]
  then
    cp -r test_dataset $CDIR/test_dataset
  fi
  if [ $DIR1_EXISTS -ne 0 ]
  then
    cp -r test_dataset_2 $CDIR/test_dataset_2
  fi
  cd $CDIR
  rm -r $TMPDIR
fi

