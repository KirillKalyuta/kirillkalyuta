trigger ChangeId on Task (before  insert, before update) {
	TasksAssignmentClass.reassignRecords2NewUsers(Trigger.new);
}