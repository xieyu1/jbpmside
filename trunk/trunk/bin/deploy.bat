call mvn clean
call mvn compile
call mvn dependency:copy-dependencies -DoutputDirectory=../modules/console/gui/war/src/main/webapp/WEB-INF/lib  -DincludeScope=runtime
pause