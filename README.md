6조 프로젝트. 
가계부

git build 순서


1. 이클립스 실행
2. File - Open Project From File System 선택
3. Git 폴더 위치 선택 -> Finish
4. Ctrl+N 서버 생성, apache-tomcat-9.0(수업 시간에 한 것 그대로 생략.. ) 
4. 프로젝트 우클릭 - Properties 클릭
5. 'Project Facets'에서
  - Dynamic Web Module 선택, Version 4.0 체크 
  - Java, Version 21로 변경
  - JavaScript 선택 Version 1.0 체크
  - Dynamic Web Module 선택, 우측에 Runtimes 클릭하고 apach-tomcat 선택
Apply - Apply and Close

6. WEB-INF-lib 폴더에 jar 파일 붙여넣기 
7. 메뉴에서 Project - clean 실행
8. Run as Server로 실행

