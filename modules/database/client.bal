import ballerinax/mysql;
import ballerinax/mysql.driver as _;

final mysql:Client UserPortalDb = check new ("localhost", "root", "root", "bal", 3306);
