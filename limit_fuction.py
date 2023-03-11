def limitSql(mysql):
    p_limit = mysql.casefold().find("limit")
    p_end = mysql.find(";")
    if p_limit > 0:
        mysql = mysql[:p_limit:]
        mysql += " limit 10;"
    else:
        mysql = mysql[:p_end:]
        mysql += " limit 10;"
    print(mysql)
    return mysql
