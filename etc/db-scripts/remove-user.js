/**
 * Purges a user with all its documents
 * It will not delete Recordings or CDRs
 */
var userId="sanderspedro@gmail.com";

db.App.remove({user: DBRef("User", userId)});
db.PhoneNumber.remove({user: DBRef("User", userId)});
db.Activity.remove({user: DBRef("User", userId)});
db.Account.remove({user: DBRef("User", userId)});
db.User.remove({_id:userId});