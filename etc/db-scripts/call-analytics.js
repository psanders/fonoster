var calls = db.CallDetailRecord.find({"app" : DBRef("App", ObjectId("5815441a3f481800a2abc2f9"))});

var total = 0;
var completed = 0;
var engaged = 0;
var doNotCall = 0;

while(calls.hasNext()) {
    var call = calls.next();
 
    // Calling my self does not count :P
    if (call.to == '+17853178070') continue;
    if (call.duration > 0) completed += 1;
    if (call.vars && call.vars.select && call.vars.select == 1)  engaged += 1;
    if (call.vars && call.vars.select && call.vars.select == 5)  doNotCall += 1;
    total += 1;
}

print ("Call Analytics:");
print('Total: ' + total);
print('Completed: ' + Math.round(100 * completed / total) + '%');
print('Engaged: ' + Math.round(100 * engaged / completed) + '%');
print('Dont call again: ' +  Math.round(100 * doNotCall / completed) + '%');
