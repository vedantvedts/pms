package com.vts.pfms.ms.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vts.pfms.master.model.Employee;

public interface EmployeeRepo extends JpaRepository<Employee, Long> {

}
