//In this example it will create 2 files seperately for logging two different messages

class test1 extends uvm_test;
 `uvm_component_utils(test1)

int file, file2;

 function new(string name, uvm_component parent);
  super.new(name, parent);
 endfunction

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
 endfunction

 function void start_of_simulation();
  uvm_top.print_topology();

  //uvm_error and uvm_info are logged in to 2 different files
  file = $fopen("logfile", "w");
  file2 = $fopen("logfile1", "w");
  
  // Check if file handles are valid
  if (file == 0) begin
    `uvm_error("test1", "Failed to open logfile");
  end
  if (file2 == 0) begin
    `uvm_error("test1", "Failed to open logfile1");
  end
  
  set_report_severity_file_hier(UVM_INFO, file);
  set_report_severity_file_hier(UVM_ERROR, file2);
  set_report_severity_action(UVM_INFO, UVM_LOG+UVM_DISPLAY);
  set_report_severity_action(UVM_ERROR, UVM_LOG+UVM_DISPLAY);

 endfunction

 task run_phase(uvm_phase phase);
  super.run_phase(phase);

  phase.raise_objection(this);

   `uvm_info(get_name(), " called", UVM_MEDIUM);
   `uvm_info(get_name(), "info1 called", UVM_MEDIUM);
   `uvm_info(get_name(), "info2 called", UVM_MEDIUM);
   `uvm_info(get_name(), "info3 called", UVM_MEDIUM);
   `uvm_info(get_name(), "info4 called", UVM_MEDIUM);
   `uvm_info(get_name(), "info5 called", UVM_MEDIUM);
   `uvm_info(get_name(), "info6 UVM HIGH called", UVM_HIGH);
   `uvm_info(get_name(), "info7 UVM DEBUG called", UVM_DEBUG);
   `uvm_error("test1", "error1 display");
   `uvm_error("test1", "error2 display");
   `uvm_error("test1", "error3 display");
   `uvm_error("test1", "error4 display");
  
  phase.drop_objection(this);

 endtask

 function void report_phase(uvm_phase phase);
  super.report_phase(phase);
  // Close file handles to ensure proper cleanup and prevent corruption
  if (file != 0) begin
    $fclose(file);
    `uvm_info("test1", "Closed logfile", UVM_LOW);
  end
  if (file2 != 0) begin
    $fclose(file2);
    `uvm_info("test1", "Closed logfile1", UVM_LOW);
  end
 endfunction

endclass
