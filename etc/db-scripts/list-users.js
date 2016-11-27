// Use: mongo fonoster -u fonoster -p "password" --quiet emails.js > emails.txt

var cursor = db.User.find({}, {email: 1, firstName: 1, lastName: 1});

while(cursor.hasNext()){
    var user = cursor.next();
    print(user._id, ",", user.firstName, ",", user.lastName);
}
