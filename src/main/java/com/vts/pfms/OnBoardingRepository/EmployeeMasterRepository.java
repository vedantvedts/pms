package com.vts.pfms.OnBoardingRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vts.pfms.master.model.Employee;

public interface EmployeeMasterRepository extends JpaRepository<Employee, Long> {

}
