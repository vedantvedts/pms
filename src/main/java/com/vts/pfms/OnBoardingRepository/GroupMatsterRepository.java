package com.vts.pfms.OnBoardingRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vts.pfms.master.model.DivisionGroup;

public interface GroupMatsterRepository extends JpaRepository<DivisionGroup, Long> {

}
