print("Welcome to the sql generator!")

state_Abbrev = {
    'AL': 'Alabama',
    'AK': 'Alaska',
    'AS': 'American Samoa',
    'AZ': 'Arizona',
    'AR': 'Arkansas',
    'CA': 'California',
    'CO': 'Colorado',
    'CT': 'Connecticut',
    'DE': 'Delaware',
    'DC': 'District of Columbia',
    'FM': 'Federated States of Micronesia',
    'FL': 'Florida',
    'GA': 'Georgia',
    'GU': 'Guam',
    'HI': 'Hawaii',
    'ID': 'Idaho',
    'IL': 'Illinois',
    'IN': 'Indiana',
    'IA': 'Iowa',
    'KS': 'Kansas',
    'KY': 'Kentucky',
    'LA': 'Louisiana',
    'ME': 'Maine',
    'MH': 'Marshall Islands',
    'MD': 'Maryland',
    'MA': 'Massachusetts',
    'MI': 'Michigan',
    'MN': 'Minnesota',
    'MS': 'Mississippi',
    'MO': 'Missouri',
    'MT': 'Montana',
    'NE': 'Nebraska',
    'NV': 'Nevada',
    'NH': 'New Hampshire',
    'NJ': 'New Jersey',
    'NM': 'New Mexico',
    'NY': 'New York',
    'NC': 'North Carolina',
    'ND': 'North Dakota',
    'MP': 'Northern Mariana Islands',
    'OH': 'Ohio',
    'OK': 'Oklahoma',
    'OR': 'Oregon',
    'PW': 'Palau',
    'PA': 'Pennsylvania',
    'PR': 'Puerto Rico',
    'RI': 'Rhode Island',
    'SC': 'South Carolina',
    'SD': 'South Dakota',
    'TN': 'Tennessee',
    'TX': 'Texas',
    'UT': 'Utah',
    'VT': 'Vermont',
    'VI': 'Virgin Islands',
    'VA': 'Virginia',
    'WA': 'Washington',
    'WV': 'West Virginia',
    'WI': 'Wisconsin',
    'WY': 'Wyoming'
}

print("We will generate the sql query you need for you:)")
f = 0
while 1:
    st = ''
    if f <= 1:
        date_b = ''
        date_e = ''
        print("Do you want to find data in a certain date range?(Y/N)")
        st = input()
        if st == 'Y':
            print("What begin date you want search, please enter in format 'year-month-day',type '#' to go back:")
            date_b = input()
            if date_b == '#':
                f = 1
                continue
            print("What end date you want search, please enter in format 'year-month-day',type '#' to go back:")
            date_e = input()
            if date_e == '#':
                f = 1
                continue
        elif st != 'N':
            print("Wrong input, please try again!")
            f = 1
            continue

    if f <= 2:
        state = ''
        print("Do you want to find data in a certain state?(Y/N)")
        st = input()
        if st == 'Y':
            print("What date you want search, please enter abbreviation with capital,type '#' to go back:")
            state = input()
            if state == '#':
                f = 2
                continue
            if not state in state_Abbrev:
                print("Wrong abbreviation,please check again!")
                f = 2
                continue
            state = state_Abbrev.get(state)

        elif st != 'N':
            print("Wrong input, please try again!")
            f = 2
            continue

    if f <= 3:
        sex = ''
        print("Do you want to find data in a certain gender?(Y/N)")
        st = input()
        if st == 'Y':
            print("What date you want search, please enter 'f' for female and 'm' for male,type '#' to go back:")
            sex = input()
            if sex == '#':
                f = 3
                continue
            if sex != 'f' and sex != 'm':
                print("Wrong input, please try again!")
                f = 3
                continue
        elif st != 'N':
            print("Wrong input, please try again!")
            f = 3
            continue
    break

flag = 0
mysql = "Select * From unified_view Where"
if date_b != "":
    mysql += " date >= "
    mysql += "'" + date_b + "'"
    mysql += " and date <= "
    mysql += "'" + date_e + "'"
    flag = 1
if sex != "":
    if flag > 0:
        mysql += " and "
    mysql += " sex = "
    if sex == 'f': sex = 'Female'
    else: sex = 'Male'
    mysql += "'" + sex + "'"
    flag = 1
if state != "":
    if flag > 0:
        mysql += " and "
    mysql += " state = "
    mysql += "'" + state + "'"

mysql += " limit 1000;"
print(mysql)
