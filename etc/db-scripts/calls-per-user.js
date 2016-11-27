print ("Calls per user");

var users = db.User.find({}, {email:1});

while(users.hasNext()) {
    var user = users.next();
    var accounts = db.Account.find({"user" : DBRef("User", user._id)}) ;

    while(accounts.hasNext()) {
        var account = accounts.next();
        var cnt = db.CallDetailRecord.count({"account" : DBRef("Account", account._id)}) ;

        if (cnt > 0) print("user: " + user._id + ", call cnt: " + cnt);
    }
}