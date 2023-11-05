#!/bin/bash

echo パスワードマネージャーへようこそ!
#鍵を作成
`gpg --yes --passphrase=pass --armor --output key.txt --export USER-NAME >/dev/null`

#暗号解除して元のファイルに戻す（テキストファイル化)
`gpg --yes --passphrase=pass --decrypt-files password_db.txt.gpg 2>/dev/null`

while :
do

  echo -n "次の選択肢から入力してください( Add Password/Get Password/Exit )":
  read selectMode

  if [ "$selectMode" = "Add Password" ];then
    echo -n サービス名を入力してください：
    read serviceName

    echo -n ユーザー名を入力してください：
    read userName

    echo -n パスワードを入力してください：
    read password

    echo

    echo $serviceName:$userName:$password>>password_db.txt

  elif [ "$selectMode" = "Get Password" ];then
    echo -n サービス名を入力してください:
    read selectServiceName
    getData=`grep -m 1 -e "^$selectServiceName:*" password_db.txt`
    if [ $? = 0 ] ;then
      serviceName=`echo $getData | cut -f 1 -d ":"`
      userName=`echo $getData | cut -f 2 -d ":"`
      password=`echo $getData | cut -f 3 -d ":"`
      echo "サービス名:$serviceName"
      echo "ユーザー名:$userName"
      echo "パスワード:$password"

    else
      echo そのサービスは登録されていません。
    fi

  elif [ "$selectMode" = "Exit" ];then
    echo 終了します
    echo Thank you!
    break

  else
    echo 入力が間違えています。Add Password/Get Password/Exit から入力してください
  fi

done

#ファイルを暗号化
`gpg --yes --passphrase=pass --recipient USER-NAME --output password_db.txt.gpg --encrypt password_db.txt`

#暗号化していないテキストファイルを削除
`rm -rf password_db.txt`

#鍵を削除
`rm -rf key.txt`
