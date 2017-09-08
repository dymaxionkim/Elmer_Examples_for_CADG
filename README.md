# Elmer_Examples_for_CADG

__Elmer FEM Examples for CAD&Graphics__

![cadg_02_elmer_install_09](https://user-images.githubusercontent.com/12775748/30211014-1f710be8-94da-11e7-9d9c-0799f07d506c.png)

## 1. 개요(Intro)

* 2017년도 CAD&Graphics 연재 기고문에 필요한 보조 자료 모음.
* "엘머로 해 보는 오픈소스 엔지니어링"
* [파일 다운로드](https://github.com/dymaxionkim/Elmer_Examples_for_CADG)


## 2. 설치(Installation)

### (1) 개요
* 윈도OS PC에서 엔지니어링 연습용 리눅스 가상머신을 설치하는 것이 목표
* 쉘스크립트로 필요한 소프트웨어와 환경을 자동으로 구성하도록 하여 최대한 신속하게 완료하도록 하려는 의도

### (2) 요구조건(Pre-Requisites)
* 가급적 속도가 좋은 인터넷에 연결되어 있을 것. (많은 다운로드가 있기 때문)
* PC의 CPU는 가급적 4스레드 이상 지원할 것. (계산작업시 멀티코어 연산이 유리함)
* PC의 메모리는 8GB 이상일 것. (가상머신에 최소한 4GB 이상 할당하는 것이 좋음)
* PC에서 가상머신을 위해 80~100GB 정도의 하드디스크 여유 용량을 마련해 둔다.

### (3) 버츄얼박스(VirtualBox) 및 루분투(Lubuntu)설치
* [버츄얼박스 홈페이지](https://www.virtualbox.org/wiki/Downloads)로 가서 최신버전의 'Windows hosts' 바이너리설치파일을 다운로드 받아, 실행시켜 설치한다.
* [osboxes 홈페이지](http://www.osboxes.org/lubuntu/)로 가서 `Lubuntu 16.04.2 Xenial Xerus VirtualBox (VDI) 64bit` 파일을 다운로드 받는다(17.04 이후 버전은 안됨. 32비트 버전도 안됨.).
* 버츄얼박스를 실행시키고, '새로만들기' 버튼을 누른 후, 다운로드 받은 가상머신 파일을 연결해서 가상머신을 셋팅한다.
* 이때 가상머신의 CPU 코어는 가급적 2개 이상 할당해 주고, RAM은 가급적 4096MB 이상 할당해 준다.  네트워크는 '브리지'로 선택해 준다.
* 구축된 가상머신을 시작한다.  가상머신이 부팅되면 로그인 비밀번호는 'osboxes.org'를 쳐 준다(로그인한 후 편한걸로 바꾸면 된다).

### (4) Github에 있는 참고자료 받기
* `Ctrl+Alt+t` 단축키를 눌러 터미널을 열고 다음 명령을 수행한다.

```bash
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install git
mkdir /home/osboxes/github
cd /home/osboxes/github
git clone https://github.com/dymaxionkim/Elmer_Examples_for_CADG.git
```

### (5) 자동 어플리케이션 설치 및 환경설정 작업 수행
* 먼저 버츄얼박스 메뉴의 '장치'에서 '게스트 확장 CD 이미지 삽입'을 선택해 준다. (버츄얼박스 게스트에디션을 설치할 수 있도록 가상CD를 삽입하는 것)  이것을 생략해서 게스트 확장을 설치하지 않을 경우에는, 호스트 윈도OS 쪽 하드디스크 자동 마운트 기능이나 화면 사이즈 변경시 자동 해상도 변경 등의 편리한 기능을 이용할 수 없다.
* 터미널에서 다음 명령을 계속 이어서 수행한다.

```bash
cd /home/osboxes/github/Elmer_Examples_for_CADG/CADG_02_Elmer_Install
chmod +x ./AutoSetup.sh
sudo sh AutoSetup.sh
```

* 이제 다 될 때 까지 한참 기다린다.  다운로드 속도에 따라 2시간 이상 걸릴 수 있다.  필자의 경우, 약 1시간 20분 가량 소요되었다.
* 이상없이 완료되면, 가상머신을 재부팅한다.
* 재부팅을 하면, 로케일을 한국으로 변경했기 때문에 사용자의 기본 디렉토리들의 명칭을 한국어로 변경할 것인지 묻는 창이 나온다.  가급적 영문 디렉토리 명칭을 사용하는 것이 불필요한 문제를 피할 수 있기 때문에 'Keep Old Names'를 선택한다.
* 재부팅 후에 다음 명령으로 사용되지 않는 불필요한 패키지를 제거하여 용량을 조금 줄일 수 있다.

```bash
sudo apt -y autoremove
```

* 시스템 관련 정보를 얻으려면 다음 명령들을 사용해 본다.

```bash
df -h
free -m
htop
```

* 한글입력기는 Nimf를 사용하고 있는데, 한영변환키 변경 등의 추가적인 설정을 하려면 터미널에서 `nimf-settings` 명령을 사용하면 된다.
* 기타 데스크탑 테마, 폰트 등을 마음에 드는 것으로 설정해 준다.  본 편에서 권장하는 폰트는, 일반용으로 'Noto Sans CJK KR' 및 고정폭 코딩용으로는 'D2 Coding'이다.
* 이제 현재 상태를 가상머신 '머신' 메뉴에서 '스냅샷 찍기'로 해서 보존해 둔다.  나중에 시스템에 문제가 생기면 이것으로 되돌릴 수 있다.
* 진행 도중 이상이 발견되면, 다음의 이슈트래커에 코멘트하여 문의를 바란다.

```
https://github.com/dymaxionkim/Elmer_Examples_for_CADG/issues
```

### 감사합니다!
