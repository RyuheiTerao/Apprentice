#!/bin/bash

echo パスワードマネージャーへようこそ!


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
