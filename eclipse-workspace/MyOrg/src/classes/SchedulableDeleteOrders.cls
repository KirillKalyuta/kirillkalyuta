global class SchedulableDeleteOrders implements Schedulable {
   global void execute(SchedulableContext sc) {
     DeleteOrders cr = new DeleteOrders();
      database.executebatch(cr);
   }
}